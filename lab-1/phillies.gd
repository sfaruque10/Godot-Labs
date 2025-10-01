extends CharacterBody2D

@export var speed: float = 200.0 
@onready var tag_sound_player = $Area2D/Error_Sound
@onready var timer = $Timer
var move_direction: int = 1

func _physics_process(_delta):
	velocity.x = speed * move_direction # moves to the right
	if is_on_wall():
		move_direction *= -1
	move_and_slide()

func _on_timer_timeout():
	move_direction *= -1 # moves to the left
	timer.start()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		tag_sound_player.play()
		move_direction *= -1 # change direction on impact
		Scoring.reset_score() # resets score on contact
		Scoring.reset_speed() # resets speed on contact
		body.speed = Scoring.player_speed
