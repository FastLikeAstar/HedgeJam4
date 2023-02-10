extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerScene
var guiScene
var bgTrees
# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_default_clear_color(Color("#012410"));
	# Load the Resource
	playerScene = load("res://player/Player.tscn");
	guiScene = load("res://Gui.tscn");
	var treeScene = load("res://level/Tree.tscn");
	var camera_path = $Camera2D.get_path();
	bgTrees = Array();
	var tempX;
	var tempY;
	var treeSizeOffset = 512;
	var tree;
	var treeCount = 0;

	var rng = RandomNumberGenerator.new();
	rng.randomize();
	
	var my_random_number = rng.randf_range(-64.0, 64.0);
	
	for n in range(-30, 30, 1):
		tempX = n * treeSizeOffset;
		for m in range(-30, 30, 1):
			if (treeCount < 3):
				tree = treeScene.instance();
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
				
					
		
	# Instance
	var player = playerScene.instance();
	player.add_camera(camera_path);
	var gui = guiScene.instance();
	# Add to World
	add_child(gui);
	add_child(player);

func _link_signals():
	pass
	
func _spawn_trees():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
