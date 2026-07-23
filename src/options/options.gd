# @tool, @icon, @static_unload
class_name Options
extends Control
# ## doc comment
# ---
# signals
signal closing;
signal set_volume(sfx_volume: float);
# enums
# constants
# static variables
# @export variables
@export var resolution_node: OptionButton;
@export var window_mode_node: OptionButton;

@export var sfx_volume_node: HSlider;
@export var music_volume_node: HSlider;

# remaining regular variables
var settings: ConfigFile;
var resolution: Vector2i;
var window_mode: String;

var sfx_volume: float;
var music_volume: float;

# @onready variables
@onready var close_button: Button = $CloseButton;
@onready var save_button: Button = $SaveButton;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init() -> void:
	self.load_settings();
	self.set_settings();

#    _enter_tree()
func _ready() -> void:
	self.set_menu_nodes();
	self.resolution_node.item_selected.connect(_on_resolution_node_item_selected);
	self.window_mode_node.item_selected.connect(_on_window_mode_item_selected);

	self.close_button.pressed.connect(_on_close_button_pressed);
	self.save_button.pressed.connect(_on_save_button_pressed);

	self.sfx_volume_node.value_changed.connect(_on_sfx_volume_node_value_changed);

#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func load_settings() -> void:
	self.settings = ConfigFile.new();

	var existing_settings_err: int = self.settings.load("user://settings.cfg");

	if existing_settings_err:
		self.settings.set_value("Display", "screen_width", 640);
		self.settings.set_value("Display", "screen_height", 360);

		self.resolution = Vector2i(640, 360)

		self.settings.set_value("Display", "mode", "Windowed");

		self.window_mode = "Windowed";

		self.settings.set_value("Audio", "sfx_volume", 1.0);
		self.settings.set_value("Audio", "music_volume", 1.0);

		self.sfx_volume = 1.0;
		self.music_volume = 1.0;

		var err: Error = self.settings.save("user://settings.cfg");
		if err:
			print("Saving Error: %s" % err)
	else:
		var screen_width: int = self.settings.get_value("Display", "screen_width");
		var screen_height: int = self.settings.get_value("Display", "screen_height");
		self.resolution = Vector2i(screen_width, screen_height)

		var new_window_mode: String = self.settings.get_value("Display", "mode");
		self.window_mode = new_window_mode;

		var new_sfx_volume: float = self.settings.get_value("Audio", "sfx_volume");
		var new_music_volume: float = self.settings.get_value("Audio", "music_volume");
		self.sfx_volume = new_sfx_volume;
		self.music_volume = new_sfx_volume;

func set_menu_nodes() -> void:
	match self.resolution:
		Vector2i(640, 360): self.resolution_node.selected = 0;
		Vector2i(1280, 720): self.resolution_node.selected = 1;
		Vector2i(1920, 1080): self.resolution_node.selected = 2;
		Vector2i(2560, 1440): self.resolution_node.selected = 3;

	match self.window_mode:
		"Windowed": self.window_mode_node.selected = 0;
		"Borderless": self.window_mode_node.selected = 1;
		"Exclusive Fullscreen": self.window_mode_node.selected = 2;

	self.sfx_volume_node.value = self.sfx_volume;

func set_settings() -> void:
	# Video
	DisplayServer.window_set_size(Vector2i(self.resolution.x, self.resolution.y));


	match self.window_mode:
		"Windowed":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);
		"Borderless":
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true);
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
		"Exclusive Fullscreen":
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false);
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN);
	
	self.set_volume.emit(self.sfx_volume);

func _on_resolution_node_item_selected(index: int) -> void:
	match index:
		0: self.resolution = Vector2i(640, 360);
		1: self.resolution = Vector2i(1280, 720);
		2: self.resolution = Vector2i(1920, 1080);
		3: self.resolution = Vector2i(2560, 1440);

func _on_window_mode_item_selected(index: int) -> void:
	match index:
		0: self.window_mode = "Windowed";
		1: self.window_mode = "Borderless";
		2: self.window_mode = "Exclusive Fullscreen";


func _on_sfx_volume_node_value_changed(value: float) -> void:
	self.sfx_volume = value;

func _on_close_button_pressed() -> void:
	self.closing.emit();

func _on_save_button_pressed() -> void:
	# TODO Look at merging this code with initializing a save file
	self.settings.set_value("Display", "screen_width", self.resolution.x);
	self.settings.set_value("Display", "screen_height", self.resolution.y);

	self.settings.set_value("Display", "mode", self.window_mode);

	self.settings.set_value("Audio", "sfx_volume", self.sfx_volume);
	self.settings.set_value("Audio", "music_volume", self.music_volume);

	self.settings.save("user://settings.cfg");

	self.set_settings();



# inner classes
