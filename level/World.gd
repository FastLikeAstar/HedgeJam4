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
var previousFruit = -1;
var gui;
var time_elapsed := 0.0;
var textFeedback = load("res://feedback/FloatingText.tscn");
var treeTypesRarity = [];
var best_time;

var bananaTexture = load("res://banana.png");
var banana2Texture = load("res://banana2.png");
var mangoTexture = load("res://mango.png");
var orangeTexture = load("res://orange.png");
var berryTexture = load("res://banana2.png");
var pineappleTexture = load("res://banana2.png");

# Called when the node enters the scene tree for the first time.
func _ready():
	VisualServer.set_default_clear_color(Color("#04000f"));
	# Load the Resource
	playerScene = load("res://player/Player.tscn");
	guiScene = load("res://Gui.tscn");
	var treeScene = load("res://level/Tree.tscn");
	var camera_path = $Camera2D.get_path();
	bgTrees = [];
	var tempX;
	var tempY;
	var treeSizeOffset = 768;
	var tree;
	var treeCount = 0;
	$EndScreen.visible = false;
	var currentTreeType;
	best_time = ScoreHolder.fastest_time;
	

	
	ultraRares = 1;
	rares = 3;
	uncommons = 4;
	commons = 5;


	var rng = RandomNumberGenerator.new();
	rng.randomize();
	
	fillTrees();

	var my_random_number = rng.randf_range(0, 64.0);
	
	for n in range(-7, 7, 1):
		tempX = n * treeSizeOffset;
		for m in range(-7, 7, 1):
			if (treeCount < 6):
				tree = treeScene.instance();
				currentTreeType = treeTypesRarity.pop_back();
				if (currentTreeType == null):
					fillTrees();
					currentTreeType = treeTypesRarity.pop_back();
				tree.treeType = currentTreeType;
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
		
	print("trees total " + str(bgTrees.size()));
	# Instance
	player = playerScene.instance();
	player.add_camera(camera_path);
	gui = guiScene.instance();
	# Add to World
	add_child(gui);
	add_child(player);
	player.connect("game_win", self, "game_won");
	player.connect("current_points", self, "update_points");
	player.connect("level_up", self, "update_level");


	
