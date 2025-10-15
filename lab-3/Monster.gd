extends CharacterBody2D

@export var speed = 400
@export var gravity = 30
@onready var raycast = $RayCast2D
@onready var raycast1 = $RayCast2D2

var direction = 1
var damage = 10

func _physics_process(_delta: float) -> void:
	# swap direction if raycast collides so enemy does not fall
	if not raycast.is_colliding() or not raycast1.is_colliding():
		direction *= -1
			
	velocity.x = speed * direction
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Human" and Global.health > 0:
		Global.decrease_health(damage, self.name)

		if Global.health <= 0:
			body.respawn() # respawn if player dies
		else:
			# player color changes temporarily
			body.modulate = Color(0.969, 0.426, 0.388, 1.0) 
			await get_tree().create_timer(1).timeout
			body.modulate = Color(1.0, 1.0, 1.0, 1.0) 
