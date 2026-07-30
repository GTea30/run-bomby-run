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

# @onready variables
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.speed = 5;
	self.starting_position = self.global_position;
	self.grid_position = self.global_as_grid();
	self.state_machine = StateMachine.new();
	self._set_material();
	# self.state_machine.push_state(EnemyMoveState.new(self))

#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods

func set_map(map: Map) -> void:
	var idle_state := EnemyIdleState.new(self, map, target);
	if idle_state.request_move.connect(_on_request_move):
		print("Idle State: Request Move connection error!");
	self.state_machine.push_state(idle_state)

func reset() -> void:
	super();
	self.speed += 1;

func _set_material() -> void:
	var mat: ShaderMaterial = self.material as ShaderMaterial;
	mat.set_shader_parameter("shade", shade);

func _on_request_move(dir: Vector2i, callback: Callable) -> void:
	self.request_move.emit(self, dir, callback);

func _set_pause_state() -> void:
	if self.paused:
		if self.state_machine.get_state() is ActorGridMove:
			self.state_machine.remove_current_state();
		var new_pause_state := PausedState.new(self.unpause, self);
		self.state_machine.push_state(new_pause_state);
	else:
		self.unpause.emit();

# inner classes
