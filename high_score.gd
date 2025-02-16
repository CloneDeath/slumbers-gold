extends Node

const default_scores = [1000, 750, 500, 250, 150];

var high_scores = default_scores.duplicate();
var save_path = "user://high_scores.save"

func _ready():
	load_high_scores()

func save_high_scores():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_var(high_scores)
		file.close()

func load_high_scores():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		if file:
			high_scores = file.get_var()
			file.close()
	else:
		high_scores = default_scores.duplicate();

func register_score(score: int) -> int:
	high_scores.append(score)
	high_scores.sort_custom(func(a, b): return a > b)
	if high_scores.size() > 5:
		high_scores.resize(5)
	var position = high_scores.find(score)
	if position >= 5:
		position = -1
	save_high_scores()
	return position
