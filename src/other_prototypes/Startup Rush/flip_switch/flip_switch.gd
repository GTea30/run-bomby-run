@tool #, @icon, @static_unload
class_name FlipSwitch
extends Node2D
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
@export var label_text: String:
	set(new_label):
		label_text = new_label;
		if self.label:
			self.label.text = new_label;

# remaining regular variables
var held: bool = false;
var mouse_movement_is_down: bool = false;
var mouse_velocity: float;
var status: bool = false;
# @onready variables
@onready var area: Area2D = $Area2D;
@onready var label: Label = $Label;
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.area.mouse_exited.connect(_on_area_mouse_exited)
	pass

func _process(_delta: float) -> void:
	if !Engine.is_editor_hint():
		if Input.is_action_pressed("Left Click"):
			held = true;
		else:
			held = false;

		pass
#    _physics_process()
#    remaining virtual methods
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && !Engine.is_editor_hint():
		var mouse_event: InputEventMouseMotion = event as InputEventMouseMotion;
		if mouse_event.relative.x > 0:
			self.mouse_movement_is_down = true;
		else:
			self.mouse_movement_is_down = false;

# overridden custom methods
# remaining methods
func _on_area_mouse_exited() -> void:
	if self.mouse_movement_is_down && self.held && !Engine.is_editor_hint():
		self.status = true;
		self.modulate = Color(0,1,0)
# inner classes
