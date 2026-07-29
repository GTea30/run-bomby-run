# @tool, @icon, @static_unload
class_name Actor
extends CharacterBody2D
# ## doc comment

# signals
signal unpause;
# enums
# constants
# static variables
# @export variables
@export var speed: int;

# remaining regular variables
var paused: bool;
var starting_position: Vector2;
var state_machine: StateMachine;

# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.state_machine = StateMachine.new();
	self.starting_position = self.global_position;

func _process(delta: float) -> void:
	self.state_machine.update_current_state(delta);

func _physics_process(delta: float) -> void:
	self.state_machine.physics_update_current_state(delta);

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func reset() -> void:
	self.global_position = self.starting_position;

func toggle_pause() -> void:
	self.paused = !self.paused;
	self._set_pause_state();


func set_pause(b: bool) -> void:
	self.paused = b;
	self._set_pause_state();


func move() -> void:
	pass;

# remaining private methods
func _set_pause_state() -> void:
	if self.paused:
		var new_pause_state := PausedState.new(self.unpause, self);
		self.state_machine.push_state(new_pause_state);
	else:
		self.unpause.emit();

# remaining signal callbacks
# inner classes
