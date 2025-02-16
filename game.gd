extends TextureRect

var current = 0;
var piles = 0;
var noise = 0;

func _ready() -> void:
	Global.gold = 0;
	Global.dropped = 0;
	randomize_current();

func _process(_delta: float) -> void:
	%Total.text = "$%.0f" % Global.gold;
	%Current.text = "$%.0f" % current;
	%Smoke.scale_amount_min = lerp(1, 5, noise / 100.0);;
	%Smoke.scale_amount_max = lerpf(3, 10, noise / 100.0);
	%Smoke.initial_velocity_min = lerpf(50, 100, noise / 100.0);
	%Smoke.initial_velocity_max = lerpf(100, 200, noise / 100.0);

	if (Input.is_action_just_pressed("Flee")):
		_on_flee_pressed();
	elif (Input.is_action_just_pressed("Take")):
		_on_take_pressed();
	elif Input.is_action_just_pressed("Skip"):
		_on_skip_pressed();

func randomize_current():
	current = randi_range(1, 10 + (2 * piles));
	piles += 1;

func _on_flee_pressed() -> void:
	get_tree().change_scene_to_file("res://flee.tscn");

func _on_take_pressed() -> void:
	var noise_factor := randf_range(0.5, 2);
	noise += current * noise_factor;
	Global.gold += current;
	if (noise > 100):
		wake_up_dragon();
		return;
	if (noise < 0): noise = 0;
	randomize_current();

func wake_up_dragon():
	Global.dropped = randi_range(0, Global.gold / 2.0);
	Global.gold -= Global.dropped;
	get_tree().change_scene_to_file("res://caught.tscn");

func _on_skip_pressed() -> void:
	noise -= 10;
	if (noise < 0): noise = 0;
	randomize_current();
