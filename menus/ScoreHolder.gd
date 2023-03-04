extends Node2D

var localScores =[]
var fastest_time;

func _ready():
	fastest_time = Highscore.fastest_time; #float in seconds
	load_table();

	
	#(score.player_name, str(int(score.score)));

func load_table():
	yield(SilentWolf.Scores.get_high_scores(20), "sw_scores_received");

	if (get_tree().current_scene.name == "MenuScreen"):
		print("Scores as is: " + str(SilentWolf.Scores.scores))
		for score in SilentWolf.Scores.scores:
			localScores.append([score.player_name, str(float(score.score))]);
		localScores = SilentWolf.Scores.scores;
		if (Highscore.fastest_time != null):
			yield(SilentWolf.Scores.get_score_position(Highscore.fastest_time), "sw_position_received");
		if (get_tree().current_scene.name == "res://menus/ScoreHolder.tscn"):
			var position = SilentWolf.Scores.position;
			if (position != null):
				$VBoxContainer/HBoxContainer/name.text = str(position);
				$VBoxContainer/HBoxContainer/Label3.text = str(Highscore.fastest_time);

			if (localScores.count() >0):
				$ScrollContainer/VBoxContainer/Score0/Label.text = "1.)";
				$ScrollContainer/VBoxContainer/Score0/name.text = str(SilentWolf.Scores.scores[0].player_name);
				$ScrollContainer/VBoxContainer/Score0/Label3.text = str(localScores[0][1]);

			if (localScores.count() >1):
				$ScrollContainer/VBoxContainer/Score1/Label.text = "2.)";
				$ScrollContainer/VBoxContainer/Score1/name.text = localScores[1].player_name;
				$ScrollContainer/VBoxContainer/Score1/Label3.text = localScores[1].score;
	
			if (localScores.count() >2):
				$ScrollContainer/VBoxContainer/Score2/Label.text = "3.)";
				$ScrollContainer/VBoxContainer/Score2/name.text = localScores[2].player_name;
				$ScrollContainer/VBoxContainer/Score2/Label3.text = localScores[2].score;
	
			if (localScores.count() >3):
				$ScrollContainer/VBoxContainer/Score3/Label.text = "4.)";
				$ScrollContainer/VBoxContainer/Score3/name.text = localScores[3].player_name;
				$ScrollContainer/VBoxContainer/Score3/Label3.text = localScores[3].score;
	
			if (localScores.count() >4):
				$ScrollContainer/VBoxContainer/Score4/Label.text = "5.)";
				$ScrollContainer/VBoxContainer/Score4/name.text = localScores[4].player_name;
				$ScrollContainer/VBoxContainer/Score4/Label3.text = localScores[4].score;
	
			if (localScores.count() >5):
				$ScrollContainer/VBoxContainer/Score5/Label.text = "6.)";
				$ScrollContainer/VBoxContainer/Score5/name.text = localScores[5].player_name;
				$ScrollContainer/VBoxContainer/Score5/Label3.text = localScores[5].score;
	
			if (localScores.count() >6):
				$ScrollContainer/VBoxContainer/Score6/Label.text = "7.)";
				$ScrollContainer/VBoxContainer/Score6/name.text = localScores[6].player_name;
				$ScrollContainer/VBoxContainer/Score6/Label3.text = localScores[6].score;
	
			if (localScores.count() >7):
				$ScrollContainer/VBoxContainer/Score7/Label.text = "8.)";
				$ScrollContainer/VBoxContainer/Score7/name.text = localScores[7].player_name;
				$ScrollContainer/VBoxContainer/Score7/Label3.text = localScores[7].score;
	
			if (localScores.count() >8):
				$ScrollContainer/VBoxContainer/Score8/Label.text = "9.)";
				$ScrollContainer/VBoxContainer/Score8/name.text = localScores[8].player_name;
				$ScrollContainer/VBoxContainer/Score8/Label3.text = localScores[8].score;
	
			if (localScores.count() >9):
				$ScrollContainer/VBoxContainer/Score9/Label.text = "10.)";
				$ScrollContainer/VBoxContainer/Score9/name.text = localScores[9].player_name;
				$ScrollContainer/VBoxContainer/Score9/Label3.text = localScores[9].score;
	
			if (localScores.count() >10):
				$ScrollContainer/VBoxContainer/Score10/Label.text = "11.)";
				$ScrollContainer/VBoxContainer/Score10/name.text = localScores[10].player_name;
				$ScrollContainer/VBoxContainer/Score10/Label3.text = localScores[10].score;
	
			if (localScores.count() >11):
				$ScrollContainer/VBoxContainer/Score11/Label.text = "12.)";
				$ScrollContainer/VBoxContainer/Score11/name.text = localScores[11].player_name;
				$ScrollContainer/VBoxContainer/Score11/Label3.text = localScores[11].score;
	
			if (localScores.count() >12):
				$ScrollContainer/VBoxContainer/Score12/Label.text = "13.)";
				$ScrollContainer/VBoxContainer/Score12/name.text = localScores[12].player_name;
				$ScrollContainer/VBoxContainer/Score12/Label3.text = localScores[12].score;
	
			if (localScores.count() >13):
				$ScrollContainer/VBoxContainer/Score13/Label.text = "14.)";
				$ScrollContainer/VBoxContainer/Score13/name.text = localScores[13].player_name;
				$ScrollContainer/VBoxContainer/Score13/Label3.text = localScores[13].score;
	
			if (localScores.count() >14):
				$ScrollContainer/VBoxContainer/Score14/Label.text = "15.)";
				$ScrollContainer/VBoxContainer/Score14/name.text = localScores[14].player_name;
				$ScrollContainer/VBoxContainer/Score14/Label3.text = localScores[14].score;
	
			if (localScores.count() >15):
				$ScrollContainer/VBoxContainer/Score15/Label.text = "16.)";
				$ScrollContainer/VBoxContainer/Score15/name.text = localScores[15].player_name;
				$ScrollContainer/VBoxContainer/Score15/Label3.text = localScores[16].score;
	
			if (localScores.count() >16):
				$ScrollContainer/VBoxContainer/Score16/Label.text = "17.)";
				$ScrollContainer/VBoxContainer/Score16/name.text = localScores[16].player_name;
				$ScrollContainer/VBoxContainer/Score16/Label3.text = localScores[16].score;
	
			if (localScores.count() >17):
				$ScrollContainer/VBoxContainer/Score17/Label.text = "18.)";
				$ScrollContainer/VBoxContainer/Score17/name.text = localScores[17].player_name;
				$ScrollContainer/VBoxContainer/Score17/Label3.text = localScores[17].score;
	
			if (localScores.count() >18):
				$ScrollContainer/VBoxContainer/Score18/Label.text = "19.)";
				$ScrollContainer/VBoxContainer/Score18/name.text = localScores[18].player_name;
				$ScrollContainer/VBoxContainer/Score18/Label3.text = localScores[18].score;
	
			if (localScores.count() >19):
				$ScrollContainer/VBoxContainer/Score19/Label.text = "20.)";
				$ScrollContainer/VBoxContainer/Score19/name.text = localScores[19].player_name;
				$ScrollContainer/VBoxContainer/Score19/Label3.text = localScores[19].score;


func _on_Button_pressed():
	get_tree().change_scene("res://menus/Menu.tscn");
