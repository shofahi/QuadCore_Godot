extends CharacterBody2D

# Movement
const SPEED : float = 100.0

# Dash
const DASH_SPEED_MULTIPLIER : float = 4.0
const DASH_DURATION : float = 0.15
var is_dashing : bool = false
var dash_timer : float = 0.0

@onready var dash_cooldown_timer = $"Dash_Cooldown"
@onready var dash_ghost_timer = $Ghost_Timer
@onready var animation =  $AnimatedSprite2D
@export var dash_sprite_object: PackedScene

func _physics_process(delta: float) -> void:
	var input_direction := Input.get_vector("MOVE_LEFT", "MOVE_RIGHT", "MOVE_UP", "MOVE_DOWN")

	# Handle Dash Input
	if Input.is_action_just_pressed("DASH") and not is_dashing and dash_cooldown_timer.is_stopped():
		_start_dash()

	if is_dashing:
		velocity = input_direction * (SPEED * DASH_SPEED_MULTIPLIER)
		dash_timer -= delta
		if dash_timer <= 0:
			_end_dash()
	else:
		if input_direction.length_squared() > 0:
			velocity = input_direction * SPEED
		else:
			velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	_update_animation(input_direction)

	move_and_slide()

func _start_dash() -> void:
	is_dashing = true
	dash_timer = DASH_DURATION
	dash_cooldown_timer.start()
	dash_ghost_timer.start()

func _end_dash() -> void:
	is_dashing = false
	dash_timer = 0.0
	dash_ghost_timer.stop()

func _update_animation(input_direction: Vector2) -> void:
	if is_dashing:
		pass # For now, let walking animation play during dash
	elif input_direction.length_squared() > 0:
		# Player is moving
		if abs(input_direction.x) > abs(input_direction.y):
			# Horizontal movement is dominant
			if input_direction.x > 0:
				animation.play("MOVE_EAST")
			else:
				animation.play("MOVE_WEST")
		else:
			# Vertical movement is dominant or equal
			if input_direction.y > 0:
				animation.play("MOVE_SOUTH")
			else:
				animation.play("MOVE_NORTH")
	else:
		animation.stop()
		animation.frame = 0

func _instance_dash_sprite():
	var ghost : Sprite2D = dash_sprite_object.instantiate()
	get_parent().get_parent().add_child(ghost)

	ghost.global_position = global_position

	var current_animation_name = animation.animation
	var current_frame_index = animation.frame
	var current_frame_texture = animation.sprite_frames.get_frame_texture(current_animation_name,
																		current_frame_index)

	ghost.texture = current_frame_texture
	var scale_factor = 0.25
	ghost.scale = Vector2(scale_factor, scale_factor)

func _on_ghost_timer_timeout() -> void:
	_instance_dash_sprite()
