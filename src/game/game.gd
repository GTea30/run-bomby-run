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
var round_score: int = 1000;
var total_score: int = 0;
var first_beep := false;
var second_beep := false;
var paused := false;
var state: GameState = GameState.PLAYING_ROUND:
	set(new_state):
		state = new_state;
		match state:
			GameState.STARTING_ROUND:
				self.label.text = "Round %s\nPress Enter to Continue" % self.round_count;
				self.round_score = 1000;
			GameState.ENDING_ROUND_WIN:
				self.total_score += self.round_score;
				self.round_count += 1;
				self.label.text = "Round Won! Current Score: %s\nPress Enter to Continue" % self.total_score;
				self.set_enemy_pause(true);
			GameState.ENDING_ROUND_LOSS:
				self.label.text = "Game Over Total Score: %s\nPress Enter to return to Title Screen" % self.total_score;
				self.timer.paused = true;
				self.set_enemy_pause(false)
var round_count: int = 1;
var map: Map;
var num_wires := 0;
var wires: Array[Node]

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

	for enemy in self.enemies:
		enemy.set_map(self.map);
		if enemy.request_move.connect(_on_actor_request_move):
			printerr("Enemy: Request Move connection error");

	wires = get_tree().get_nodes_in_group("wires") as Array[Node];
	for wire: Wire in wires:
		wire.player_get_wire.connect(_on_wire_player_get_wire);

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

func _process(delta: float) -> void:
	if self.state == GameState.STARTING_ROUND:
		if Input.is_action_just_pressed("Confirm"):
			self.start_round();
			self.state = GameState.PLAYING_ROUND;
	if self.state == GameState.PLAYING_ROUND:
		if !paused:
			if counting_down:
				var new_text_format: String = "Points: %s, Time remaining: %.2f";
				var new_text: String = new_text_format % [self.round_score, self.timer.time_left];

				self.label.text = new_text;
			else:
				self.label.text = "Points: %s" % self.round_score;
			var current_time: float = self.timer.time_left;
			if !first_beep:
				var diff: float = abs(current_time - 2.0);
				if diff <= 0.01:
					self.play_sfx.emit(SfxAudio.Sfx.COUNTDOWN_BEEP);
					self.first_beep = true;
			if !second_beep:
				var diff: float = abs(current_time - 1.0);
				if diff <= 0.01:
					self.play_sfx.emit(SfxAudio.Sfx.COUNTDOWN_BEEP);
					self.second_beep = true;

			if Input.is_action_just_pressed("Pause"):
				self.open_options.emit();
				self.toggle_pause();
				return

			self.round_score -= 1 * ((delta * 60) as int);

	if self.state == GameState.ENDING_ROUND_WIN:
		if Input.is_action_just_pressed("Confirm"):
			self._reset();
			self.state = GameState.STARTING_ROUND;
	if self.state == GameState.ENDING_ROUND_LOSS:
		if Input.is_action_just_pressed("Confirm"):
			self.change_scene.emit(SceneManager.SceneEnum.START_SCENE);

#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func _on_player_to_explode() -> void:
	self.timer.start();
	self.counting_down = true;
	self.play_sfx.emit(SfxAudio.Sfx.COUNTDOWN_BEEP);
	# self.countdown_beep.play();

func _on_timer_timeout() -> void:
	self.counting_down = false;
	self.state = GameState.ENDING_ROUND_WIN;

func _on_player_caught() -> void:
	self.counting_down = false;
	self.label.text = "You Lose!";
	self.state = GameState.ENDING_ROUND_LOSS;

func _on_wire_player_get_wire() -> void:
	self.num_wires += 1;
	print("Wire Get!");
	print(self.num_wires);
	var min_value := 0.5;
	var log_value: float = log((5.0 - self.num_wires)) / log(10);
	print(log_value);
	var z := 3.576691;
	self.timer.wait_time = min_value + log_value * z;
	print("Time remaining: %s" % self.timer.wait_time);
	pass;

func _reset() -> void:
	self.first_beep = false;
	self.second_beep = false;
	self.timer.stop()
	self.timer.wait_time = 3.0
	self.num_wires = 0;
	self.counting_down = false;
	self.player.reset();
	for enemy in self.enemies:
		enemy.reset();

	for wire: Wire in self.wires:
		wire.toggle_on();

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
	if self.state == GameState.ENDING_ROUND_WIN:
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
