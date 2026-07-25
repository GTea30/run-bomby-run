# @tool, @icon, @static_unload
class_name EnemyAnimationTree
extends AnimationTree
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
@export var enemy: Enemy;
# remaining regular variables
# @onready variables
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
#    _ready()
#    _process()
func _physics_process(_delta: float) -> void:
	self.set("parameters/StateMachine/Walk/blend_position", enemy.velocity.normalized())
#    remaining virtual methods
# overridden custom methods
# remaining methods
# inner classes
