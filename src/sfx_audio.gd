# @tool, @icon, @static_unload
class_name SfxAudio
extends AudioStreamPlayer
# ## doc comment
# ---
# signals
# enums
enum Sfx {
	EXPLOSION,
	COUNTDOWN_BEEP
}
# constants
# static variables
# @export variables
# remaining regular variables
var explosion_sfx: AudioStream;
var countdown_beep: AudioStream;
# @onready variables
# ---
# _static_init()
# remaining static methods
# overridden built-in virtual methods:
#    _init()
#    _enter_tree()
func _ready() -> void:
	self.explosion_sfx = preload("uid://dhfoj4d20wk30");
	self.countdown_beep = preload("uid://p16w6n8sjfaq");
#    _process()
#    _physics_process()
#    remaining virtual methods
# overridden custom methods
# remaining methods
func play_explosion() -> void:
	self.stream = self.explosion_sfx;
	self.play();

func play_countdown_beep() -> void:
	self.stream = self.countdown_beep;
	self.play();

func play_sound(sfx: Sfx) -> void:
	match sfx:
		Sfx.EXPLOSION: self.play_explosion();
		Sfx.COUNTDOWN_BEEP: self.play_countdown_beep();

# inner classes
