extends Area2D

@export var value = 1

var is_collected = false

func _ready() -> void:
	Global.respawn_signal.connect(_on_respawn_signal)
	
func _on_body_entered(body: Node2D) -> void:
	if not is_collected and body.name == "Human":
		is_collected = true
		Global.add_score(value)
		$SuperMarioCoinSound.play()
		$Sprite2D.hide() # hide coin
		$CollisionShape2D.set_deferred("disabled", true) # turn off coin collision

func _on_respawn_signal():
	is_collected = false # set to not collected
	$Sprite2D.show() # show coin
	$CollisionShape2D.set_deferred("disabled", false) # allow collision
