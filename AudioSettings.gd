extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var masterVolume;
var fxVolume;
var musicVolume;
var spacebarVolume;

var masterOn;
var fxOn;
var musicOn;
var spacebarOn;

# Called when the node enters the scene tree for the first time.
func _ready():
	masterVolume = AudioServer.get_bus_volume_db(0);
	fxVolume = AudioServer.get_bus_volume_db(2);
	musicVolume = AudioServer.get_bus_volume_db(1);
	spacebarVolume = AudioServer.get_bus_volume_db(4);
	masterOn = AudioServer.is_bus_mute(0);
	fxOn = AudioServer.is_bus_mute(2);
	musicOn = AudioServer.is_bus_mute(1);
	spacebarOn = AudioServer.is_bus_mute(4);


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


	


func _on_masterVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value);
	AudioManager.play_fx("big_chomp");



func _on_musicVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(1, value);



func _on_fxVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(2, value);
	AudioServer.set_bus_volume_db(3, value);
	AudioManager.play_fx("big_chomp")



func _on_spacebarVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(4, value);
	AudioManager.play_click();



func _on_masterMute_toggled(button_pressed):
	AudioServer.set_bus_mute(0,!button_pressed);
	AudioManager.play_click();



func _on_spacebarMute_toggled(button_pressed):
	AudioServer.set_bus_mute(4,!button_pressed);
	AudioManager.play_click();



func _on_fxMute_toggled(button_pressed):
	AudioServer.set_bus_mute(2,!button_pressed);
	AudioServer.set_bus_mute(3,!button_pressed);
	AudioManager.play_click();



func _on_musicMute_toggled(button_pressed):
	AudioServer.set_bus_mute(1,!button_pressed);
	AudioManager.play_click();



func _on_Button_pressed():
	self.visible = false;



func _on_masterMute_mouse_entered():
	AudioManager.play_hover();


func _on_musicMute_mouse_entered():
	AudioManager.play_hover();



func _on_fxMute_mouse_entered():
	AudioManager.play_hover();



func _on_spacebarMute_mouse_entered():
	AudioManager.play_hover();

