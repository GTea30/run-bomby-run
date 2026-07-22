# @tool, @icon, @static_unload
class_name Schedule
extends Node2D
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
@export var timeslot_size: int;

# remaining regular variables
var schedule_items: Array[ScheduleItem];
var time_available: int;
var selected_item: ScheduleItem;

# @onready variables
@onready var color_rect: ColorRect = $ColorRect;
@onready var dragged_area: Area2D = $Area2D;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.color_rect.size.x = timeslot_size * time_available;

func _process(_delta: float) -> void:
	# If a schedule item is dragged into the box, and the mouse is let go:
	# Sort the schedule items by X position
	# Snap any schedule items that have been "set"
	pass

#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
# inner classes
