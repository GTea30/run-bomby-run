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
@onready var start_button: Button = $VBoxContainer/StartButton;
@onready var option_button: Button = $VBoxContainer/OptionButton;
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	if self.start_button.pressed.connect(_on_start_button_pressed):
		print("Start Button Pressed Connect Error");
	if self.option_button.pressed.connect(_on_option_button_pressed):
		print("Option Button Pressed Connect Error");
	# var screen_size: Vector2i = DisplayServer.window_get_size();
	# self.start_button.position.x = screen_size.x / 2.0;
	# print(screen_size.y)
	# self.start_button.position.y = screen_size.y / 2.0;

#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func _on_start_button_pressed() -> void:
	self.change_scene.emit(SceneManager.SceneEnum.GAME_SCENE);

func _on_option_button_pressed() -> void:
	self.open_options.emit();

# inner classes
