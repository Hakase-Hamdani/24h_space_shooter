extends Sprite


const SCREEN_WIDTH = 320
var scroll_speed = 30.0


# Called when the node enters the scene tree for the first time.
func _process(delta):
	position += Vector2(-scroll_speed * delta, 0.0)
	if position.x <= -SCREEN_WIDTH:
		position.x += SCREEN_WIDTH


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
