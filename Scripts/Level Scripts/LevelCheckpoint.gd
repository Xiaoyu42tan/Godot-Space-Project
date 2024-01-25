extends Area2D

signal checkpoint_signal

func _on_body_entered(body):
	if body.is_in_group("player"):
		checkpoint_signal.emit()
