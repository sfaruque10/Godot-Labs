extends Node2D

@export var person_scene: PackedScene
@export var number_of_people: int = 20
var people: Array[Node] = [] # array of all players created

func _ready():
	$WinningConditionTimer.start() # check for winning condition
	randomize()

	for i in range(number_of_people): # creates 20 people
		var person = person_scene.instantiate()
		person.name = "Person_%d" % i
		person.position = Vector2( # random areas on screen
			randf_range(-2500, 2500),
			randf_range(-1000,750)
		) # random positioning
		add_child(person)
		people.append(person) # add to array

	var peoples = []
	for child in get_children():
		if child.name.begins_with("Person"):
			peoples.append(child)
			
	# infect three random people and give 3 the antidote
	if peoples.size() > 0:
		var random_person = peoples[randi() % peoples.size()]
		random_person.infected()
		var second_random_person = peoples[randi() % peoples.size()]
		second_random_person.infected()
		var third_random_person = peoples[randi() % peoples.size()]
		third_random_person.infected()
		var fourth_random_person = peoples[randi() % peoples.size()]
		fourth_random_person.antidote()
		var fifth_random_person = peoples[randi() % peoples.size()]
		fifth_random_person.antidote()
		var sixth_random_person = peoples[randi() % peoples.size()]
		sixth_random_person.antidote()

func infected_count():
	var infected_amount = 0
	for person in people: # count how many people are sick
		if person.state == person.State.SICK:
			infected_amount += 1
	return infected_amount

func cured_count():
	var cured = 0
	for person in people: # count how many people have an antidote
		if person.state == person.State.ANTIDOTE:
			cured += 1
	return cured

func normal_people_count():
	var normal_people = 0
	for person in people: # count how many people are neither sick nor have an antidote
		if person.state == person.State.NOT_INFECTED:
			normal_people += 1
	return normal_people
	
func _on_timer_timeout():
	if infected_count() == 0: # if no one is sick 
		$WinningConditionTimer.stop()
		get_tree().paused = true
		result("The Cure Worked!")
		print("The Cure Worked!")
		
	if cured_count() == 0 and infected_count() > 0: # if no one has an antidote the infected win
		$WinningConditionTimer.stop()
		get_tree().paused = true
		result("The Infected Won!")
		print("The Infected Won!")

func result(text: String): # print out who won
	var label = $WinnerLayer/Result
	label.text = text
	label.visible = true
