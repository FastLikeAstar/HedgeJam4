extends Position2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_text(number, exploding):
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://PatrickHand-Regular.ttf");
	dynamic_font.size = number+10 * 2;
	$RichTextLabel.set("custom_fonts/normal_font", dynamic_font)
	#$RichTextLabel.get_font("font").set_size(number+10);
	var biggerNumber = number*10;
	#$RichTextLabel.bbcode_text = "[rainbow freq=1 sat=2 val=1]"+ str(biggerNumber)+"[/rainbow]";
	$RichTextLabel.bbcode_text = "[rainbow freq=1 sat=0.5 val=1]"+ str(biggerNumber)+"[/rainbow]";
	$RichTextLabel.rect_size = dynamic_font.get_string_size($RichTextLabel.bbcode_text);
	$CPUParticles2D.amount = biggerNumber + 32;

	$CPUParticles2D.restart();
	$CPUParticles2D.emitting = exploding;
	$CPUParticles2D.one_shot = true;
	#$RichTextLabel.scale(number);
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	modulate.a = 0.2;
