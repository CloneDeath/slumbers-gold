extends TextureRect

func _ready() -> void:
	%Score.text = "$%.0f" % Global.gold;
	%Dropped.text = "$%.0f" % Global.dropped;

func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn");

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Skip")):
		_on_play_again_pressed();
