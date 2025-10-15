# Game Description
Oh no! You are stuck in the world with a bunch of monsters and other things. The only thing you have left to do is collect coins, but at a cost - your life. Or at least you think. You are allowed to move using the left and right arrow keys and jump or double jump using the space bar. Beware!

# Alexander’s Pattern Format

Pattern: Coin Collection Component
-	Context: The game is one level, and I want to allow the player to play an endless level.
-	Problem: Unable to properly respawn coins without creating collection issues.
-	Solution: Keep track of the number of coins collected. After all coins are collected, respawn them with a slight delay so the player does not automatically collect a coin when they respawn. 
-	Example:

        func _on_respawn_signal():
            is_collected = false # set to not collected
            $Sprite2D.show()
            
        if coins_collected_this_cycle >= respawn_count_needed:
                respawn_signal.emit()
                
                coins_collected_this_cycle = 0	
        
        is_collected = false # set to not collected
        $Sprite2D.show()
        $CollisionShape2D.set_deferred("disabled", false) 

Pattern: Checkpoint Component
-	Context: Needed a solution for dying and keeping track of player location. Could have kept the player at the start point when they die, but that was to difficult.
-	Problem: Checkpoint indication is confusing for the player because the sound is repeated when touching the checkpoint, and the color remains constant.
-	Solution: Created a global variable to check if the player activated the checkpoint. Used a timer to check if the variable changed. If the global variable was not equal to self, it would unmark the checkpoint.
-	Example:

        func activate():
            if Global.checkpoint != self:
                self.modulate = Color(0.115, 0.115, 0.115, 1.0)
                $SonicCheckpoint.play()
                Global.checkpoint = self

        func _on_timer_timeout() -> void:
            if Global.checkpoint != self: 
                self.modulate = Color(1.0, 1.0, 1.0, 1.0)

Pattern: Signal Observer Pattern
-	Context: Have signals in place to detect score and health of the player.
-	Problem: Unable to distinguish which type of sound to use when attacked by different hazard systems. Have four sounds: Minecraft Steve Oof, C3PO Phrase, General Grievous Cough, and Lego Yoda Death Sound.
-	Solution: Created signals to keep track of health and score changed. In addition, took the node that attacked the user to indicate what sound should be played. Then used conditions to determine which sound to play based on the hazard type. 
-	Example:

        func add_score(amount):
            score += amount
            coins_collected_this_cycle += 1
            score_updated.emit(score)

        func decrease_health(amount, node_name):
            health -= amount
            name_of_node = node_name
            health_signal.emit(health, node_name)

        if new_health != 100 and new_health > 0: 
            if node_name.begins_with("Poison"):
                $GrievousCough.play()
            elif node_name == "Weapon":
                $Blaster.play()
            else:
                $SteveOldHurtSound.play()
 
# System Design

Health System: Player has a maximum of 100 health. The health decreases every time a player encounters a hazard. If the player reaches 0 health, they respawn to the most recent checkpoint they interacted with. The game displays health with a red bar, and the amount of health is displayed below that bar. The goal of the health system is to display the player's health and provide feedback when they take damage.

Hazard System: There are different hazards, including poison hazards, patrolling enemies, and trap weapons that activate when entering an area on one of the blocks. The poison hazard removes 5 health, patrolling enemies remove 10 health, and the trap weapon removes 30 health. Every time the player loses health, the sprite turns red, and a different sound effect plays based on the type of hazard. The goal of each hazard is to create different ways to harm the player and see how the player reacts to such hostile environments.

Respawn System: The system saves the player's position at several checkpoints. The skull icon is the checkpoint. When the player interacts with the checkpoint, a sound effect is played, and the icon turns black. If the player dies, they return to the most recent checkpoint they interacted with, and their health resets to 100. The number of points resets to 0. The goal of the respawn system is to enable players to start at specific positions on the map.
