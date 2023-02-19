extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var particleScene = preload("res://feedback/FeedbackParticles.tscn");
var particles
# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("mouse_entered", self, "on_hover");
	self.connect("pressed", self, "on_button_pressed");
	particles = particleScene.instance();
	add_child(particles);
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func on_button_pressed():
	var mousePosition = get_viewport().get_mouse_position();
	particles.position = mousePosition
	AudioManager.play_click();
	particles.emitting = true;

func on_hover():
	AudioManager.play_hover();
