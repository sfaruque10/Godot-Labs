Agents: 
-	Move in various directions
-	Has the states NOT_INFECTED, SICK, ANTIDOTE
-	NOT_INFECTED are healthy
-	SICK individuals have the infection and are spreading the infection
-	ANTIDOTE are individuals who have a cure and can give it to others
-	Each agent interacts with each other using collision

Different rules are established in this game. Suppose infected individuals come into contact with individuals who are not infected or have an antidote. In that case, there is a 50% chance that the non-infected individual or the person with an antidote will contract the infection. If the sick agent comes into contact with an antidote agent, there is a 50% chance that they will be cured. If sick agents interact with an antidote agent, they both move in the opposite direction. If a not-infected agent touches a sick agent, the not-infected agent moves in the opposite direction. Antidote agents have a 50% chance of losing the antidote after 5 seconds. Sick agents have a 50% chance of recovering after 5 seconds.
Some observed emergent behavior during testing was that clusters of sick and antidote agents formed early and interacted with each other. In addition, chain reactions occurred when sick and antidote agents were placed in a zone with non-infected agents, causing the non-infected agents to become sick or receive the antidote. 
Overall, the game attempts to mirror real-world systems, such as the spread of disease. There was no player control, but interesting behavior emerged from watching the agents. Tweaking specific rules, such as infection and cure rates, speed, and duration of illness and cure, can significantly change system behavior. While testing with the same rules, some tests ended in everyone getting infected, others in rapid curing of agents, and sometimes a long standoff between infected and cured individuals.
