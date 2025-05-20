extends CharacterBody2D

# Movement
const SPEED : float = 300.0

# Dash
const DASH_SPEED_MULTIPLIER : float = 3.0
const DASH_DURATION : float = 0.15 
var isDashing : bool = false
var dashTimer : float = 0.0 

# Reference to your Dash Cooldown Timer node
@onready var Dash_Cooldown_Timer = $"Dash_Cooldown"

func _physics_process(delta: float) -> void:
	var input_direction := Input.get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_UP", "MOVE_DOWN")

	# Handle Dash Input
	if Input.is_action_just_pressed("DASH") and not isDashing and Dash_Cooldown_Timer.is_stopped():
		_start_dash(input_direction)

	if isDashing:
		velocity = input_direction * (SPEED * DASH_SPEED_MULTIPLIER)
		dashTimer -= delta
		if dashTimer <= 0:
			_end_dash()
	else:
		if input_direction.length_squared() > 0:
			velocity = input_direction * SPEED
		else:
			velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()

func _start_dash(input_dir: Vector2) -> void:
	isDashing = true
	dashTimer = DASH_DURATION
	Dash_Cooldown_Timer.start() 

func _end_dash() -> void:
	isDashing = false
	dashTimer = 0.0
