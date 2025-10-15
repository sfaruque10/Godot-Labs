extends Area2D

var damage = 5

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Human" and Global.health > 0:
		Global.decrease_health(damage, self.name)
		if Global.health <= 0:
			body.respawn() # respawn if player dies
		else:
			body.modulate = Color(0.969, 0.426, 0.388, 1.0)  
			await get_tree().create_timer(4).timeout
			body.modulate = Color(1.0, 1.0, 1.0, 1.0) 
