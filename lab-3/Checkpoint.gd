extends Area2D

@export var respawn_position: Marker2D
var activated = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Human":
		activate()

		if respawn_position != null: # new respawn position
			Global.last_checkpoint_position = respawn_position.global_position

func activate():
	if Global.checkpoint != self:
		self.modulate = Color(0.115, 0.115, 0.115, 1.0)
		$SonicCheckpoint.play() # checkpoint sound
		Global.checkpoint = self

func _on_timer_timeout() -> void:
	if Global.checkpoint != self: # change color of checkpoint
		self.modulate = Color(1.0, 1.0, 1.0, 1.0)
