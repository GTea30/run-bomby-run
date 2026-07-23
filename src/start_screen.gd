# @tool, @icon, @static_unload
class_name StartScreen
extends SceneNode;
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
# @onready variables
@onready var start_button: Button = $StartButton;
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.start_button.pressed.connect(_on_start_button_pressed);
#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func _on_start_button_pressed() -> void:
	self.change_scene.emit(SceneManager.SceneEnum.GAME_SCENE);
# inner classes
