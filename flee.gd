extends TextureRect

func _ready() -> void:
	%Score.text = "$%.0f" % Global.gold;


func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn");
