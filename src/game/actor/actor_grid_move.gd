# @tool, @icon, @static_unload
class_name ActorGridMove
extends State
# ## doc comment

# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var actor: Actor;
var destination: Vector2;

# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(init_actor: Actor, init_destination: Vector2) -> void:
	self.actor = init_actor;
	self.destination = init_destination

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	pass;

func exit() -> void:
	pass;

func update(_delta: float) -> void:
	pass;

func physics_update(delta: float) -> void:
	var x_diff: float = actor.global_position.x - destination.x;
	var y_diff: float = actor.global_position.y - destination.y;
	var diff := Vector2(x_diff, y_diff);

	if diff == Vector2(0, 0):
		self.actor.current_animation_state = Actor.AnimationState.IDLE;
		self.leave_state.emit()
		return;

	self.actor.global_position = self.actor.global_position.move_toward(self.destination, delta * 150);
	# self.actor.move_and_slide();


# remaining private methods
# remaining signal callbacks
# inner classes
