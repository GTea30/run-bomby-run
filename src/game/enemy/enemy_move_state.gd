# @tool, @icon, @static_unload
class_name EnemyMoveState
extends State
# ## doc comment

# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var parent_node: Enemy;
# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(new_parent_node: Enemy) -> void:
	self.parent_node = new_parent_node;
#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	pass;

func exit() -> void:
	pass;

func update(_delta: float) -> void:
	pass;

func physics_update(_delta: float) -> void:
	_move_to_target();

# remaining private methods
func _move_to_target() -> void:
	if self.parent_node.target:
		self.parent_node.navigation_agent.target_position = self.parent_node.target.global_position;

	var current_agent_position: Vector2 = self.parent_node.global_position;
	var next_path_position: Vector2 = self.parent_node.navigation_agent.get_next_path_position();

	self.parent_node.velocity = current_agent_position.direction_to(next_path_position) * self.parent_node.movement_speed;

	@warning_ignore("return_value_discarded")
	self.parent_node.move_and_slide();

	pass;
# remaining signal callbacks
# inner classes
