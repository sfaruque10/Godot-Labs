extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 700
var jumps = 0
var max_jumps = 2 # allow for double jump

func respawn():
	$Death_Sound.play()
	# create tween to fade out player
	var fade_out_tween = create_tween()
	fade_out_tween.tween_property(self, "modulate", Color(1, 1, 1, 0), .5)
	await fade_out_tween.finished # finish fade out
	# set user position to checkpoint
	if Global.last_checkpoint_position != Vector2.ZERO:
		self.global_position = Global.last_checkpoint_position
	else:
		self.global_position = Vector2(-450, 300)
	set_physics_process(false) # disable movements
	# fade in player
	var fade_in_tween = create_tween()
	# Fades from transparent (alpha = 0) to opaque (alpha = 1).
	fade_in_tween.tween_property(self, "modulate", Color(1, 1, 1, 1), .5)
	await fade_in_tween.finished # wait fade in
	set_physics_process(true) # enable movements
	# reset health and score
	Global.health = 100
	Global.health_signal.emit(100, "")
	Global.score = 0
	Global.score_updated.emit(0)
	Global.coins_collected_this_cycle = 0
	Global.respawn_signal.emit() # respawn coins
	velocity = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if !is_on_floor(): # make player fall to ground
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	else:
		jumps = 0 # reset number of jumps
	
	if Input.is_action_just_pressed("jump") and jumps < max_jumps:
		velocity.y = -jump_force
		jumps += 1 # increment number of jumps
		
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = speed * direction
	
	move_and_slide()
