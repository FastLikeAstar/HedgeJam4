extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const filepath = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func load_highscores():
	var file = File.new();
	file.open(filepath, File.READ);
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
