extends Area2D

class_name Projectile

######### initialise variables #########

# init explosion scene
@export var explosion: PackedScene

# proj stats
@export var proj_speed: int = 250
@export var proj_damage: int = 30

# how far will the projectile go before disappearing
@export var proj_range: float = 50

var proj_travelled: float = 0

var proj_direction = Vector2.ZERO

var belongs_to_player: bool = false

var is_vanishing: bool = false


# default collision layer settings

# what collision layer the proj will belong to if it is a:
# player proj
var player_proj_collision_layer: int = Manager.player_proj_layer
# enemy proj
var enemy_proj_collision_layer: int = Manager.enemy_proj_layer

# what collision layer the proj scans collisions for if it is a:
# player proj
var player_proj_collision_mask: int = Manager.walls_layer | Manager.enemy_hitbox_layer
# enemy proj
var enemy_proj_collision_mask: int = Manager.walls_layer | Manager.player_hitbox_layer



######### my functions #########

# the angle given is the desired rotation of the proj
func setDirection(angle):
	
	# set the rotation
	rotation = angle
	
	# create the direction vector based on rotation
	proj_direction = Vector2(1,0).rotated(angle)

# explode and instantiate an explosion effect
func explode():
	# instantiate explosion
	var explosion_instance = explosion.instantiate()
	explosion_instance.position = get_global_position()
	get_tree().current_scene.add_child(explosion_instance)
	
	# delete current proj
	queue_free()

# make projectile vanish
func increaseTransparency(delta):
	# decrease alpha value 
	modulate.a -= 10 * delta
	if modulate.a <= 0:
		queue_free()

# assign collsion layer and mask
func assignCollision():
	if belongs_to_player:
		collision_layer = player_proj_collision_layer
		collision_mask = player_proj_collision_mask
	else: 
		# it belongs to enemy
		collision_layer = enemy_proj_collision_layer
		collision_mask = enemy_proj_collision_mask

# check if proj has exceeded its range
# if it has then it should disappear
func checkExceedsRange(delta):
	# add to its distance travelled
	proj_travelled += proj_speed * delta
	
	if proj_travelled > proj_range:
		is_vanishing = true


