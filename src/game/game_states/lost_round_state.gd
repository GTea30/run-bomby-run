# @tool, @icon, @static_unload
class_name LostRoundState
extends State
# ## doc comment

# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var game: Game;

# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(init_game: Game) -> void:
	self.game = init_game;
	self.name = "Lost Round State";

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	print(self.name); self.game.label.text = "Game Over Total Score: %s\nPress Enter to return to Title Screen" % self.game.total_score;
	self.game.timer.paused = true;
	self.game.set_enemy_pause(false);
	pass;

func exit() -> void:
	self.game.change_scene.emit(SceneManager.SceneEnum.START_SCENE);
	pass;

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("Confirm"):
		self.leave_state.emit();
	pass;

func physics_update(_delta: float) -> void:
	pass;

# remaining private methods
# remaining signal callbacks
# inner classes
