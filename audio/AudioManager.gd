extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currentMusic;
var playerLevel;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_fx(sound):
	match sound:
		"small_chomp":
			$SmallChomp.play();
		"medium_chomp":
			$MediumChomp.play();
		"big_chomp":
			$BigChomp.play();
		
	
func play_music(music):
	if (currentMusic != music):
		currentMusic = music;
		match music:
			"menu":
				$GameMusic.play();
			"gameplay":
				$MenuMusic.play();
	
func player_walking(level):
	match level:
		0:
			if ($Steps.playing == false):
				$Steps.play();
		1:
			if (!$Steps.playing):
				$Steps.play();
		2:
			if (!$BiggerSteps.playing):
				$BiggerSteps.play();
		3:
			if (!$BiggerSteps.playing):
				$BiggerSteps.play();
		4:
			if (!$GiantSteps.playing):
				$GiantSteps.play();
		
func player_idle():
	$GiantSteps.stop();
	$Steps.stop();
	$BiggerSteps.stop();
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func player_levelup():
	$LevelUp.play();
	
func player_speedup():
	$SpeedUp.play();

func play_hover():
	$Hover.play();
	
func play_click():
	$OnClick.play();
	
