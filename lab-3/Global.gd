extends Node

var last_checkpoint_position: Vector2 = Vector2.ZERO 

var score: int = 0
var health: int = 100
var coins_collected_this_cycle = 0 # number of coins collected
var respawn_count_needed = 27 # number of coins needed to respawn them all
var name_of_node = "" # for sounds after getting hit
var checkpoint = null # global checkpoint

signal score_updated(new_score)
signal respawn_signal
signal health_signal(new_health, node_name)

func add_score(amount):
	score += amount
	coins_collected_this_cycle += 1
	score_updated.emit(score)
	# if user has collected the number of coins needed to respawn the coins
	if coins_collected_this_cycle >= respawn_count_needed:
		# wait 1 second so the user does not automatically collect the coin
		await get_tree().create_timer(1).timeout
		respawn_signal.emit()
		coins_collected_this_cycle = 0 # reset number of coins collected

func decrease_health(amount, node_name):
	health -= amount
	name_of_node = node_name
	health_signal.emit(health, node_name)
		

	
