extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
		SilentWolf.configure({
		"api_key": "wOI5XlyzzC1jvrkmaVzv860Vg7iIKSuh4b7MBAmf",
		"game_id": "oonanalovesbloonanas",
		"game_version": "1.1.0",
		"log_level": 2
			});
			
		SilentWolf.configure_scores({
		"open_scene_on_close": "res://menus/Menu.tscn"
		});
		
		get_tree().change_scene("res://menus/Menu.tscn");


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
