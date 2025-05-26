extends CharacterBody2D

@export var speed: int = 1
@onready var player: Node2D = get_node("/root/World/Player")

func _physics_process(_delta: float) -> void:
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		#move_and_slide()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	# 'body' is the object that entered the Area2D (e.g. the Player)
	if body.is_in_group("Player"):
		print("aaaajjj")
