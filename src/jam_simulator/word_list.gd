# @tool, @icon, @static_unload
class_name WordList
extends Object
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var words_by_length: Dictionary[int, Array];
# @onready variables
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
func _init() -> void:
	var websters_json: JSON = preload("res://assets/dictionary.json");
	var websters_dictionary: Dictionary = websters_json.data;
	for word: String in websters_dictionary.keys():
		if self.words_by_length.get(word.length()):
			self.words_by_length[word.length()].push_back(word)
		else:
			self.words_by_length[word.length()] = [word];
	pass

#    _enter_tree()
#    _ready()
#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func get_random_word(length: int) -> String:
	return self.words_by_length[length].pick_random()
# inner classes
