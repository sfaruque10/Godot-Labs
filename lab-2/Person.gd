extends Area2D
enum State {SICK, NOT_INFECTED, ANTIDOTE} # different health states
var state = State.NOT_INFECTED # initial state is healthy
var speed = 400 # default speed
var direction := Vector2.ZERO
var original_color: Color # color of sprite

func _ready():
	original_color = $Sprite2D.modulate
	direction = Vector2( # randomized directions
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()

	$Sprite2D.flip_h = direction.x < 0
	
func _process(delta: float) -> void:
	move(delta)
	
func move(delta):
	var screen_size_x = 2500
	var screen_size_y = 1000
	position += direction*speed*delta

	if position.x < -screen_size_x or position.x > screen_size_x:
		direction.x *= -1 # negate x direction if going past screen size
		$Sprite2D.flip_h = direction.x < 0

	if position.y < -screen_size_y or position.y > 750:
		direction.y *= -1 # negate x direction if going past screen size

func infected():
	state = State.SICK # change state
	speed = 500
	$Sprite2D.modulate = Color.RED
	var random_float = randf()
	await get_tree().create_timer(5.0).timeout
	if random_float < 0.5: # player can recover
		state = State.NOT_INFECTED
		$Sprite2D.modulate = original_color # go back to original color
		speed = 400

		
func antidote():
	state = State.ANTIDOTE
	speed = 500
	$Sprite2D.modulate = Color.AQUAMARINE
	var random_float = randf()
	await get_tree().create_timer(5.0).timeout
	if random_float < 0.5: # antidote might not work
		state = State.NOT_INFECTED
		$Sprite2D.modulate = original_color
		speed = 400

func _on_area_entered(area: Area2D) -> void:
	var random_float = randf() # generate random number
	if area.state == State.SICK and (state == State.NOT_INFECTED or state == State.ANTIDOTE):
		direction *= -1 # flip sprite and direction if not sick and touching infected
		$Sprite2D.flip_h = ! $Sprite2D.flip_h
	if area.state == State.ANTIDOTE and state == State.SICK:
		direction *= -1 # flip if sick and touching someone with antidote
		$Sprite2D.flip_h = ! $Sprite2D.flip_h
	
	if random_float < 0.5 and (area.state == State.NOT_INFECTED or area.state == State.ANTIDOTE) and state == State.SICK: 
		area.infected() 
	if random_float >= 0.5 and (area.state == State.NOT_INFECTED or area.state == State.SICK) and state == State.ANTIDOTE: 
		area.antidote()
