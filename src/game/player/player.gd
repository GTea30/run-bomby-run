# @tool, @icon, @static_unload
class_name Player
extends Actor
# ## doc comment
# ---
# signals
@warning_ignore("unused_signal")
signal to_explode;
signal caught;

# enums
# constants
# static variables
# @export variables
# remaining regular variables
var bomb_mode: bool = false;
var bomb_state: PlayerBombState;

# @onready variables
@onready var hitbox: Area2D = $Area2D
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	var idle_state := PlayerIdleState.new(self);
	if idle_state.request_move.connect(_on_request_move):
		print("Idle State: Request Move connection error!");
	self.state_machine = StateMachine.new(idle_state);
	self.starting_position = self.global_position;
	self.grid_position = self.global_as_grid();

	# var player_movement_state: PlayerMoveState = PlayerMoveState.new(self);
	# self.state_machine.push_state(player_movement_state);

	if self.hitbox.area_entered.connect(_on_hitbox_area_entered):
		print("hitbox area entered connection error");

#     _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Enemy:
		self.caught.emit();
		self.set_pause(true);
		self.queue_free();
	pass

func _on_request_move(dir: Vector2i, callback: Callable) -> void:
	self.request_move.emit(self, dir, callback);
	pass;

func reset() -> void:
	super();
	if self.bomb_state:
		self.bomb_state.leave_state.emit();
	self.set_pause(true);

# inner classes
