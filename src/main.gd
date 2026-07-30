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

# inner classes
