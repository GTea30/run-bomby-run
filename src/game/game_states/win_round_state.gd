# @tool, @icon, @static_unload
class_name WinRoundState
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
	self.name = "Win Round State";

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	print(self.name);
	self.game.score += 1;
	self.game.round_count += 1;
	self.game.label.text = "Round Won!\nPress Enter to Continue";
	self.game.set_enemy_pause(true);

func exit() -> void:
	self.game.reset();
	self.game.state_machine.push_state(StartGameState.new(self.game));
	pass;

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("Confirm"):
		self.leave_state.emit();
	pass;

func physics_update(_delta: float) -> void:
	pass;

# remaining private methods
# remaining signal callbacks
# inner classes
