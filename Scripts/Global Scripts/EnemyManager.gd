extends Node

######### initialise variables #########

# signal all enemies to pathfind
signal pathfind_signal

# how frequently we want the pathfinding alg to run
# for all entities with pathfinding
@export var pathfind_freq: float = 0.2



var pathfind_timer: Timer




######### Godot functions #########

func _ready():
	# create the pathfind timer
	pathfind_timer = Timer.new()
	
	# configure timer
	pathfind_timer.one_shot = false
	pathfind_timer.autostart = true
	pathfind_timer.wait_time = pathfind_freq
	
	# its gonna emit a signal to emit another signal lol
	# but readability > slight inefficiency
	pathfind_timer.timeout.connect(_on_pathfind_timer_timeout)
	
	# add the timer to the global node
	
	# autoload scripts basically create singleton nodes that appear
	# in every scene, so any node that is a child of this singleton node
	# will never be freed from memory when scenes switch or anything
	add_child(pathfind_timer)




######### Godot signal functions #########

# emit a signal, to be received by all pathfinding entities
# this way, we dont have to set a timer for every single entity
# saving computation time
func _on_pathfind_timer_timeout():
	pathfind_signal.emit()

