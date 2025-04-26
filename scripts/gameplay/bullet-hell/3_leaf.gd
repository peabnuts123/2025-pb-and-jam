extends State

func enter():
	super.enter()
	owner.alpha = 2
	owner.bullet_type = Content.BulletType.slow

func transition():
	if can_transition:
		get_parent().change_state("2Leaf")
