# @tool, @icon, @static_unload
class_name PausedState
extends State
# ## doc comment

# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var is_paused := true;
var parent_node: Actor;
#
# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(unpause_signal: Signal, new_parent_node: Actor) -> void:
	self.parent_node = new_parent_node;
	if unpause_signal.connect(_on_unpause_signal):
		print("Unpause: connection error")

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	pass;

func exit() -> void:
	pass;

func update(_delta: float) -> void:
	if !is_paused:
		self.leave_state.emit();

func physics_update(delta: float) -> void:
	self.parent_node.velocity = self.parent_node.velocity.move_toward(Vector2(0, 0), delta * 250);

	@warning_ignore("return_value_discarded")
	self.parent_node.move_and_slide();

# remaining private methods
# remaining signal callbacks
func _on_unpause_signal() -> void:
	self.is_paused = false;

# inner classes
