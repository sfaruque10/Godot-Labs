extends Node

@onready var score_label = $Score
@onready var health_label = $Health
@onready var health_bar = $HealthBar

func _ready() -> void:
	Global.score_updated.connect(_on_score_updated)
	Global.health_signal.connect(_on_health_changed)
	
	_on_score_updated(Global.score)
	_on_health_changed(Global.health, Global.name_of_node)
	
func _on_score_updated(new_score: int):
	score_label.text = "Score: " + str(new_score) # display score

func _on_health_changed(new_health: int, node_name):
	if new_health != 100 and new_health > 0: # player hurt sound if they are not dead
		if node_name.begins_with("Poison"):
			$GrievousCough.play()
		elif node_name == "Weapon":
			$Blaster.play()
		else:
			$SteveOldHurtSound.play()
		
	health_label.text = "Health: " + str(new_health) # display health
	health_bar.value = new_health
