# @tool, @icon, @static_unload
class_name PlayingGameState
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
	self.name = "Playing Game State";

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
	self.game.label.text = "Points: %s" % self.game.score;

func physics_update(_delta: float) -> void:
	pass;

# remaining private methods
# remaining signal callbacks
# inner classes
