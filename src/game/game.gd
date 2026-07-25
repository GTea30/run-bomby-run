# @tool, @icon, @static_unload
class_name Game
extends SceneNode
# ## doc comment
# ---
# signals
# enums
enum State {
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
var state: State = State.PLAYING_ROUND:
	set(new_state):
		state = new_state;
		match state:
			State.STARTING_ROUND: self.label.text = "Round %s\nPress Enter to Continue" % self.round_count;
			State.ENDING_ROUND_WIN:
				self.label.text = "Round Won!\nPress Enter to Continue";
				self.set_enemy_pause(true);
			State.ENDING_ROUND_LOSS:
				self.label.text = "Game Over Total Score: %s\nPress Enter to return to Title Screen" % self.score;
				self.timer.paused = true;
				self.set_enemy_pause(false)
var round_count: int = 1;

# @onready variables
@onready var player: Player = $Player;
@onready var timer: Timer = $Timer;
@onready var label: Label = $Label;

@onready var explosion_timer: Timer = $ExplosionTimer;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.explosion_timer.timeout.connect(_on_explosion_timer_timeout);
	self.player.to_explode.connect(_on_player_to_explode);
	self.timer.timeout.connect(_on_timer_timeout);
	self.player.caught.connect(_on_player_caught);

func _process(delta: float) -> void:
	if self.state == State.STARTING_ROUND:
		if Input.is_action_just_pressed("Confirm"):
			self.start_round();
			self.state = State.PLAYING_ROUND;
	if self.state == State.PLAYING_ROUND:
		if !paused:
			if counting_down:
				var new_text_format: String = "Points: %s, Time remaining: %.2f";
				var new_text: String = new_text_format % [self.score, self.timer.time_left];

				self.label.text = new_text;
			else:
				self.label.text = "Points: %s" % self.score;
			var current_time: float = self.timer.time_left;
			if !first_beep:
				var diff: float = abs(current_time - 2.0);
				if diff <= 0.01:
					self.play_sfx.emit(SfxAudio.Sfx.COUNTDOWN_BEEP);
					# self.countdown_beep.play();
					self.first_beep = true;
			if !second_beep:
				var diff: float = abs(current_time - 1.0);
				if diff <= 0.01:
					self.play_sfx.emit(SfxAudio.Sfx.COUNTDOWN_BEEP);
					# self.countdown_beep.play();
					self.second_beep = true;

			if Input.is_action_just_pressed("Pause"):
				self.open_options.emit();
				self.toggle_pause();
	if self.state == State.ENDING_ROUND_WIN:
		if Input.is_action_just_pressed("Confirm"):
			self._reset();
			self.state = State.STARTING_ROUND;
	if self.state == State.ENDING_ROUND_LOSS:
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
	# self.explosion_sfx.play();
	self.counting_down = false;
	self.round_count += 1;
	self.state = State.ENDING_ROUND_WIN;

func _on_player_caught() -> void:
	self.counting_down = false;
	self.label.text = "You Lose!";
	self.state = State.ENDING_ROUND_LOSS;

func _reset() -> void:
	self.first_beep = false;
	self.second_beep = false;
	self.timer.stop()
	self.timer.wait_time = 3.0
	self.counting_down = false;
	self.player.reset();
	for enemy in self.enemies:
		enemy.reset();
	self.score += 1;
	self.player.bomb_mode = false;

func start_round() -> void:
	self.player.is_paused = false;
	self.set_enemy_pause(false);

func toggle_pause() -> void:
	self.timer.paused = !self.timer.paused;
	self.paused = !self.paused;
	self.player.is_paused = !self.player.is_paused;
	for enemy in self.enemies:
		enemy.paused = !enemy.paused;

func trigger_explosion() -> void:
	# Spawn explosion sprite at random coords of screen
	var random: RandomNumberGenerator = RandomNumberGenerator.new();
	var x_coord: int = random.randi_range(0, 640)
	var y_coord: int = random.randi_range(0, 360)
	var coord := Vector2i(x_coord, y_coord);

	var new_explosion: AnimatedSprite2D = self.explosion.instantiate();
	new_explosion.animation_finished.connect(func () -> void: new_explosion.queue_free());
	new_explosion.position = coord;
	self.add_child(new_explosion);
	new_explosion.play();
	self.play_sfx.emit(SfxAudio.Sfx.EXPLOSION);

func set_enemy_pause(new_paused: bool) -> void:
	for enemy in self.enemies:
		enemy.paused = new_paused;

func _on_explosion_timer_timeout() -> void:
	if self.state == State.ENDING_ROUND_WIN:
		self.trigger_explosion();

# inner classes
