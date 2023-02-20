extends Node2D

var scores =[]
var fastest_time;

func _ready():
	fastest_time = 180.0; #float in seconds
	load_table();

	
	#(score.player_name, str(int(score.score)));

func load_table():
	yield(SilentWolf.Scores.get_high_scores(20), "sw_scores_received");
	if (get_tree().current_scene.name == "res://menus/ScoreHolder.tscn"):
		scores = SilentWolf.Scores.scores;
		if (Highscore.fastest_time != null):
			yield(SilentWolf.Scores.get_score_position(Highscore.fastest_time), "sw_position_received");
		if (get_tree().current_scene.name == "res://menus/ScoreHolder.tscn"):
			var position = SilentWolf.Scores.position;
			if (position != null):
				$VBoxContainer/HBoxContainer/name.text = str(position);
				$VBoxContainer/HBoxContainer/Label3.text = Highscore.fastest_time;

			if (scores.count() >0):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "1.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[0].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[0].score;

			if (scores.count() >1):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "2.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[1].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[1].score;
	
			if (scores.count() >2):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "3.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[2].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[2].score;
	
			if (scores.count() >3):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "4.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[3].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[3].score;
	
			if (scores.count() >4):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "5.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[4].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[4].score;
	
			if (scores.count() >5):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "6.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[5].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[5].score;
	
			if (scores.count() >6):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "7.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[6].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[6].score;
	
			if (scores.count() >7):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "8.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[7].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[7].score;
	
			if (scores.count() >8):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "9.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[8].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[8].score;
	
			if (scores.count() >9):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "10.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[9].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[9].score;
	
			if (scores.count() >10):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "11.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[10].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[10].score;
	
			if (scores.count() >11):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "12.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[11].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[11].score;
	
			if (scores.count() >12):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "13.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[12].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[12].score;
	
			if (scores.count() >13):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "14.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[13].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[13].score;
	
			if (scores.count() >14):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "15.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[14].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[14].score;
	
			if (scores.count() >15):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "16.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[15].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[16].score;
	
			if (scores.count() >16):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "17.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[16].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[16].score;
	
			if (scores.count() >17):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "18.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[17].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[17].score;
	
			if (scores.count() >18):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "19.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[18].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[18].score;
	
			if (scores.count() >19):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "20.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = scores[19].player_name;
				$ScrollContainer/VBoxContainer/Score0/Label3.text = scores[19].score;


func _on_Button_pressed():
	get_tree().change_scene("res://menus/Menu.tscn");
