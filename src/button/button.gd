@tool #, @icon, @static_unload
class_name Tactile_Button
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
var status: bool = false;
# @onready variables
@onready var button_area: Button = $Button;
@onready var label: Label = $Label;
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.button_area.pressed.connect(_on_button_area_pressed);
#    _process(_delta: float) -> void:
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func _on_button_area_pressed() -> void:
	self.status = true;
	self.modulate = Color(0,1,0);
# inner classes
