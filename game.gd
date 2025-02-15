extends TextureRect

var current = 0;
var piles = 0;
var noise = 0;

func _ready() -> void:
	Global.gold = 0;
	randomize_current();

func _process(_delta: float) -> void:
	%Total.text = "$%.0f" % Global.gold;
	%Current.text = "$%.0f" % current;

func randomize_current():
	current = randi_range(1, 10 + (2 * piles));
	piles += 1;

func _on_flee_pressed() -> void:
	get_tree().change_scene_to_file("res://flee.tscn");

func _on_take_pressed() -> void:
	var noise_factor := randf_range(0.5, 2);
	noise += current * noise_factor;
	if (noise > 100):
		wake_up_dragon();
		return;
	if (noise < 0): noise = 0;
	print(noise);
	Global.gold += current;
	randomize_current();

func wake_up_dragon():
	Global.gold -= randi_range(0, Global.gold / 2);
	get_tree().change_scene_to_file("res://flee.tscn");

func _on_skip_pressed() -> void:
	noise -= 10;
	if (noise < 0): noise = 0;
	print(noise);
	randomize_current();
