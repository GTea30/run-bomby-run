# @tool, @icon, @static_unload
class_name Game
extends SceneNode
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
@export var enemies: Array[Enemy];
# remaining regular variables
var counting_down: bool = false;
var speed_multiplier: int = 1;
var score: int = 0;
var first_beep := false;
var second_beep := false;
var paused := false;

# @onready variables
@onready var player: Player = $Player;
@onready var timer: Timer = $Timer;
@onready var label: Label = $Label;

@onready var countdown_beep: AudioStreamPlayer = $CountdownBeep;
@onready var explosion_sfx: AudioStreamPlayer = $Explosion;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.player.to_explode.connect(_on_player_to_explode);
	self.timer.timeout.connect(_on_timer_timeout);
	self.player.caught.connect(_on_player_caught);

func _process(_delta: float) -> void:

	if !paused:
		if counting_down:
			var new_text_format: String = "Points: %s, Time remaining: %s";
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
	self.play_sfx.emit(SfxAudio.Sfx.EXPLOSION);
	# self.explosion_sfx.play();
	self.counting_down = false;
	self._reset();

func _on_player_caught() -> void:
	self.counting_down = false;
	self.label.text = "You Lose!";
	self.change_scene.emit(SceneManager.SceneEnum.START_SCENE)

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
	pass;

func toggle_pause() -> void:
	self.timer.paused = !self.timer.paused;
	self.paused = !self.paused;
	self.player.is_paused = !self.player.is_paused;
	for enemy in self.enemies:
		enemy.paused = !enemy.paused;

# inner classes
