# @tool, @icon, @static_unload
class_name Map
extends RefCounted
# ## doc comment

# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var bg: MapBG;
var actors: Dictionary[Vector2i, Actor];

# @onready variables

# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(init_bg: MapBG, init_actors: Array[Actor]) -> void:
	self.bg = init_bg;
	set_actors(init_actors);

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func is_traversable(coord: Vector2i) -> bool:
	var tile: MapBG.MapTileID = self.bg.get_cell(coord);
	var is_floor: bool = tile == MapBG.MapTileID.FLOOR;

	var potential_actor:Actor = self.actors.get(coord);
	if potential_actor:
		return is_floor && (potential_actor is Player);
	else:
		return is_floor;

func update_actor_pos(actor: Actor, destination: Vector2i) -> void:
	self.actors[destination] = actor;
	self.actors[actor.current_grid_pos()] = null;


func set_actors(actors_to_set: Array[Actor]) -> void:
	self.actors = {};
	for actor in actors_to_set:
		self.actors[actor.grid_position] = actor;

# remaining private methods
# remaining signal callbacks
# inner classes
