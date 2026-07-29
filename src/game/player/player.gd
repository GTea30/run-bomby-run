# @tool, @icon, @static_unload
class_name Player
extends Actor
# ## doc comment
# ---
# signals
signal to_explode;
signal caught;

# enums
# constants
# static variables
# @export variables
# remaining regular variables
var bomb_mode: bool = false;

# @onready variables
@onready var hitbox: Area2D = $Area2D
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	super();
	if self.hitbox.area_entered.connect(_on_hitbox_area_entered):
		print("hitbox area entered connection error");

func _process(delta: float) -> void:
	if !self.paused:
		if Input.is_action_pressed("Move Up"):
			self.velocity.y = -speed * delta * 1000;
		if Input.is_action_pressed("Move Down"):
			self.velocity.y = speed * delta * 1000;
		if Input.is_action_pressed("Move Left"):
			self.velocity.x = -speed * delta * 1000;
		if Input.is_action_pressed("Move Right"):
			self.velocity.x = +speed * delta * 1000;

		self.velocity.x = move_toward(self.velocity.x, 0, delta * 1000);
		self.velocity.y = move_toward(self.velocity.y, 0, delta * 1000);

		@warning_ignore("return_value_discarded")
		move_and_slide();

		if Input.is_action_just_pressed("Explode"):
			self.bomb_mode = true;
			self.paused = true;
			self.to_explode.emit();


#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent() is Enemy:
		self.caught.emit();
		self.paused = true;
		self.queue_free();
	pass

# inner classes
