# @tool, @icon, @static_unload
class_name StartingPosition
extends RefCounted
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var value: Vector2;
# @onready variables
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(new_value: Vector2) -> void:
	self.value = new_value;

#    _enter_tree()
#    _ready()
#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func reset_to_starting_position(parent: Node2D) -> void:
	parent.global_position = self.value;
# inner classes
