# @tool, @icon, @static_unload
class_name MapBG
extends TileMapLayer
# ## doc comment

# signals
# enums
enum MapTileID {
	FLOOR = 0,
	WALL = 1
}

# constants
# static variables
# @export variables
# remaining regular variables
var data: Dictionary[Vector2i, MapTileID] = {};

# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	init_data();

#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining public methods

func init_data() -> void:
	for cell in self.get_used_cells():
		match self.get_cell_atlas_coords(cell):
			Vector2i(0, 2):
				self.data[cell] = MapTileID.FLOOR;
			Vector2i(1, 2):
				self.data[cell] = MapTileID.WALL;

## Can Return Null
func get_cell(coord: Vector2i) -> MapTileID:
	if self.data.get(coord) == null:
		print(coord)
		return MapTileID.FLOOR;
	return self.data.get(coord);

# remaining private methods
# remaining signal callbacks
# inner classes
