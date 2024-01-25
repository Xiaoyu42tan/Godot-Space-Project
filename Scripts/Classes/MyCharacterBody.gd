extends CharacterBody2D

class_name MyCharacterBody
# we will design all entities with this custom class
var rotation_speed: float = 0

# all characters need to have ability to fire
signal is_firing

# universal death animation 
func increaseTransparency(delta):
	# decrease alpha value 
	modulate.a -= 1 * delta
	modulate.a = max(0, modulate.a)




