extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var player_name = "";
var current_round;
var canSubmit = false;

func _on_PlayAgain_button_down():
	get_tree().change_scene("res://level/World.tscn");


func _on_MainMenu_button_down():
	get_tree().change_scene("res://menus/Menu.tscn");

func game_won(points :float, previous_highscore:float):
	var thisMinutes := points / 60;
	var thisSeconds := fmod(points, 60);
	var thisRun = "%02d:%02d" % [thisMinutes, thisSeconds];
	current_round = thisRun;
	var minutes := previous_highscore / 60;
	var seconds := fmod(previous_highscore, 60);
	var highscore = "%02d:%02d" % [minutes, seconds];
	canSubmit = true;
	
	$VBoxContainer/HBoxContainer/PreviousHighscore.text = $VBoxContainer/HBoxContainer/PreviousHighscore.text + highscore;
	$VBoxContainer/HBoxContainer5/Score.text = $VBoxContainer/HBoxContainer5/Score.text + thisRun;


func _on_Button_pressed():
	var player_name = $VBoxContainer/HBoxContainer6/LineEdit.text
	if (!player_name.empty() && canSubmit):
		canSubmit = false;
		SilentWolf.Scores.persist_score(player_name, current_round);
