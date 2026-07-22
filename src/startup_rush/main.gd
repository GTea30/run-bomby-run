# @tool, @icon, @static_unload
class_name JamSimMain
extends Node
# ## doc comment
# ---
# signals
# enums
enum State {
	RUNNING,
	WIN,
	LOSE
}
# constants
# static variables
# @export variables
# remaining regular variables
var order: bool = true;
var state: State = State.RUNNING;

# @onready variables
@onready var flip_1: FlipSwitch = $Flip1;
@onready var flip_2: FlipSwitch = $Flip2;
@onready var flip_3: FlipSwitch = $Flip3;
@onready var flip_4: FlipSwitch = $Flip4;
@onready var flip_5: FlipSwitch = $Flip5;

@onready var cockpit_hatch: Tactile_Button = $CockpitHatch;
@onready var ignition: Tactile_Button = $Ignition;
@onready var start: Tactile_Button = $Start;

@onready var timer: Timer = $Timer;

@onready var label: Label = $Label;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.timer.timeout.connect(_on_timer_timeout);
	pass

func _process(_delta: float) -> void:
	if !order:
		self.state = State.LOSE;
	if !self.cockpit_hatch.status && self.ignition.status:
		order = false;
	if !self.ignition.status && self.get_any_flip_status():
		order = false;
	if !self.get_flip_status() && self.start.status:
		order = false;

	if Input.is_action_just_pressed("Go"):
		if self.start.status:
			self.state = State.WIN;
		else:
			self.state = State.LOSE;

	match self.state:
		State.WIN:
			self.label.text = "YOU WIN";
			get_tree().paused = true;
		State.RUNNING:
			self.label.text = str("Press Space when finished!\n%s" % self.timer.time_left);
		State.LOSE:
			self.label.text = "You LOSE";
			self.get_tree().paused = true;

#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func get_flip_status() -> bool:
	return (
		flip_1.status &&
		flip_2.status &&
		flip_3.status &&
		flip_4.status &&
		flip_5.status
	);

func get_any_flip_status() -> bool:
	return (
		flip_1.status ||
		flip_2.status ||
		flip_3.status ||
		flip_4.status ||
		flip_5.status
	);

func _on_timer_timeout() -> void:
	self.state = State.LOSE;
# inner classes
