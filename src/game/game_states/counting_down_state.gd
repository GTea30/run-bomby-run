# @tool, @icon, @static_unload
class_name CountingDownState
extends State
# ## doc comment

# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var game: Game;

# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(init_game: Game) -> void:
	self.game = init_game;
	self.name = "Counting Down State"

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	print(self.name);
	pass;

func exit() -> void:
	pass;

func update(_delta: float) -> void:
	self.game.toggle_pause_poll();

	var new_text_format: String = "Points: %s, Time Remaining: %.2f";
	var new_text: String = new_text_format % [self.game.score, self.game.timer.time_left];
	self.game.label.text = new_text;

	var current_time: float = self.game.timer.time_left;
	var diff_1: float = abs(current_time - 2.0);
	var diff_2: float = abs(current_time - 1.0);

	if diff_1 <= 0.01 || diff_2 <= 0.01:
		self.game.play_sfx.emit(SfxAudio.Sfx.COUNTDOWN_BEEP);

func physics_update(_delta: float) -> void:
	pass;

# remaining private methods
# remaining signal callbacks
# inner classes
