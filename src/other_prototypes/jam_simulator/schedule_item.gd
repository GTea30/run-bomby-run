# @tool, @icon, @static_unload
class_name ScheduleItem
extends Area2D
# ## doc comment
# ---
# signals
signal is_selected(is_selected: bool);
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var is_scheduled: bool = false;
var mouse_hover: bool = false;
# @onready variables

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.mouse_entered.connect(
		func() -> void:
			self.mouse_hover = true;
			print("hovering")
	);
	self.mouse_exited.connect(
		func() -> void:
			self.mouse_hover = false;
			print("not_hovering")
	);

	pass

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Left Click") && self.mouse_hover:
		self.global_position = get_global_mouse_position();
		pass

#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
# inner classes
