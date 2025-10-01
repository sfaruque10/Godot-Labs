extends Area2D
@onready var on_base_sound = $Mario

func _ready():
	body_entered.connect(_on_body_entered)
	#Scoring.speed_changed.connect(_on_body_entered)
	#_on_body_entered(Scoring.player_speed)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		on_base_sound.play() # mario coin sound
		Scoring.add_score(1) # increases score
		Scoring.increase_speed() # increase speed everytime base is touched
		body.speed = Scoring.player_speed
		#var enemies = get_tree().get_nodes_in_group("Philly")
		
		
		
