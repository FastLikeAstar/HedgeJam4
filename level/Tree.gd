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


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func create_fruits(rng):
	var my_random_number = rng.randi_range(0, 1);
	var fruits = [];
	var fruit;
	var totalFruits = baseFruitSpawn + my_random_number;
	if treeType == 0:
		my_random_number = rng.randi_range(0, 1);
		baseFruitSpawn = 1 + my_random_number;
		$CPUParticles2D.amount = 30;
	elif treeType == 1:
		my_random_number = rng.randi_range(0, 4);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 24;
	elif treeType == 2:
		my_random_number = rng.randi_range(0, 2);
		baseFruitSpawn = 3 + my_random_number;
		$CPUParticles2D.amount = 24;
	elif treeType == 3:
		my_random_number = rng.randi_range(0, 2);
		baseFruitSpawn = 3 + my_random_number;
		$CPUParticles2D.amount = 18;
	elif treeType == 4:
		my_random_number = rng.randi_range(0, 3);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 18;
	elif treeType == 5:
		my_random_number = rng.randi_range(0, 2);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 18;
	elif treeType == 6:
		my_random_number = rng.randi_range(0, 3);
		baseFruitSpawn = 3 + my_random_number;
		$CPUParticles2D.amount = 12;
	elif treeType == 7:
		my_random_number = rng.randi_range(0, 10);
		baseFruitSpawn = 6 + my_random_number;
		$CPUParticles2D.amount = 12;
	elif treeType == 8:
		my_random_number = rng.randi_range(0, 2);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 12;
	elif treeType == 9:
		my_random_number = rng.randi_range(0, 5);
		baseFruitSpawn = 3 + my_random_number;
		$CPUParticles2D.amount = 12;
	
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
		fruit.assign_type(treeType);
		fruits.append(fruit);
	

	return fruits;
