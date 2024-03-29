extends Node


@onready var level_objective = $LevelObjective

@onready var checkpoint = $Checkpoint
@onready var checkpoint_2 = $Checkpoint2
@onready var stage_2_spawn = $Stage2Spawn
@onready var stage_3_spawn = $Stage3Spawn

@onready var stage_1_enemies = $Stage1Enemies

@onready var hud = $HUD


var stage_2_enemies: Node2D
var stage_3_enemies: Node2D

const LVL_6_STAGE_2: PackedScene = preload("res://Scenes/Stages/lvl6stage2.tscn")
const LVL_6_STAGE_3 = preload("res://Scenes/Stages/lvl6stage3.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	level_objective.visible=false
	# add the stored player node to level
	add_child(Manager.player_node)
	
	checkpoint.connect("checkpoint_signal", onCheckpt)
	checkpoint_2.connect("checkpoint_signal", onCheckpt2)

func _process(_delta):
	if Manager.boss1_died:
		level_objective.visible = true




func onCheckpt():
	Manager.player_node.global_position = stage_2_spawn.global_position
	
	hud.fade.modulate.a = 1
	
	stage_1_enemies.queue_free()

	stage_2_enemies = LVL_6_STAGE_2.instantiate()
	call_deferred("deferred1")
	
	
	
	checkpoint.queue_free()
	

func onCheckpt2():
	Manager.player_node.global_position = stage_3_spawn.global_position
	
	hud.fade.modulate.a = 1
	
	if stage_2_enemies:
		stage_2_enemies.queue_free()

	stage_3_enemies = LVL_6_STAGE_3.instantiate()
	call_deferred("deferred2")
	
	
	
	checkpoint_2.queue_free() 

func deferred1():
	get_tree().current_scene.add_child(stage_2_enemies)

func deferred2():
	get_tree().current_scene.add_child(stage_3_enemies)



func bossDied():
	level_objective.visible = true
