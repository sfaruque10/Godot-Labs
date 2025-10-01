extends CharacterBody2D

@export var speed = Scoring.player_speed
var start_position: Vector2

func _ready() -> void:
	start_position = global_position
	
func _physics_process(_delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"): # move right
		direction.x += 1
	if Input.is_action_pressed("ui_left"): # move left
		direction.x -= 1
	if Input.is_action_pressed("ui_up"): # move up
		direction.y -= 1
	if Input.is_action_pressed("ui_down"): # move down
		direction.y += 1
		
	velocity = direction * speed
	move_and_slide()

func reset_position() -> void:
	global_position = start_position # reset player position
	velocity = Vector2.ZERO
