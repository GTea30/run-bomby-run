# @tool, @icon, @static_unload
class_name Enemy
extends CharacterBody2D
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
@export var target: Player;
@export var shade: Color;

# remaining regular variables
var movement_speed: float = 50
var starting_position: StartingPosition;
var paused := false;

# @onready variables
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	var mat: ShaderMaterial = self.material as ShaderMaterial;
	mat.set_shader_parameter("shade", shade);
	self.starting_position = StartingPosition.new(self.global_position);
	self.navigation_agent.path_desired_distance = 4.0;
	self.navigation_agent.target_desired_distance = 4.0;

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if !self.paused:
		if self.target:
			self.navigation_agent.target_position = target.global_position;
		# if navigation_agent.is_navigation_finished():
		# 	return;
		#
		var current_agent_position: Vector2 = self.global_position;
		var next_path_position: Vector2 = navigation_agent.get_next_path_position();

		self.velocity = current_agent_position.direction_to(next_path_position) * movement_speed;
		move_and_slide();
	else:
		self.velocity = Vector2(0, 0);
		move_and_slide();


#    remaining virtual methods
# overridden custom methods
# remaining methods
func reset() -> void:
	self.starting_position.reset_to_starting_position(self);

# inner classes
