extends VBoxContainer

func _ready() -> void:
	var index = HighScore.register_score(Global.gold);
	for i in range(5):
		var label = RichTextLabel.new();
		label.bbcode_enabled = true;
		label.fit_content = true;
		if (i == index):
			label.text = "[center][b]$%.0f (new!)[/b][/center]" % HighScore.high_scores[i];
		else:
			label.text = "[center]$%.0f[/center]" % HighScore.high_scores[i];
		add_child(label);
