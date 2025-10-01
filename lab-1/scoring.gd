extends Node

var score = 0
signal score_changed(new_score) # notify score change
var player_speed = 150
signal speed_changed(new_speed)
var high_score = 0
signal high_score_changed(new_high_score) # notify high score change

func add_score(amount):
	score += amount
	if score > high_score:
		high_score = score
	score_changed.emit(score) # emit signal when score changes
	high_score_changed.emit(high_score)
	print("Current Score: ", score)

func reset_score():
	score = 0
	score_changed.emit(score)
	print("Current Score: ", score)

func increase_speed():
	player_speed += 20
	speed_changed.emit((player_speed))
	print("Player Speed: ", player_speed)

func reset_speed():
	player_speed = 150
	speed_changed.emit((player_speed))
	print("Player Speed: ", player_speed)
