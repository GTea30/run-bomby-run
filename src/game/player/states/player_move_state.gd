# @tool, @icon, @static_unload
class_name PlayerMoveState
extends State
# ## doc comment

# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var player: Player;

# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(new_player: Player) -> void:
	self.player = new_player;

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	pass;

func exit() -> void:
	pass;

func update(delta: float) -> void:
	if Input.is_action_pressed("Move Up"):
		self.player.velocity.y = -self.player.speed * delta * 1000;
	if Input.is_action_pressed("Move Down"):
		self.player.velocity.y = self.player.speed * delta * 1000;
	if Input.is_action_pressed("Move Left"):
		self.player.velocity.x = -self.player.speed * delta * 1000;
	if Input.is_action_pressed("Move Right"):
		self.player.velocity.x = +self.player.speed * delta * 1000;

	self.player.velocity.x = move_toward(self.player.velocity.x, 0, delta * 1000);
	self.player.velocity.y = move_toward(self.player.velocity.y, 0, delta * 1000);

	@warning_ignore("return_value_discarded")
	self.player.move_and_slide();

	if Input.is_action_just_pressed("Explode"):
		var bomb_mode_state := PlayerBombState.new(self.player);
		self.player.state_machine.push_state(bomb_mode_state);

func physics_update(_delta: float) -> void:
	pass;

# remaining private methods
# remaining signal callbacks
# inner classes
