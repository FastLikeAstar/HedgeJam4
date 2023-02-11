extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var treeType;
var fruitToSpawn;
var baseFruitSpawn = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	fruitToSpawn = load("res://Fruit.tscn") # Replace with function body.

func _on_Player_area_entered(area):
	emit_signal("hit_tree");
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func create_fruits(rng):
	var my_random_number = rng.randi_range(0, 2);
	var fruits = [];
	var fruit;
	var totalFruits = baseFruitSpawn + my_random_number;
	
	
	for n in totalFruits:
		fruit = fruitToSpawn.instance();
		add_child(fruit);
		my_random_number = rng.randi_range(0,3);
		if (my_random_number < 1):
			my_random_number = rng.randi_range(64,191); # 255 - 64 & 0 +64
			fruit.position = Vector2(255, my_random_number);
		elif (my_random_number < 1):
			my_random_number = rng.randi_range(64,191); # 255 - 64 & 0 +64
			fruit.position = Vector2(-255, my_random_number);
		elif (my_random_number < 3):
			my_random_number = rng.randi_range(64,191); # 255 - 64 & 0 +64
			fruit.position = Vector2(my_random_number, 255);
		else:
			my_random_number = rng.randi_range(64,191); # 255 - 64 & 0 +64
			fruit.position = Vector2(my_random_number, -255);

		fruits.append(fruit);
	

	return fruits;
