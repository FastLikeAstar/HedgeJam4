extends CPUParticles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:

		#event.pressed is True when pressed / False when released
		if event.pressed == false:
			emitting = true   # This will start the particle system
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
