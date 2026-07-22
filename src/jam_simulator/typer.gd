# @tool, @icon, @static_unload
class_name Typer
extends Node
# ## doc comment
# ---
# signals
# enums
# constants
# static variables
# @export variables
# remaining regular variables
var checked_string: String;
var next_letter: int = 0;

# @onready variables
@onready var typing_prompt: TypingPrompt = $TypingPrompt;

# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.checked_string = self.typing_prompt.plain_text;

#    _process(_delta: float) -> void:

#    _physics_process()
#    remaining virtual methods
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_event: InputEventKey = event as InputEventKey;
		if !key_event.echo && key_event.pressed:
			if key_event.as_text_keycode() == checked_string[next_letter]:
				self.typing_prompt.new_correct_letter();
				next_letter += 1;


# overridden custom methods
# remaining methods
# inner classes
