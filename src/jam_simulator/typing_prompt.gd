# @tool, @icon, @static_unload
class_name TypingPrompt
extends RichTextLabel
# ## doc comment
# ---
# signals
signal solved;
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var plain_text: String = "HELLO";
var checked_index: int = 0;
var is_solved: bool = false;

# @onready variables
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.text = plain_text;

func _process(_delta: float) -> void:
	if checked_index == plain_text.length():
		self.solved.emit();

#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func new_correct_letter() -> void:
	var correct_text: String = plain_text.substr(0, checked_index + 1);
	var remaining_text: String = plain_text.substr(checked_index + 1, plain_text.length() - (checked_index + 1));
	self.text = "[color=green]" + correct_text + "[/color]" + remaining_text;
	self.checked_index += 1;

func new_word() -> void:
	pass
# inner classes
