extends MyCharacterBody

# inherits from MyCharacterBody and will have functions for   
# Enemy AI and other things enemies exclusively share
class_name MyEnemyBody

######### initialise variables #########

const ORANGE_ALERT_EFFECT = preload("res://Scenes/Effects/OrangeAlertEffect.tscn")
const RED_ALERT_EFFECT = preload("res://Scenes/Effects/RedAlertEffect.tscn")

# drop money on death
@export var enemy_worth: int = 50


# AI stuff
# all enemies should have this
var has_seen_player: bool = false
var is_dead: bool = false



######### my functions #########


# some standard enemy actions

# set the enemy to pathfind to a position
func moveTo(pos: Vector2, pathfind_component: PathfindComponent, 
		move_component: MovementComponent):
	
	# set pathfinder's target position
	pathfind_component.target_pos = pos
	
	# where is the pathfind alg currently pointing to?
	var pathfind_dir: Vector2 = pathfind_component.current_dir
	
	# go forward and rotate if needed
	move_component.forward_backward = 1
	rotateToward(pathfind_dir, move_component)

# stop and shoot at a position
func stopAndShoot(pos: Vector2, move_component: MovementComponent):
	# stop
	move_component.forward_backward = 0
	
	# aim
	# direction is the direction vector from
	# the entity's current position to the target position
	var direction = pos - global_position
	rotateToward(direction, move_component)
	
	# angle to target
	var angle: float = rad_to_deg(move_component.face_dir.angle_to(direction))
	
	# if the angle is less than 10 degrees, 
	# then we have successfully aimed, and will start shooting
	if abs(angle) < move_component.aim_accuracy_angle:
		# shoot 
		is_firing.emit()

# stop moving entirely
func stopMoving(move_component: MovementComponent):
	move_component.forward_backward = 0
	move_component.rotation_direction = 0

# rotate towards a direction vector
func rotateToward(direction: Vector2, move_component: MovementComponent):
	# find which way to rotate 
	var angle: float = rad_to_deg(move_component.face_dir.angle_to(direction))
	
	# decide whether we need to rotate or not
	# if angle between desired vector and current dir vector 
	# is > aim_accuracy_angle degrees
	# then we need to rotate
	if abs(angle) > move_component.aim_accuracy_angle:
		if angle < 0:
			# Counterclockwise rotation is faster
			move_component.rotation_direction = -1
		else:
			# Clockwise rotation is faster
			move_component.rotation_direction = 1
	else: 
		# dont rotate
		move_component.rotation_direction = 0

# red alert: alerts all enemies in range
func redAlert(sight_component: SightComponent):
	
	# do the visual effect
	var effect_instance = RED_ALERT_EFFECT.instantiate()
	effect_instance.position = get_global_transform().get_origin() + Vector2(0, -10)
	get_tree().current_scene.add_child(effect_instance)
	
	# get alerted
	has_seen_player = true
	
	# alert all enemies in range
	for enemy: MyEnemyBody in sight_component.allies_in_range:
		if enemy != self && enemy.has_seen_player == false:
			enemy.orangeAlert()

# orange alert: when an enemy is alerted by red alert
func orangeAlert():
	
	# do the visual effect
	var effect_instance = ORANGE_ALERT_EFFECT.instantiate()
	effect_instance.position = get_global_transform().get_origin() + Vector2(0, -10)
	get_tree().current_scene.add_child(effect_instance)
	
	# get alerted
	has_seen_player = true

# die process
func die(delta):
	increaseTransparency(delta)
	if modulate.a <= 0:
		queue_free()


