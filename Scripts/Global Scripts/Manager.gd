extends Node

######### initialise variables #########

var player_is_dead: bool = false
# init mask settings
var player_layer: int = 1 << 0
var walls_layer: int = 1 << 1
var player_proj_layer: int = 1 << 2
var enemy_layer: int = 1 << 3
var enemy_proj_layer: int = 1 << 4
var enemy_hitbox_layer: int = 1 << 5
var player_hitbox_layer: int = 1 << 6

var player_node: Player

# init resources
const BULLET_SHOOTER = preload("res://Inventory Items/Items/BulletShooter.tres")
const TURRET_WEAPON = preload("res://Inventory Items/Items/TurretWeapon.tres")
const THICK_BLASTER = preload("res://Inventory Items/Items/ThickBlaster.tres")
const ENERGY_BLASTER = preload("res://Inventory Items/Items/EnergyBlaster.tres")
const RAY_BLASTER = preload("res://Inventory Items/Items/RayBlaster.tres")

const FLAME_BLASTER = preload("res://Inventory Items/Items/FlameBlaster.tres")
const INVERTED_BLASTER = preload("res://Inventory Items/Items/InvertedBlaster.tres")
const INVERTED_HEAVY = preload("res://Inventory Items/Items/InvertedHeavy.tres")
const NOT_A_BLASTER = preload("res://Inventory Items/Items/NotABlaster.tres")
const RAPID_BLASTER = preload("res://Inventory Items/Items/RapidBlaster.tres")

# currency system
var player_money: int = 0


# bugfix
var boss1_died: bool = false
var boss2_died: bool = false



######### my functions #########

# call deferred, because otherwise godot 4.2 complains
func nextLevel(upgrade: String):
	# save current player node
	var level_node = get_tree().current_scene

	# store it in player_node
	player_node = level_node.get_node("Player")
	# disconnect from parent so that when parent gets queue_free()ed 
	# it doesnt also get queue freed
	player_node.get_parent().remove_child(player_node)
	
	# upgrade the player with the upgrade
	upgradePlayer(upgrade)
	
	# set player velocity to 0
	player_node.velocity = Vector2.ZERO
	player_node.rotation_speed = 0
	player_node.global_position = Vector2.ZERO
	
	# reset player health
	#restore_health()
	
	call_deferred("nextLevelDeferred")

# function to actually change the scene
# parses current level name
func nextLevelDeferred():
	# change the scene
	get_tree().change_scene_to_file(
		"res://Scenes/Levels/Level_" + 
		str((get_tree().current_scene.name.to_int())+1)+ ".tscn"
	)

# function for character upgrading
func upgradePlayer(upgrade):
	match upgrade:
		"upgrade 1":
			player_node.health_component.max_health += 1000
			player_node.health_component.health = player_node.health_component.max_health
		
		"upgrade 2":
			player_node.teleport_unlocked = true
			Database.UPGRADES[upgrade]["disabled"] = true
			
		"upgrade 3":
			addToInventory(TURRET_WEAPON)
			
		"upgrade 4":
			addToInventory(BULLET_SHOOTER)
			
		"upgrade 5":
			player_node.move_component.max_speed += 50
			player_node.move_component.acceleration *= 1.5
			player_node.move_component.friction += 200
			
			
			
			
		"upgrade 6":
			player_node.turret_mode_unlocked = true
			Database.UPGRADES[upgrade]["disabled"] = true
		
		"upgrade 7":
			addToInventory(THICK_BLASTER)
		
		"upgrade 8":
			addToInventory(ENERGY_BLASTER)
		
		"upgrade 9":
			addToInventory(RAY_BLASTER)
		
		"upgrade 10":
			addToInventory(FLAME_BLASTER)
		
		"upgrade 11":
			addToInventory(INVERTED_BLASTER)
		
		"upgrade 12":
			addToInventory(INVERTED_HEAVY)
		
		"upgrade 13":
			addToInventory(NOT_A_BLASTER)
		
		"upgrade 14":
			addToInventory(RAPID_BLASTER)

		
		
		# switch statement default (else):
		_:
			pass
			#print("no upgrade selected")

func addToInventory(item: InventoryItem):
	for i in range(player_node.inventory.items.size()):
		if player_node.inventory.items[i] == null:
			player_node.inventory.items[i] = item
			return

func restore_health():
	#player_node.health_component.health = player_node.health_component.max_health
	print("overhealing")
	player_node.health_component.health = 1000000

######### Godot functions #########




######### Godot signal functions #########


