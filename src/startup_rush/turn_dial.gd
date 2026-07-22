# @tool, @icon, @static_unload
class_name TurnDial
extends Node2D
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var held: bool = false;
var starting_mouse_position: Vector2 = Vector2(0, 0);
# @onready variables
@onready var path: Path2D = $Path2D;
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
#    _ready()
func _process(_delta: float) -> void:
	if Input.is_action_pressed("Left Click"):
		self.held = true;
		var path

#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
# inner classes
