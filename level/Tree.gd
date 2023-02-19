extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var treeType;
var fruitToSpawn;
var baseFruitSpawn = 1;


# Called when the node enters the scene tree for the first time.
func _ready():
	fruitToSpawn = load("res://level/Fruit.tscn"); # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func create_fruits(rng):
	var my_random_number = rng.randi_range(0, 1);
	var fruits = [];
	var fruit;
	var positionArray = []
	var fruitSizeOffset = 64;
	var newPosition;

	if treeType == 0:
		my_random_number = rng.randi_range(0, 1);
		baseFruitSpawn = 1 + my_random_number;
		$CPUParticles2D.amount = 30;
		$AnimatedSprite.frame = 4;
	elif treeType == 1:
		my_random_number = rng.randi_range(0, 4);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 24;
		$AnimatedSprite.frame = 4;
	elif treeType == 2:
		my_random_number = rng.randi_range(0, 2);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 24;
		$AnimatedSprite.frame = 3;
	elif treeType == 3:
		my_random_number = rng.randi_range(0, 2);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 18;
		$AnimatedSprite.frame = 0;
	elif treeType == 4:
		my_random_number = rng.randi_range(0, 3);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 18;
		$AnimatedSprite.frame = 3;
	elif treeType == 5:
		my_random_number = rng.randi_range(0, 2);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 18;
		$AnimatedSprite.frame = 2;
	elif treeType == 6:
		my_random_number = rng.randi_range(0, 3);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 12;
		$AnimatedSprite.frame = 2;
	elif treeType == 7:
		my_random_number = rng.randi_range(0, 8);
		baseFruitSpawn = 6 + my_random_number;
		$CPUParticles2D.amount = 12;
		$AnimatedSprite.frame = 0;
	elif treeType == 8:
		my_random_number = rng.randi_range(0, 2);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 12;
		$AnimatedSprite.frame = 1;
	elif treeType == 9:
		my_random_number = rng.randi_range(0, 5);
		baseFruitSpawn = 2 + my_random_number;
		$CPUParticles2D.amount = 12;
		$AnimatedSprite.frame = 1;
	var totalFruits = baseFruitSpawn + my_random_number;
	

	for m in range (-8, 7):
			my_random_number = rng.randi_range(-32,10);
			positionArray.append(Vector2((m * fruitSizeOffset)+ my_random_number,256 + my_random_number));
			positionArray.append(Vector2(256 + my_random_number, (m * fruitSizeOffset)+ my_random_number));
			positionArray.append(Vector2((m * fruitSizeOffset)+ my_random_number,-256 + my_random_number));
			positionArray.append(Vector2(-256 + my_random_number, (m * fruitSizeOffset)+ my_random_number));
	positionArray.shuffle();
	
	for n in totalFruits:
		fruit = fruitToSpawn.instance();
		add_child(fruit);
			
		fruit.position = positionArray.pop_back();
		fruit.assign_type(treeType);
		fruits.append(fruit);
	

	return fruits;
