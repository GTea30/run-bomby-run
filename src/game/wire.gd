# @tool, @icon, @static_unload
class_name Wire
extends Sprite2D
# ## doc comment

# signals
signal player_get_wire;
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var signaled := false;

# @onready variables
@onready var area_2d: Area2D = $Area2D;

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	var err: Error = self.area_2d.area_entered.connect(_on_area_2d_area_entered) as Error;
	if err:
		printerr(err);

#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining public methods
func toggle_on() -> void:
	self.visible = true;
	self.signaled = false;

# remaining private methods
# remaining signal callbacks
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player && !signaled:
		self.player_get_wire.emit();
		self.visible = false;
		self.signaled = true;

# inner classes