func fruit_consumed_update(fruit, fruitLocation):
	var exploding = false;
	var pointsAdded = 0;
	var speedChange = 0;
	if (!$DoneTimer.is_stopped()):
		$DoneTimer.stop()
	
	# True boonana
	if (fruit == 0):
		player.change_speed(-40);
		player.change_points(30);
		pointsAdded += 30;
		speedChange -= 40;
		$Hud/PointsCombo.set_texture(bananaTexture);
		$Hud/SpeedCombo.set_texture(orangeTexture);
		$Hud/PointsCombo.modulate = Color(1,1,1);
		$Hud/SpeedCombo.modulate = Color(1,1,1);
		if (previousFruit == 1):
			player.change_points(20);
			pointsAdded += 20;
			exploding = true;
		if (previousFruit == 2):
			player.change_speed(20);
			speedChange -= 20;
			exploding = true;
		
	# Boonana
	elif (fruit == 1):
		player.change_speed(-20);
		player.change_points(15);
		speedChange -= 20;
		pointsAdded += 15;
		$Hud/PointsCombo.set_texture(pineappleTexture);
		$Hud/SpeedCombo.set_texture(pineappleTexture);
		$Hud/PointsCombo.modulate = Color(1,1,1);
		$Hud/SpeedCombo.modulate = Color(1,0,0);
		if (previousFruit == 5):
			player.change_points(10);
			exploding = true;
			pointsAdded += 10;
		if (previousFruit == 6):
			player.change_speed(20);
			speedChange += 20;
			exploding = true;
			
	# Orange
	elif (fruit == 2):
		player.change_points(5);
		player.change_speed(10);
		pointsAdded += 5;
		speedChange += 10;
		$Hud/PointsCombo.set_texture(mangoTexture);
		$Hud/SpeedCombo.set_texture(berryTexture);
		$Hud/PointsCombo.modulate = Color(1,1,1);
		$Hud/SpeedCombo.modulate = Color(1,1,1);
		if (previousFruit == 3):
			player.change_points(10);
			exploding = true;
			pointsAdded += 10;
		if (previousFruit == 7):
			player.change_speed(60);
			speedChange += 60;
			exploding = true;
	
	# Mango 2
	elif (fruit == 3):
		player.change_points(5);
		pointsAdded += 5;
		$Hud/PointsCombo.set_texture(orangeTexture);
		$Hud/SpeedCombo.set_texture(mangoTexture);
		$Hud/PointsCombo.modulate = Color(1,0,0);
		$Hud/SpeedCombo.modulate = Color(1,0,0);
		if (previousFruit == 4):
			player.change_points(15);
			pointsAdded += 15;
			exploding = true;
		if (previousFruit == 8):
			player.change_speed(30);
			speedChange += 30;
			exploding = true;
		
	# Orange
	elif (fruit == 4):
		player.change_speed(10);
		speedChange += 10;
		$Hud/PointsCombo.set_texture(orangeTexture);
		$Hud/SpeedCombo.set_texture(berryTexture);
		$Hud/PointsCombo.modulate = Color(1,1,1);
		$Hud/SpeedCombo.modulate = Color(1,0,0);
		if (previousFruit == 2):
			player.change_points(15);
			pointsAdded += 15;
			exploding = true;
		if (previousFruit == 9):
			player.change_speed(40);
			speedChange += 40;
			exploding = true;
		
	# Pineapple 2
	elif (fruit == 5):
		player.change_speed(-10);
		player.change_points(10);
		speedChange -= 10;
		pointsAdded += 10;
		$Hud/PointsCombo.set_texture(banana2Texture);
		$Hud/SpeedCombo.set_texture(bananaTexture);
		$Hud/PointsCombo.modulate = Color(1,1,1);
		$Hud/SpeedCombo.modulate = Color(1,0,0);
		if (previousFruit == 1):
			player.change_points(15);
			pointsAdded += 15;
			exploding = true;
		if (previousFruit == 9):
			player.change_speed(50);
			speedChange += 50;
			exploding = true;
		
	#Pineapple
	elif (fruit == 6):
		player.change_points(5);
		pointsAdded += 5;
		$Hud/PointsCombo.set_texture(orangeTexture);
		$Hud/SpeedCombo.set_texture(bananaTexture);
		$Hud/PointsCombo.modulate = Color(1,1,1);
		$Hud/SpeedCombo.modulate = Color(1,0,0);
		if (previousFruit == 2):
			player.change_points(10);
			pointsAdded += 10;
			exploding = true;
		if (previousFruit == 9):
			player.change_speed(20);
			speedChange += 20;
			exploding = true;
		
	# Raspberry
	elif (fruit == 7):
		player.change_speed(2);
		player.change_points(1);
		speedChange += 2;
		pointsAdded += 1;
		$Hud/PointsCombo.set_texture(orangeTexture);
		$Hud/SpeedCombo.set_texture(bananaTexture);
		$Hud/PointsCombo.modulate = Color(1,1,1);
		$Hud/SpeedCombo.modulate = Color(1,0,0);
		if (previousFruit == 2):
			player.change_points(5);
			pointsAdded += 5;
			exploding = true;
		if (previousFruit == 9):
			player.change_speed(20);
			speedChange += 20;
			exploding = true;
		if (previousFruit == 7):
			player.change_speed(3);
			speedChange += 3;
			exploding = true;
	
	# Mango
	elif (fruit == 8):
		player.change_points(8);
		pointsAdded += 8;
		$Hud/PointsCombo.set_texture(orangeTexture);
		$Hud/SpeedCombo.set_texture(berryTexture);
		$Hud/PointsCombo.modulate = Color(1,0,0);
		$Hud/SpeedCombo.modulate = Color(1,1,1);
		if (previousFruit == 4):
			player.change_points(10);
			pointsAdded += 10;
			exploding = true;
		if (previousFruit == 7):
			player.change_speed(20);
			speedChange += 20;
			exploding = true;
			
	# Banana
	elif (fruit == 9):
		player.change_points(3);
		pointsAdded += 3;
		$Hud/PointsCombo.set_texture(pineappleTexture);
		$Hud/SpeedCombo.set_texture(mangoTexture);
		$Hud/PointsCombo.modulate = Color(1,1,1);
		$Hud/SpeedCombo.modulate = Color(1,0,0);
		if (previousFruit == 5):
			player.change_points(12);
			pointsAdded += 12;
			exploding = true;
		if (previousFruit == 8):
			player.change_speed(30);
			speedChange += 30;
			exploding = true;
	
	var text = textFeedback.instance();
	text.set_text(pointsAdded, exploding);
	text.position = fruitLocation;
	add_child(text);
	previousFruit = fruit;
	if (speedChange > 0):
		player.speedup_emit(speedChange);

func fillTrees():
		# Add rarities
	for n in ultraRares:
		treeTypesRarity.append(0); # 0 is the type that is ultra rare
	for n in rares:
		treeTypesRarity.append(1); # 1 is the type that is rare
		treeTypesRarity.append(2); # 2 is another rare type
	for n in uncommons:
		treeTypesRarity.append(3); # 1 is the type that is rare
		treeTypesRarity.append(4); # 2 is another rare type
	for n in commons:
		treeTypesRarity.append(5); # 1 is the type that is rare
		treeTypesRarity.append(6); # 2 is another rare type
		treeTypesRarity.append(7); # 2 is another rare type
		treeTypesRarity.append(8); # 2 is another rare type
	treeTypesRarity.shuffle();
	print("type of trees total " + str(treeTypesRarity.size()));

func game_won():
	$EndScreen.game_won(time_elapsed, best_time);
	$EndScreen.visible = true;
	if (time_elapsed < best_time):
		ScoreHolder.fastest_time = time_elapsed;
	
func update_points(points, fruitLevel):
	gui.update_points(points, fruitLevel);
	
func update_level(newLevel):
	gui.new_level(newLevel);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $DoneTimer.is_stopped():
		time_elapsed += delta;
		$Hud.update_time(time_elapsed);
	else:
		$Hud.update_count($DoneTimer.time_left);


func _on_DoneTimer_timeout():
	$EndScreen.visible = true;
