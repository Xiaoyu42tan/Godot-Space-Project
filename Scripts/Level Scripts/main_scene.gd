extends Node

######### initialise variables #########

# get reference to player inv and equipment
var player_inventory: Inventory = preload("res://Inventory Items/PlayerInventory.tres")
var player_equipment: Equipment = preload("res://Inventory Items/PlayerEquipment.tres")

# get reference to default weapon
const BULLET_SHOOTER = preload("res://Inventory Items/Items/BulletShooter.tres")
const ENERGY_BLASTER = preload("res://Inventory Items/Items/EnergyBlaster.tres")
const THICK_BLASTER = preload("res://Inventory Items/Items/ThickBlaster.tres")
const TURRET_WEAPON = preload("res://Inventory Items/Items/TurretWeapon.tres")
const RAY_BLASTER = preload("res://Inventory Items/Items/RayBlaster.tres")

const FLAME_BLASTER = preload("res://Inventory Items/Items/FlameBlaster.tres")
const INVERTED_BLASTER = preload("res://Inventory Items/Items/InvertedBlaster.tres")
const INVERTED_HEAVY = preload("res://Inventory Items/Items/InvertedHeavy.tres")
const NOT_A_BLASTER = preload("res://Inventory Items/Items/NotABlaster.tres")
const RAPID_BLASTER = preload("res://Inventory Items/Items/RapidBlaster.tres")


######### my functions #########

# clear player's inventory and equipment
func resetInvAndEquipment():
	for i in range(player_inventory.items.size()):
		player_inventory.items[i] = null
	
	for i in range(player_equipment.items.size()):
		player_equipment.items[i] = null
	
	# give the player a default weapon to start
	player_inventory.items[0] = BULLET_SHOOTER
	#player_inventory.items[1] = TURRET_WEAPON
	#player_inventory.items[2] = THICK_BLASTER
	#player_inventory.items[3] = ENERGY_BLASTER
	#player_inventory.items[4] = RAY_BLASTER
	#
#
	#
	#player_inventory.items[5] = FLAME_BLASTER
	#player_inventory.items[6] = INVERTED_BLASTER
	#player_inventory.items[7] = INVERTED_HEAVY
	#player_inventory.items[8] = NOT_A_BLASTER
	#player_inventory.items[9] = RAPID_BLASTER
	




######### Godot functions #########

func _ready():
	# respawn player 
	Manager.player_is_dead = false

	Manager.player_node = null
	
	# reset money
	Manager.player_money = 200
	
	# reset the player's inv
	resetInvAndEquipment()
	
	# reset boss
	Manager.boss1_died = false
	Manager.boss2_died = false


######### Godot signal functions #########

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level_1.tscn")

