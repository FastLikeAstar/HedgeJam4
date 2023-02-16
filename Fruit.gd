extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


signal fruit_consumed;
var fruitType;
var location;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func assign_type(type):
	fruitType = type;
	if (fruitType == 9):
		$AnimatedSprite.animation =  "banana";
		self.modulate = Color(.8,0,0);
	elif (fruitType == 8):
		$AnimatedSprite.animation =  "mango";
		self.modulate = Color(0.8,0,0);
	elif (fruitType == 7):
		$AnimatedSprite.animation =  "mango";
		self.modulate = Color(0,0,1);
	elif (fruitType == 6):
		$AnimatedSprite.animation =  "orange";
		self.modulate = Color(0,0,1);
	elif (fruitType == 5):
		$AnimatedSprite.animation =  "banana";
		self.modulate = Color(0,0,1);
	elif (fruitType == 4):
		$AnimatedSprite.animation =  "orange";
		self.modulate = Color(0.8,0,0);
	elif (fruitType == 3):
		$AnimatedSprite.animation =  "mango";
		self.modulate = Color(1,1,1);
	elif (fruitType == 2):
		$AnimatedSprite.animation =  "orange";
		self.modulate = Color(1,1,1);
	elif (fruitType == 1):
		$AnimatedSprite.animation =  "banana";
		self.modulate = Color(1,1,1);
	elif (fruitType == 0):
		$AnimatedSprite.animation =  "banana2";
		self.modulate = Color(1,1,1);
	location = self.get_global_position();
	

func _on_Fruit_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("fruit_consumed", fruitType, location);
		queue_free();
