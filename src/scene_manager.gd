# @tool, @icon, @static_unload
class_name SceneManager
extends Object
# ## doc comment
# ---
# signals
# enums
enum SceneEnum {
	START_SCENE,
	GAME_SCENE,
}
# constants
# static variables
# @export variables
# remaining regular variables
var main_scene: Node;
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
		self.current_scene.queue_free();

	self.current_scene = new_scene;
	self.current_scene.change_scene.connect(_on_current_scene_change_scene);

func _on_current_scene_change_scene(new_scene: SceneEnum) -> void:
	self.load_new_scene(new_scene);

# inner classes
