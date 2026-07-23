# @tool, @icon, @static_unload
class_name DragSwitch
extends Node2D
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
@export var path: Path2D;
# remaining regular variables
# @onready variables
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
#    _ready()
func _process(_delta: float) -> void:
	if Input.is_action_pressed("Left Click"):
		self.global_position = get_global_mouse_position();
		var closest_point: Vector2 = path.curve.get_closest_point(self.global_position);
		var offest: float = path.curve.get_closest_offset(closest_point);
		var path_position: Vector2 = path.curve.sample_baked(offest);
		self.global_position = path_position;
	pass

#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
# inner classes
