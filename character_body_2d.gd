extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
var hasDoubleJumped = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		hasDoubleJumped = false

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and (is_on_floor() or !hasDoubleJumped):
		if not is_on_floor():
			hasDoubleJumped = true
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("player_left", "player_right")
	if direction:
		velocity.x = direction * SPEED
		if direction == 1: 
			$Sprite2D.flip_h = true
		else: 
			$Sprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
