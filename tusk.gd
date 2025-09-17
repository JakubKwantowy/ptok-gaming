extends CharacterBody2D
var direction = 0
var SPEED = 100.0
var ptok = 0
var mode = 0
var modeTick = 0
var hasUsed = 0

func _ready() -> void:
	ptok = get_node("/root/Node2D/Ptok")

func _physics_process(delta: float) -> void:
	if mode == 0:
		if self.position.x > ptok.position.x :
			direction = -1
		else:
			direction = 1
		velocity.x = direction * SPEED
		modeTick += 1
		move_and_slide()
	if mode == 1:
		if not hasUsed:
			velocity.y = -1000
			position.y -= 15
			if self.position.x > ptok.position.x :
				direction = -1
			else:
				direction = 1
			hasUsed = 1
		if not hasUsed == 2:
			velocity.x = direction * SPEED * 10
		if (direction == 1 and (self.position.x + 1) > ptok.position.x) or (direction == -1 and (self.position.x - 1) < ptok.position.x):
			velocity.x = 0
			velocity.y = 400
			hasUsed = 2
		move_and_slide()
		if is_on_floor():
			velocity.y = -300
			mode = 0
			hasUsed = 0
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	if modeTick > 400:
		mode = randi_range(1, 1)
		modeTick = 0
