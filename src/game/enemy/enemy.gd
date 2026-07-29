# @tool, @icon, @static_unload
class_name Enemy
extends Actor
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

# @onready variables
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	super();
	self._set_material();
	self.state_machine.push_state(EnemyMoveState.new(self))

#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func _set_material() -> void:
	var mat: ShaderMaterial = self.material as ShaderMaterial;
	mat.set_shader_parameter("shade", shade);

# inner classes
