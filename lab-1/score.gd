extends Label

func _ready():
	Scoring.score_changed.connect(_on_score_changed)
	_on_score_changed(Scoring.score)

func _on_score_changed(new_score):
	text = "How many bases can you reach?\nScore: " + str(new_score) + "\n High Score: " + str(Scoring.high_score)
