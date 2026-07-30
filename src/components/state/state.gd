# @tool, @icon, @static_unload
class_name State
extends RefCounted
# ## doc comment

# signals
@warning_ignore("unused_signal")
signal leave_state;
# enums
# constants
# static variables
# @export variables
# remaining regular variables
# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	pass;

func exit() -> void:
	pass;

func update(_delta: float) -> void:
	pass;

func physics_update(_delta: float) -> void:
	pass;
# remaining private methods
# remaining signal callbacks
# inner classes
