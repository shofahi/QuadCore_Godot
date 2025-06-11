extends Sprite2D

func _ready():

	var tween = create_tween()

	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_callback(queue_free)
