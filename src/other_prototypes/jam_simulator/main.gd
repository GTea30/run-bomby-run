# @tool, @icon, @static_unload
class_name JamSimMain
extends Node
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var word_list: WordList;

# @onready variables
@onready var typer: Typer = $Typer;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	word_list = WordList.new();
	self.typer.typing_prompt.solved.connect(_on_typing_prompt_solved);
	self.set_word(word_list.get_random_word(5));

#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func set_word(word: String) -> void:
	self.typer.checked_string = word.to_upper();
	self.typer.next_letter = 0;

	self.typer.typing_prompt.plain_text = word.to_upper();
	self.typer.typing_prompt.text = word.to_upper();
	self.typer.typing_prompt.checked_index = 0;
	self.typer.typing_prompt.is_solved = false;

func _on_typing_prompt_solved() -> void:
	self.set_word(word_list.get_random_word(5));

# inner classes
