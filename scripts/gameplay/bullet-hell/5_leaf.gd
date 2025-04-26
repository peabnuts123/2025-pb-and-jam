extends State

func enter():
	super.enter()
	owner.alpha = 1.3
	owner.bullet_type = Content.BulletType.default
	speed.start()

func transition():
	if can_transition:
		get_parent().change_state("4Leaf")
