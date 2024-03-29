extends Node2D

class_name SightComponent

######### initialise variables #########

signal can_see_player

# get reference to enemy
@onready var entity: CharacterBody2D = get_parent()


# field of vision settings
@onready var vision_cone = $VisionCone

@export var vision_cone_angle: float = 30
@export var angle_between_rays: float = 10

# what max distance can the enemy see? 
@export var view_distance: float = 150

# what max distance will enemy start shooting at?
@export var shoot_distance: float = 70

# what distance can enemy alert allies at?
@export var ally_range: float = 70
@onready var ally_detector: CollisionShape2D = $AllyRange/DetectorShape

# track list of all allies in contact range
var allies_in_range: Array[MyEnemyBody]


# raycast circle
# like a bucket fill in a circle shape
# basically a collision circle that cant go through walls
@onready var raycast_circle: RayCast2D = $CircleSweeper

@onready var raycircle_collider: CollisionShape2D = $OptimiseRaycircle/RaycircleShape

var player_in_raycircle = false
var player_within_radius = false

var raycast_created = false

######### my functions #########

# create the rays
func createRaycasts():

	vision_cone_angle = deg_to_rad(vision_cone_angle)
	angle_between_rays = deg_to_rad(angle_between_rays)
	
	var num_rays = vision_cone_angle / angle_between_rays
	
	for index in num_rays:
		var ray = RayCast2D.new()
		var angle = angle_between_rays * (index - num_rays / 2.0)
		ray.target_position = Vector2(0,1).rotated(angle) * view_distance
		
		# set to parent's collision mask
		ray.collision_mask = entity.collision_mask
		
		vision_cone.add_child(ray)
		
		ray.enabled = true

# create the raycircle
func createRaycircle():
	# set circle sweeper radius
	raycast_circle.target_position = Vector2(0, shoot_distance)
	
	# set the circle collision radius same as circle sweeper radius
	raycircle_collider.shape.radius = shoot_distance

# create the ally detector
func createAllyDetector():
	ally_detector.shape.radius = ally_range


# check if player is in enemy's line of sight
# we are gonna use raycasting to check if it can see 
func checkForPlayer():
	for ray: RayCast2D in vision_cone.get_children():
		if ray.is_colliding() and ray.get_collider().is_in_group("player"):
			can_see_player.emit()
			break

# check if player is within the raycast circle
func sweepForPlayer():
	var cast_count = int((2 * PI) / angle_between_rays) + 1
	
	for index in cast_count:
		var cast_vector = (
			shoot_distance * 
			Vector2(0,1).rotated(angle_between_rays * (index - cast_count / 2.0))
		)
		
		raycast_circle.target_position = cast_vector
		raycast_circle.force_raycast_update()
		if raycast_circle.is_colliding() and raycast_circle.get_collider().is_in_group("player"):
			player_in_raycircle = true
			return

	player_in_raycircle = false


######### Godot functions #########

func _ready():
	createRaycasts()
	createRaycircle()
	createAllyDetector()


func _physics_process(delta):
	if Manager.player_is_dead:
		return
	
	checkForPlayer()
	
	if player_within_radius:
		sweepForPlayer()



######### Godot signal functions #########

func _on_optimise_raycircle_body_entered(body):
	if body.is_in_group("player"):
		player_within_radius = true
		sweepForPlayer()
		
		

func _on_optimise_raycircle_body_exited(body):
	if body.is_in_group("player"):
		player_in_raycircle = false
		player_within_radius = false


func _on_ally_range_body_entered(body):
	allies_in_range.append(body)


func _on_ally_range_body_exited(body):
	allies_in_range.erase(body)
