extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerScene
var guiScene
var bgTrees
var ultraRares;
var rares;
var uncommons;
var commons;
var player;
var previousFruit;


# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_default_clear_color(Color("#012410"));
	# Load the Resource
	playerScene = load("res://player/Player.tscn");
	guiScene = load("res://Gui.tscn");
	var treeScene = load("res://level/Tree.tscn");
	var camera_path = $Camera2D.get_path();
	bgTrees = [];
	var tempX;
	var tempY;
	var treeSizeOffset = 512;
	var tree;
	var treeCount = 0;

	

	
	ultraRares = 0;
	rares = 3;
	uncommons = 6;
	commons = 10;


	var rng = RandomNumberGenerator.new();
	rng.randomize();
	
	var treeTypesRarity = [];
	# Add rarities
	for n in ultraRares:
		treeTypesRarity.append(0); # 0 is the type that is ultra rare
	for n in rares:
		treeTypesRarity.append(1); # 1 is the type that is rare
		treeTypesRarity.append(2); # 2 is another rare type
	for n in rares:
		treeTypesRarity.append(3); # 1 is the type that is rare
		treeTypesRarity.append(4); # 2 is another rare type
	for n in rares:
		treeTypesRarity.append(5); # 1 is the type that is rare
		treeTypesRarity.append(6); # 2 is another rare type
		treeTypesRarity.append(7); # 2 is another rare type
		treeTypesRarity.append(8); # 2 is another rare type
		
	treeTypesRarity.shuffle();
	
	var my_random_number = rng.randf_range(0, 64.0);
	
	for n in range(-30, 30, 1):
		tempX = n * treeSizeOffset;
		for m in range(-30, 30, 1):
			if (treeCount < 3):
				tree = treeScene.instance();
				tree.treeType = treeTypesRarity.pop_back();
				my_random_number = rng.randf_range(-64.0, 64.0);
				tempY = m * treeSizeOffset;
				tree.position.x = tempX + my_random_number;
				my_random_number = rng.randf_range(-64.0, 64.0);
				tree.position.y = tempY + my_random_number;
				bgTrees.append(tree);
				add_child(tree);
				treeCount += 1;
								
			else:
				treeCount = rng.randi_range(0,4);
				
					
	for n in bgTrees:
		var fruits = n.create_fruits(rng);
		for m in fruits:
			m.connect("fruit_consumed", self, "fruit_consumed_update");
		
	# Instance
	player = playerScene.instance();
	player.add_camera(camera_path);
	var gui = guiScene.instance();
	# Add to World
	add_child(gui);
	add_child(player);


	
func fruit_consumed_update(fruit):
	if (fruit == 0):
		player.change_speed(-40);
		player.change_points(60);
	elif (fruit == 1):
		player.change_speed(-20);
		player.change_points(40);
	elif (fruit == 2):
		player.change_points(15);
		player.change_speed(30);
	elif (fruit == 3):
		player.change_points(20);
	elif (fruit == 4):
		player.change_speed(40);
	elif (fruit == 5):
		player.change_speed(-10);
		player.change_points(25);
	elif (fruit == 6):
		player.change_points(10);
		player.change_speed(15);
	elif (fruit == 7):
		player.change_speed(5);
		player.change_points(5);
	elif (fruit == 8):
		player.change_points(5);
		player.change_speed(20);
	elif (fruit == 9):
		player.change_points(10);
		player.change_speed(10);
	previousFruit = fruit;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
