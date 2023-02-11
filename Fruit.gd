extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


signal fruit_consumed;
var fruitType;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Player_area_entered(area):
	emit_signal("fruit_consumed", fruitType);
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
