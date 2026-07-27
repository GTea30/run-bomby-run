# @tool, @icon, @static_unload
class_name Main
extends Node
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var scene_manager: SceneManager;
# var settings: ConfigFile;
# @onready variables
@onready var options: Options = $Options;
@onready var sfx_audio: SfxAudio = $SFXAudio;
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init() -> void:
	# self._load_settings();
	# self._set_settings();
	pass
#    _enter_tree()
func _ready() -> void:
	self.scene_manager = SceneManager.new(self);
	if self.scene_manager.play_sfx.connect(_on_scene_manager_play_sfx):
		print("Scene manager play sfx connect error");

	if self.options.set_volume.connect(_on_options_set_volume):
		print("options set volume connect error");
	if self.options.closing.connect(_on_options_closing):
		print("options closing connect error");

#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func _on_scene_manager_play_sfx(sfx: SfxAudio.Sfx) -> void:
	self.sfx_audio.play_sound(sfx);

func _on_options_set_volume(sfx_volume: float) -> void:
	self.sfx_audio.volume_linear = sfx_volume;

func _on_options_closing() -> void:
	self.options.hide();
	self.scene_manager.show_current_scene();

# func _load_settings() -> void:
# 	self.settings = ConfigFile.new();
#
# 	var existing_settings_err: int = self.settings.load("user://settings.cfg");
#
# 	if existing_settings_err:
# 		self.settings.set_value("Display", "screen_width", 1920);
# 		self.settings.set_value("Display", "screen_height", 1080);
# 		self.settings.set_value("Display", "mode", "Exclusive Fullscreen");
#
# 		self.settings.set_value("Audio", "sfx_volume", 1.0);
# 		self.settings.set_value("Audio", "music_volume", 1.0);
#
# 		var err: Error = self.settings.save("user://settings.cfg");
# 		if err:
# 			print("Saving Error: %s" % err)
#
# func _set_settings() -> void:
# 	# Video
# 	var screen_width: int = self.settings.get_value("Display", "screen_width");
# 	var screen_height: int = self.settings.get_value("Display", "screen_height");
# 	var window_mode: String = self.settings.get_value("Display", "mode");
#
# 	DisplayServer.window_set_size(Vector2i(screen_width, screen_height));
#
# 	match window_mode:
# 		"Windowed":
# 			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);
# 		"Borderless":
# 			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true);
# 			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
# 		"Exclusive Fullscreen":
# 			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false);
# 			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN);

# inner classes
