# @tool, @icon, @static_unload
class_name EnemyIdleState
extends State
# ## doc comment

# signals
signal request_move(dir: Vector2i, callback: Callable);
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var map: Map;
var actor: Enemy;
var target: Player;
var starting_pos: Vector2i;
var unavailable_coords: Dictionary[Vector2i, bool];

# Child: Parent
var path: Dictionary [Vector2i, Vector2i]

# @onready variables
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init(init_actor: Enemy, init_map: Map, init_target: Player) -> void:
	self.actor = init_actor;
	self.target = init_target;
	self.map = init_map;

#    remaining virtual methods
# overridden custom methods
# remaining public methods
func enter() -> void:
	pass;

func exit() -> void:
	pass;

func update(_delta: float) -> void:
	if self.target:
		# Look for path to player;
		self.starting_pos = self.actor.grid_position;
		self.unavailable_coords = {self.starting_pos: true};
		self. path = {};
		var coords_to_check: Array[Vector2i] = [self.starting_pos];
		var found_player: bool = false;
		while !found_player:
			var current_pos: Vector2i = coords_to_check.pop_back();
			found_player = _get_neighbor_coords(current_pos, coords_to_check);
			if coords_to_check.is_empty():
				break;

		# request move to specific tile
		var destination: Vector2i = _traverse_backwards();
		var direction: Vector2i = destination - self.starting_pos;

		self.request_move.emit(direction, _move);

func physics_update(_delta: float) -> void:
	pass;

# remaining private methods
func _get_neighbor_coords(coord: Vector2i, coord_array: Array[Vector2i]) -> bool:
	var neighbors: Array[Vector2i] = [
		coord + Vector2i.UP,
		coord + Vector2i.DOWN,
		coord + Vector2i.LEFT,
		coord + Vector2i.RIGHT
	];
	for neighbor in neighbors:
		if neighbor == self.target.grid_position:
			coord_array.push_back(neighbor);
			self.path[neighbor] = coord;
			return true;

		if map.is_traversable(neighbor) && !self.unavailable_coords.get(neighbor):
			self.path[neighbor] = coord;
			self.unavailable_coords[neighbor] = true;
			_insert_by_cost(coord_array, neighbor);

	return false;

func _insert_by_cost(coord_array: Array[Vector2i], coord: Vector2i) -> void:
	if coord_array.is_empty():
		coord_array.push_back(coord);
		return;

	var new_cost: int = _calculate_cost(coord);
	var last_index: int = 0;
	for checked_coord in coord_array:
		if new_cost >= _calculate_cost(checked_coord):
			var err:Error = coord_array.insert(last_index, coord) as Error;
			if err != OK:
				printerr(err);
			return;

		last_index += 1;
	coord_array.push_back(coord);

func _calculate_cost(coord: Vector2i) -> int:
	var distance_from_current_pos: int = (
		abs(starting_pos.x - coord.x) + abs(starting_pos.y - coord.y)
	);
	var distance_from_target: int = (
		abs(target.grid_position.x - coord.x) + abs(target.grid_position.y - coord.y)
	);

	return distance_from_current_pos + distance_from_target;

func _traverse_backwards() -> Vector2i:
	var return_vector: Vector2i = self.target.grid_position;
	var found_neighbor := false;

	while !found_neighbor:
		if !self.path.get(return_vector):
			return self.starting_pos;

		if self.path.get(return_vector) == self.starting_pos:
			return return_vector;

		return_vector = self.path[return_vector];


	return return_vector;

func _move(dir: Vector2i) -> void:
	self.actor.velocity = dir;
	self.actor.grid_position += dir;
	var new_move_state := ActorGridMove.new(actor, actor.grid_as_global());
	actor.state_machine.push_state(new_move_state);

# remaining signal callbacks
# inner classes
