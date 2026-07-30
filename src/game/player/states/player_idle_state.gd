# @tool, @icon, @static_unload
class_name PlayerIdleState
extends State
# ## doc comment

# signals
signal request_move(dir: Vector2i, callback: Callable);
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var player: Player;
var map: Map;
# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(init_player: Player) -> void:
	self.player = init_player;

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	pass;

func exit() -> void:
	pass;

func update(_delta: float) -> void:
	# Listens for keyboard inputs
	if Input.is_action_pressed("Explode"):
		var new_bomb_state := PlayerBombState.new(player);
		self.player.bomb_state = new_bomb_state;
		self.player.state_machine.push_state(new_bomb_state);

	if Input.is_action_pressed("Move Up"):
		self.request_move.emit(
			Vector2i.UP,
			self._move
		);
		# self._move(Vector2i.UP);
	elif Input.is_action_pressed("Move Down"):
		self.request_move.emit(
			Vector2i.DOWN,
			self._move
		);
		# self._move(Vector2i.DOWN);
	elif Input.is_action_pressed("Move Left"):
		self.request_move.emit(
			Vector2i.LEFT,
			self._move
		);
		# self._move(Vector2i.LEFT);
	elif Input.is_action_pressed("Move Right"):
		self.request_move.emit(
			Vector2i.RIGHT,
			self._move
		);
		# self._move(Vector2i.RIGHT);
	else:
		self.player.velocity = Vector2.ZERO;

func physics_update(_delta: float) -> void:
	pass;

# remaining private methods
func _move(dir: Vector2i) -> void:
	self.player.velocity = dir;
	self.player.grid_position += dir;
	var new_move_state := ActorGridMove.new(player, player.grid_as_global());
	player.state_machine.push_state(new_move_state);

# remaining signal callbacks
# inner classes
