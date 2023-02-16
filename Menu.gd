extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_default_clear_color(Color("#04000f"));


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_button_down():
	get_tree().change_scene("res://level/World.tscn");
	

