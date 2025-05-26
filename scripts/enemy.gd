extends CharacterBody2D

enum State {IDLE, CHASING, ATTACKING, STUNNED, DYING}

const DEFAULT_SPEED := 60
const CHASE_DISTANCE := 150
const LEASE_DISTANCE := 180
const INITIAL_STATE := State.IDLE

@export var speed: float = DEFAULT_SPEED

var player: Node2D
var state: State = INITIAL_STATE

func _ready() -> void:
	player = get_node("/root/World/Player")

func _physics_process(delta: float) -> void:
	match state:
		State.IDLE:
			state_idle(delta)
		State.CHASING:
			state_chase(delta)
		State.ATTACKING:
			# TODO: Implement attack
			#state_attack(delta)
			pass
		State.STUNNED:
			# TODO: Implement stunned
			#state_stun(delta)
			pass
		State.DYING:
			# TODO: Implement dying :(
			#state_die(delta)
			pass

func state_idle(_delta: float) -> void:
	if is_instance_valid(player):
		if global_position.distance_to(player.global_position) < CHASE_DISTANCE:
			set_state(State.CHASING)

func state_chase(_delta: float) -> void:
	if not is_instance_valid(player):
		return

	var distance := global_position.distance_to(player.global_position)
	if distance > LEASE_DISTANCE:
		set_state(State.IDLE)

	# TODO: Implement attacking based on distance to player

	var direction := (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func set_state(new_state: State) -> void:
	if (new_state == state):
		return
	state = new_state

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Player"):
		print("Ajj!")
