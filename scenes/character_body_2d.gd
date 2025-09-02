extends CharacterBody2D
@onready var label: Label = $"../Label"
var health:= 100
const SPEED = 500.0
const JUMP_VELOCITY = -800.0
const Antijumpvelocity = 200
func _display_health():
	label.text = "health : %d" % health
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_released("jump") and not is_on_floor():
		velocity.y = Antijumpvelocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction:= Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()
	_display_health()
