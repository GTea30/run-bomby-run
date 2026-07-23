# @tool, @icon, @static_unload
class_name Game
extends SceneNode
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
@export var enemies: Array[Enemy];
# remaining regular variables
var counting_down: bool = false;
#
# @onready variables
@onready var player: Player = $Player;
@onready var timer: Timer = $Timer;
@onready var label: Label = $Label;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.player.to_explode.connect(_on_player_to_explode);
	self.timer.timeout.connect(_on_timer_timeout);
	self.player.caught.connect(_on_player_caught);

func _process(_delta: float) -> void:
	if counting_down:
		self.label.text = str(self.timer.time_left);


#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func _on_player_to_explode() -> void:
	self.timer.start();
	self.counting_down = true;

func _on_timer_timeout() -> void:
	self.counting_down = false;
	for enemy in self.enemies:
		enemy.queue_free();
	self.label.text = "You Win!";

func _on_player_caught() -> void:
	self.counting_down = false;
	self.label.text = "You Lose!";

# inner classes
