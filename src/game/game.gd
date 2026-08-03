# @tool, @icon, @static_unload
class_name Game
extends SceneNode
# ## doc comment
# ---
# signals
# enums
enum GameState {
	STARTING_ROUND,
	PLAYING_ROUND,
	ENDING_ROUND_WIN,
	ENDING_ROUND_LOSS,
}
# constants
# static variables
# @export variables
@export var enemies: Array[Enemy];
@export var explosion: PackedScene;
# remaining regular variables
var counting_down: bool = false;
var speed_multiplier: int = 1;
var score: int = 0;
var first_beep := false;
var second_beep := false;
var paused := false;
var state_machine: StateMachine;
var round_count: int = 1;
var map: Map;

# @onready variables
@onready var player: Player = $Player;
@onready var timer: Timer = $Timer;
@onready var label: Label = $Label;
@onready var tile_map_layer: MapBG = $TileMapLayer;

@onready var explosion_timer: Timer = $ExplosionTimer;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	var actors: Array[Actor] = self._pack_actors();
	self.map = Map.new(tile_map_layer, actors);
	self.state_machine = StateMachine.new(StartGameState.new(self));

	for enemy in self.enemies:
		enemy.set_map(self.map);
		if enemy.request_move.connect(_on_actor_request_move):
			printerr("Enemy: Request Move connection error");

	if self.explosion_timer.timeout.connect(_on_explosion_timer_timeout):
		print("Explosion Timer: Timeout connect error!");
	if self.player.to_explode.connect(_on_player_to_explode):
		print("Player: To Exploed connect error!");
	if self.timer.timeout.connect(_on_timer_timeout):
		print("Timer: Timeout connect error")
	if self.player.caught.connect(_on_player_caught):
		print("Player: Caught connect error");

	if self.player.request_move.connect(_on_actor_request_move):
		print("Player: Request Move");

	self.set_enemy_pause(true);
	self.player.set_pause(true);

func _process(delta: float) -> void:
	self.state_machine.update_current_state(delta);

#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods

func toggle_pause_poll() -> void:
	if Input.is_action_just_pressed("Pause"):
		self.open_options.emit();
		self.toggle_pause();

func _on_player_to_explode() -> void:
	self.timer.start();
	self.state_machine.remove_current_state();
	self.state_machine.push_state(CountingDownState.new(self));
	self.play_sfx.emit(SfxAudio.Sfx.COUNTDOWN_BEEP);

func _on_timer_timeout() -> void:
	self.counting_down = false;
	self.timer.stop()
	self.timer.wait_time = 3.0
	self.state_machine.remove_current_state();
	self.state_machine.push_state(WinRoundState.new(self));

func _on_player_caught() -> void:
	self.counting_down = false;
	self.label.text = "You Lose!";
	self.state_machine.remove_current_state();
	self.state_machine.push_state(LostRoundState.new(self));

func reset() -> void:
	self.first_beep = false;
	self.second_beep = false;
	self.timer.stop()
	self.timer.wait_time = 3.0
	self.counting_down = false;
	self.player.reset();
	for enemy in self.enemies:
		enemy.reset();
	self.player.bomb_mode = false;
	self.map.set_actors(self._pack_actors());

func start_round() -> void:
	self.player.set_pause(false);
	self.set_enemy_pause(false);

func toggle_pause() -> void:
	self.timer.paused = !self.timer.paused;
	self.paused = !self.paused;
	self.player.toggle_pause();
	for enemy in self.enemies:
		enemy.toggle_pause();

func trigger_explosion() -> void:
	# Spawn explosion sprite at random coords of screen
	var random: RandomNumberGenerator = RandomNumberGenerator.new();
	var x_coord: int = random.randi_range(0, 640)
	var y_coord: int = random.randi_range(0, 360)
	var coord := Vector2i(x_coord, y_coord);

	var new_explosion: AnimatedSprite2D = self.explosion.instantiate();
	if new_explosion.animation_finished.connect(func () -> void: new_explosion.queue_free()):
		print("New Explosion Animation Finish Connect Error");
	new_explosion.position = coord;
	self.add_child(new_explosion);
	new_explosion.play();
	self.play_sfx.emit(SfxAudio.Sfx.EXPLOSION);

func set_enemy_pause(new_paused: bool) -> void:
	for enemy in self.enemies:
		enemy.set_pause(new_paused);

func _on_explosion_timer_timeout() -> void:
	if self.state_machine.get_state() is WinRoundState:
		self.trigger_explosion();

func _pack_actors() -> Array[Actor]:
	var new_actors: Array[Actor] = [];

	new_actors.push_back(player);
	for enemy in self.enemies:
		new_actors.push_back(enemy);

	return new_actors;

func _on_actor_request_move(actor: Actor, dir: Vector2i, callback: Callable) -> void:
	var destination: Vector2i = actor.grid_position + dir;
	if self.map.is_traversable(destination):
		self.map.update_actor_pos(actor, destination);
		callback.call(dir);
		pass;
	else:
		actor.velocity = Vector2.ZERO;

# inner classes
