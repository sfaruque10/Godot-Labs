extends Area2D

@export var weapon_scene: PackedScene
var player = null

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Human":
		player = body
		call_deferred("launch_weapon")

func launch_weapon():
	# instantiate weapon
	var weapon_instance = weapon_scene.instantiate()
	weapon_instance.name = "Weapon"
	get_tree().root.add_child(weapon_instance)
	# set location of weapon 400 pixels to the left
	weapon_instance.global_position = global_position + Vector2(-400, 0)
	$MinecraftFirework.play()
