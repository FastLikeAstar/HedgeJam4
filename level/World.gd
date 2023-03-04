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
var game_won = false;
var current_points_combo = -1;
var current_speed_combo = -1;

var bananaTexture = load("res://art/banana.png");
var banana2Texture = load("res://art/banana2.png");
var mangoTexture = load("res://art/mango.png");
var orangeTexture = load("res://art/orange.png");
var berryTexture = load("res://art/berry.png");
var pineappleTexture = load("res://art/pineapple.png");

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play_music("gameplay");
	VisualServer.set_default_clear_color(Color("#04000f"));
	# Load the Resource
	playerScene = load("res://player/Player.tscn");
	guiScene = load("res://level/Gui.tscn");
	var treeScene = load("res://level/Tree.tscn");
	var camera_path = $Camera2D.get_path();
	bgTrees = [];
	var tempX;
	var tempY;
	var treeSizeOffset = 640;
	var tree;
	var treeCount = 0;
	$EndScreen.visible = false;
	var currentTreeType;
	best_time = Highscore.fastest_time;
	

	
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
		AudioManager.play_fx("big_chomp");
		player.change_speed(-20);
		player.change_points(30);
		pointsAdded += 30;
		speedChange -= 20;
		$Hud.update_point_combo(1);
		$Hud/SpeedCombo.animation =  "pineapple";
		current_points_combo = 1;
		current_speed_combo = 2;
		if (previousFruit == 1):
			$Hud/BgButton/CPUParticles2D.emitting = true;
			player.change_points(20);
			pointsAdded += 20;
			exploding = true;
		if (previousFruit == 2):
			player.change_speed(20);
			speedChange -= 20;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
		
	# Boonana
	elif (fruit == 1):
		AudioManager.play_fx("big_chomp");
		player.change_speed(-10);
		player.change_points(15);
		speedChange -= 20;
		pointsAdded += 15;
		$Hud.update_point_combo(5);
		$Hud/SpeedCombo.animation =  "cherries";
		current_points_combo = 5;
		current_speed_combo = 6;
		if (previousFruit == 5):
			player.change_points(15);
			exploding = true;
			pointsAdded += 15;
			$Hud/BgButton/CPUParticles2D.emitting = true;
		if (previousFruit == 6):
			player.change_speed(30);
			speedChange += 30;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
			
	# Pineapple
	elif (fruit == 2):
		AudioManager.play_fx("big_chomp");
		player.change_points(6);
		player.change_speed(10);
		pointsAdded += 6;
		speedChange += 10;
		$Hud.update_point_combo(3);
		$Hud/SpeedCombo.animation =  "berry";
		current_points_combo = 3;
		current_speed_combo = 7;
		if (previousFruit == 3):
			player.change_points(13);
			exploding = true;
			pointsAdded += 13;
			$Hud/BgButton/CPUParticles2D.emitting = true;
		if (previousFruit == 7):
			player.change_speed(30);
			speedChange += 30;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
	
	# Melon
	elif (fruit == 3):
		AudioManager.play_fx("big_chomp");
		player.change_points(11);
		player.change_speed(-20);
		pointsAdded += 11;
		$Hud.update_point_combo(4);
		$Hud/SpeedCombo.animation =  "orange";
		current_points_combo = 4;
		current_speed_combo = 8;
		if (previousFruit == 4):
			player.change_points(16);
			pointsAdded += 16;
			exploding = true;
			$Hud/BgButton/CPUParticles2D.emitting = true;
		if (previousFruit == 8):
			player.change_speed(20);
			speedChange += 20;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
		
	# Mango
	elif (fruit == 4):
		AudioManager.play_fx("medium_chomp");
		player.change_points(4);
		pointsAdded += 4;
		player.change_speed(10);
		speedChange += 10;
		$Hud.update_point_combo(2);
		$Hud/SpeedCombo.animation =  "pear";
		current_points_combo = 2;
		current_speed_combo = 9;
		if (previousFruit == 2):
			player.change_points(11);
			pointsAdded += 11;
			exploding = true;
			$Hud/BgButton/CPUParticles2D.emitting = true;
		if (previousFruit == 9):
			player.change_speed(30);
			speedChange += 30;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
		
	# Grapes
	elif (fruit == 5):
		AudioManager.play_fx("small_chomp");
		player.change_points(3);
		pointsAdded += 3;
		$Hud.update_point_combo(1);
		$Hud/SpeedCombo.animation =  "pear";
		current_points_combo = 1;
		current_speed_combo = 9;
		if (previousFruit == 1):
			player.change_points(10);
			pointsAdded += 10;
			exploding = true;
			$Hud/BgButton/CPUParticles2D.emitting = true;
		if (previousFruit == 9):
			player.change_speed(25);
			speedChange += 25;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
		if (previousFruit == 5):
			player.change_points(1);
			pointsAdded += 1;
			exploding = true;
			$Hud/BgButton/CPUParticles2D.emitting = true;
		
	# Cherries
	elif (fruit == 6):
		AudioManager.play_fx("small_chomp");
		player.change_points(2);
		pointsAdded += 2;
		$Hud.update_point_combo(2);
		$Hud/SpeedCombo.animation =  "pear";
		current_points_combo = 2;
		current_speed_combo = 9;
		if (previousFruit == 2):
			player.change_points(10);
			pointsAdded += 10;
			exploding = true;
			$Hud/BgButton/CPUParticles2D.emitting = true;
		if (previousFruit == 9):
			player.change_speed(10);
			speedChange += 10;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
		if (previousFruit == 6):
			player.change_speed(1);
			speedChange += 1;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
		
	# Raspberry
	elif (fruit == 7):
		AudioManager.play_fx("small_chomp");
		player.change_speed(2);
		player.change_points(1);
		speedChange += 2;
		pointsAdded += 1;
		$Hud.update_point_combo(2);
		$Hud/SpeedCombo.animation =  "pear";
		current_points_combo = 2;
		current_speed_combo = 9;
		if (previousFruit == 2):
			player.change_points(5);
			pointsAdded += 5;
			exploding = true;
			$Hud/BgButton/CPUParticles2D.emitting = true;
		if (previousFruit == 9):
			player.change_speed(10);
			speedChange += 10;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
		if (previousFruit == 7):
			player.change_speed(2);
			speedChange += 2;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
	
	# Orange
	elif (fruit == 8):
		AudioManager.play_fx("medium_chomp");
		player.change_points(2);
		pointsAdded += 2;
		$Hud.update_point_combo(4);
		$Hud/SpeedCombo.animation =  "berry";
		current_points_combo = 4;
		current_speed_combo = 7;
		if (previousFruit == 4):
			player.change_points(4);
			pointsAdded += 4;
			exploding = true;
			$Hud/BgButton/CPUParticles2D.emitting = true;
		if (previousFruit == 7):
			player.change_speed(10);
			speedChange += 10;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
			
	# Pear
	elif (fruit == 9):
		AudioManager.play_fx("medium_chomp");
		player.change_points(3);
		pointsAdded += 3;
		$Hud.update_point_combo(5);
		$Hud/SpeedCombo.animation =  "orange";
		current_points_combo = 5;
		current_speed_combo = 8;
		if (previousFruit == 5):
			player.change_points(10);
			pointsAdded += 10;
			exploding = true;
			$Hud/BgButton/CPUParticles2D.emitting = true;
		if (previousFruit == 8):
			player.change_speed(15);
			speedChange += 15;
			exploding = true;
			$Hud/BgButton2/CPUParticles2D.emitting = true;
	
	var text = textFeedback.instance();
	text.set_text(pointsAdded, false);
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
		treeTypesRarity.append(5); # 1 is the type that is rare
	for n in commons:
		treeTypesRarity.append(6); # 2 is another rare type
		treeTypesRarity.append(7); # 2 is another rare type
		treeTypesRarity.append(8); # 2 is another rare type
		treeTypesRarity.append(9); # 2 is another rare type
	treeTypesRarity.shuffle();
	print("type of trees total " + str(treeTypesRarity.size()));

func game_won():
	game_won = true;
	$EndScreen.game_won(time_elapsed, best_time);
	$EndScreen.visible = true;
	if (time_elapsed < best_time):
		Highscore.fastest_time = time_elapsed;
	
func update_points(points, fruitLevel):
	gui.update_points(points, fruitLevel);
	
func update_level(newLevel):
	gui.level_up();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $DoneTimer.is_stopped() && game_won == false:
		time_elapsed += delta;
		$Hud.update_time(time_elapsed);
	else:
		$Hud.update_count($DoneTimer.time_left);


func _on_DoneTimer_timeout():
	$EndScreen.visible = true;
