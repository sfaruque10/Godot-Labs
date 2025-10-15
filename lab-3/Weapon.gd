extends Area2D

var speed = 800
var damage = 30
#var direction = Vector2.RIGHT

func _ready() -> void:
	await get_tree().create_timer(2).timeout
	queue_free() # remove weapon

func _physics_process(delta):
	position.x += speed * delta
	
func _on_body_entered(body):
	if body.name == "Human" and Global.health > 0:
		Global.decrease_health(damage, self.get_groups()[0])
		
		if Global.health <= 0:
			body.respawn()
		else:
			body.modulate = Color(0.969, 0.426, 0.388, 1.0) 
			await get_tree().create_timer(1).timeout
			body.modulate = Color(1.0, 1.0, 1.0, 1.0)
		queue_free()
