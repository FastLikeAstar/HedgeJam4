extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


signal fruit_consumed;
var fruitType;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Fruit_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("fruit_consumed", fruitType);
		queue_free();
