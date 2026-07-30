# @tool, @icon, @static_unload
class_name StateMachine
extends RefCounted
# ## doc comment

# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var state_stack: Array[State];

# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(initial_state: State = IdleState.new()) -> void:
	self.state_stack.push_back(initial_state);
	pass;
#    remaining virtual methods
# overridden custom methods
# remaining public methods
func update_current_state(delta: float) -> void:
	self.state_stack[-1].update(delta);

func physics_update_current_state(delta: float) -> void:
	self.state_stack[-1].physics_update(delta);

func push_state(new_state: State) -> void:
	self.state_stack.push_back(new_state);
	self._enter_top_state();

func get_state() -> State:
	return self.state_stack[-1];

func remove_current_state() -> void:
	var immediete_state: State = self.state_stack.pop_back();
	immediete_state.exit();

# remaining private methods
func _enter_top_state() -> void:
	self.state_stack[-1].enter();
	if self.state_stack[-1].leave_state.connect(_on_current_state_leave_state):
		"Print Current State: Leave State connection error"


# remaining signal callbacks
func _on_current_state_leave_state() -> void:
	var last_state: State = self.state_stack.pop_back();
	last_state.exit();
	last_state.leave_state.disconnect(_on_current_state_leave_state);

# inner classes
