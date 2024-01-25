extends Node


@onready var level_objective = $LevelObjective

@onready var checkpoint = $Checkpoint
@onready var checkpoint_2 = $Checkpoint2
@onready var checkpoint_3 = $Checkpoint3

@onready var stage_1_enemies = $stage1enemies

var stage_2_enemies: Node2D
var stage_3_enemies: Node2D
var stage_4_enemies: Node2D


const LVL_11_STAGE_2 = preload("res://Scenes/Stages/lvl11stage2.tscn")
const LVL_11_STAGE_3 = preload("res://Scenes/Stages/lvl11stage3.tscn")
const LVL_11_STAGE_4 = preload("res://Scenes/Stages/lvl11stage4.tscn")

@onready var stage_2_spawn = $stage2spawn
@onready var stage_3_spawn = $stage3spawn
@onready var stage_4_spawn = $stage4spawn




# Called when the node enters the scene tree for the first time.
func _ready():
	level_objective.visible=false
	# add the stored player node to level
	add_child(Manager.player_node)
	
	checkpoint.connect("checkpoint_signal", onCheckpt)
	checkpoint_2.connect("checkpoint_signal", onCheckpt2)
	checkpoint_3.connect("checkpoint_signal", onCheckpt3)

func _process(_delta):
	if Manager.boss2_died:
		level_objective.visible = true


func onCheckpt():
	Manager.player_node.global_position = stage_2_spawn.global_position
	
	stage_1_enemies.queue_free()

	stage_2_enemies = LVL_11_STAGE_2.instantiate()
	call_deferred("deferred1")
	
	checkpoint.queue_free() 


func onCheckpt2():
	Manager.player_node.global_position = stage_3_spawn.global_position
	
	if stage_2_enemies:
		stage_2_enemies.queue_free()

	stage_3_enemies = LVL_11_STAGE_3.instantiate()
	call_deferred("deferred2")
	
	checkpoint_2.queue_free()

func onCheckpt3():
	Manager.player_node.global_position = stage_4_spawn.global_position
	
	if stage_3_enemies:
		stage_3_enemies.queue_free()

	stage_4_enemies = LVL_11_STAGE_4.instantiate()
	call_deferred("deferred3")

	checkpoint_3.queue_free()


func deferred1():
	get_tree().current_scene.add_child(stage_2_enemies)

func deferred2():
	get_tree().current_scene.add_child(stage_3_enemies)

func deferred3():
	get_tree().current_scene.add_child(stage_4_enemies)




func bossDied():
	level_objective.visible = true







