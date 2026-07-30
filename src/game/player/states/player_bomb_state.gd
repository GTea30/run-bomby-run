# @tool, @icon, @static_unload
class_name PlayerBombState
extends State
# ## doc comment

# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var player: Player;

# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(init_player: Player) -> void:
	self.player = init_player;

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	self.player.to_explode.emit();
	self.player.bomb_mode = true;
	pass;

func exit() -> void:
	pass;

func update(_delta: float) -> void:
	pass;

func physics_update(_delta: float) -> void:
	pass;

func call_leave_signal() -> void:
	self.leave_state.emit();

# remaining private methods
# remaining signal callbacks
# inner classes
