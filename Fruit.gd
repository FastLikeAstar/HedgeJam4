extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


signal fruit_consumed;
var fruitType;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func assign_type(type):
	fruitType = type;
	if (fruitType == 9):
		$AnimatedSprite.animation =  "mango";
	elif (fruitType == 8):
		$AnimatedSprite.animation =  "orange";
	elif (fruitType == 7):
		$AnimatedSprite.animation =  "banana";
	elif (fruitType == 6):
		$AnimatedSprite.animation =  "orange";
	elif (fruitType == 5):
		$AnimatedSprite.animation =  "banana";
	elif (fruitType == 4):
		$AnimatedSprite.animation =  "mango";
	elif (fruitType == 3):
		$AnimatedSprite.animation =  "banana";
	elif (fruitType == 2):
		$AnimatedSprite.animation =  "orange";
	elif (fruitType == 1):
		$AnimatedSprite.animation =  "banana2";
	elif (fruitType == 1):
		$AnimatedSprite.animation =  "banana2";

func _on_Fruit_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("fruit_consumed", fruitType);
		queue_free();
