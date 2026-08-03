# @tool, @icon, @static_unload
class_name StartGameState
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
	self.name = "Start Game State";
#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	print(self.name)
	self.game.label.text = "Round %s\nPress Enter to Continue" % self.game.round_count;

func exit() -> void:
	pass;

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("Confirm"):
		self.leave_state.emit();
		self.game.start_round();
		self.game.state_machine.push_state(PlayingGameState.new(self.game));

func physics_update(_delta: float) -> void:
	pass;

# remaining private methods
# remaining signal callbacks
# inner classes
