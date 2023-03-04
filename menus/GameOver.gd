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
	var thisSeconds := fmod(points, 60);
	var thisRun = "%02d" % [thisSeconds];
	current_round = thisSeconds;
	var seconds := previous_highscore;
	var highscore = "%02d" % [seconds];
	canSubmit = true;
	
	$VBoxContainer/HBoxContainer/PreviousHighscore.text = $VBoxContainer/HBoxContainer/PreviousHighscore.text + highscore;
	$VBoxContainer/HBoxContainer5/Score.text = $VBoxContainer/HBoxContainer5/Score.text + thisRun;


func _on_Button_pressed():
	var player_name = $VBoxContainer/HBoxContainer6/LineEdit.text
	if (!player_name.empty() && canSubmit):
		canSubmit = false;
		SilentWolf.Scores.persist_score(player_name, current_round);
