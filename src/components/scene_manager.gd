# @tool, @icon, @static_unload
class_name SceneManager
extends Object
# ## doc comment
# ---
# signals
signal play_sfx(sfx: SfxAudio.Sfx);
# enums
enum SceneEnum {
	START_SCENE,
	GAME_SCENE,
}
# constants
# static variables
# @export variables
# remaining regular variables
var main_scene: Main;
var game_scene: PackedScene;
var start_scene: PackedScene;
var current_scene: SceneNode;
# @onready variables
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(new_main_scene: Node) -> void:
	self.main_scene = new_main_scene;
	game_scene = preload("uid://c8i4k04d4j5fc");
	start_scene = preload("uid://bqpmkkuy1i8lf");

	self.load_new_scene(SceneEnum.START_SCENE);

#    _enter_tree()
#    _ready() -> void:

#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func load_new_scene(scene: SceneEnum) -> void:
	var new_scene: SceneNode;
	match scene:
		SceneEnum.START_SCENE:
			new_scene = self.start_scene.instantiate();
		SceneEnum.GAME_SCENE:
			new_scene = self.game_scene.instantiate();

	self.main_scene.add_child(new_scene);

	if current_scene:
		self.current_scene.change_scene.disconnect(_on_current_scene_change_scene);
		self.current_scene.open_options.disconnect(_on_current_scene_open_options);
		self.current_scene.play_sfx.disconnect(_on_current_scene_play_sfx);
		self.current_scene.queue_free();

	self.current_scene = new_scene;
	if self.current_scene.change_scene.connect(_on_current_scene_change_scene):
		print("Current Scene: Change Scene connection error");
	if self.current_scene.open_options.connect(_on_current_scene_open_options):
		print("Current Scene: Open Options connection error");
	if self.current_scene.play_sfx.connect(_on_current_scene_play_sfx):
		print ("Current Scene: Play SFX connection error");

func _on_current_scene_change_scene(new_scene: SceneEnum) -> void:
	self.load_new_scene(new_scene);

func _on_current_scene_open_options() -> void:
	main_scene.options.show();
	self.current_scene.hide();
	pass

func show_current_scene() -> void:
	self.current_scene.show();
	if self.current_scene is Game:
		var	current_game_screen: Game = self.current_scene as Game;
		current_game_screen.toggle_pause();

func _on_current_scene_play_sfx(sfx: SfxAudio.Sfx) -> void:
	self.play_sfx.emit(sfx);

# inner classes
