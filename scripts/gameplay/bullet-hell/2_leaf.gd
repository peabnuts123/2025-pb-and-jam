extends State

func enter():
	super.enter()
	owner.alpha = 3

#transition back to 5 Leaf pattern, can change to anything
func transition():
	if can_transition:
		get_parent().change_state("5Leaf")
