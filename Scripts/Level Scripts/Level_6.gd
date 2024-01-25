extends Node



@onready var boss_1 = $Boss1

@onready var level_objective = $LevelObjective


# Called when the node enters the scene tree for the first time.
func _ready():
	level_objective.visible=false
	# add the stored player node to level
	add_child(Manager.player_node)

func _process(delta):
	if boss_1 == null:
		level_objective.visible = true
