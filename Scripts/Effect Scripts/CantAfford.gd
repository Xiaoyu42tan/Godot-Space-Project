extends Label

func fadeAway(delta):
	modulate.a -= 0.5 * delta
	
	if modulate.a <= 0:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fadeAway(delta)
