extends CanvasLayer

######### initialise variables #########

# init pause screen variable
@onready var pause_screen = $GUI/PausedScreen
var is_paused = false

# init reference to upgrade menu
@onready var upgrade_menu = $GUI/UpgradeMenu

# init reference to inventory UI
@onready var inventory_ui = $GUI/InventoryUI

# init reference to next level button
@onready var next_level = $GUI/UpgradeMenu/MarginContainer/VBoxContainer/NextLevel

# init effect reference
@export var cant_afford: PackedScene

# init healthbar variable
@onready var healthbar = $GUI/Healthbar

# init money display
@onready var money_display = $GUI/MoneyDisplay

# init fade transition effect
@onready var fade = $GUI/Fade


# init reference to player
var player: Player = Manager.player_node

# init reference to level objective
@onready var level_objective = get_node("../LevelObjective")

# init references to upgrade options
# we will only ever have 3 upgrade options
@onready var upgrade_option_1: UpgradeOption = $GUI/UpgradeMenu/MarginContainer/VBoxContainer/UpgradeContainer/UpgradeOptions
@onready var upgrade_option_2: UpgradeOption = $GUI/UpgradeMenu/MarginContainer/VBoxContainer/UpgradeContainer/UpgradeOptions2
@onready var upgrade_option_3: UpgradeOption = $GUI/UpgradeMenu/MarginContainer/VBoxContainer/UpgradeContainer/UpgradeOptions3

# track which option is currently selected
# -1 means none have been selected
# 0 means 0th index, 1 means 1st index, etc of offered_upgrades
var selected_upgrade_option = -1

# an array of all offered upgrades
var offered_upgrades: Array[String] = []

# died message
@onready var died_message: Control = $GUI/Died

# bad coding
var first = true

######### my functions #########


# toggle pause screen
func togglePauseScreen():
	# if pause screen is on
	if pause_screen.visible:
		# we hide the pause screen
		pause_screen.hide()
		resumeGame()

	# otherwise, pause screen is off
	else:
		# we show the pause screen
		pause_screen.show()
		pauseGame()


# toggle the UI display 
func toggleInventory():

	if inventory_ui.visible:
		inventory_ui.hide()
		resumeGame()
	else:
		pauseGame()
		inventory_ui.show()


# toggle upgrade panel
func toggleUpgradePanel():
	
	# upgrade screen is already visible
	if upgrade_menu.visible:
		upgrade_menu.hide()
		# unpress all the buttons
		upgrade_option_1.button_pressed = false
		upgrade_option_2.button_pressed = false
		upgrade_option_3.button_pressed = false
		
		# unselect upgrade
		selected_upgrade_option = -1
		
		# revert colour back to normal
		next_level.add_theme_color_override("font_color", Color(1,1,1))
		
		resumeGame()
	
	# otherwise, show upgrade screen and pause
	else:
		# update cost colours
		if Manager.player_money >= upgrade_option_1.cost_value:
			upgrade_option_1.cost.remove_theme_color_override("font_color")
		
		if Manager.player_money >= upgrade_option_2.cost_value:
			upgrade_option_2.cost.remove_theme_color_override("font_color")
		
		if Manager.player_money >= upgrade_option_3.cost_value:
			upgrade_option_3.cost.remove_theme_color_override("font_color")
		
		
		upgrade_menu.show()
		pauseGame()


# pause game
func pauseGame():
	# actually pause the game
	# the root node of scene and all children that inherit will be paused
	# a node can specially be configured under the Process tab to not pause 
	# when the root node is paused, the HUD scene for example will not be paused 
	# because we specially configured it in under the Process tab
	get_tree().paused = true
	is_paused = true

# resume game
func resumeGame():
	# actually resume the game
	get_tree().paused = false
	is_paused = false


# get a random item from the database
func getRandomItem():
	# dblist is list of all valid/available upgrade options
	var dblist: Array[String] = []
	#check database
	for i in Database.UPGRADES:
		if i in offered_upgrades:
			pass
		elif Database.UPGRADES[i]["disabled"] == true:
			pass
		else:
			dblist.append(i)
	
	if dblist.size() < 1:
		return
	
	if first:
		first = false
		offered_upgrades.append("upgrade 1")
		return "upgrade 1"
	
	# pick a random item from list of available ones
	var randomItem=dblist.pick_random()
	
	# add random item to list of offered upgrades 
	offered_upgrades.append(randomItem)
	return randomItem


# get user input
func getInput():

	# if user hits escape
	if Input.is_action_just_pressed("escape"):
		# exit the upgrade panel if it is shown
		if upgrade_menu.visible:
			toggleUpgradePanel()
		elif inventory_ui.visible:
			toggleInventory()
		else:
			togglePauseScreen()
	
	# if user hits tab
	if Input.is_action_just_pressed("inventory"):
		if !upgrade_menu.visible && !pause_screen.visible: 
			toggleInventory()


# update health bar
func updateHealthbar():
		healthbar.value = player.health_component.health
		healthbar.max_value = player.health_component.max_health

# update money bar
func updateMoney():
	money_display.text = "$: " + str(Manager.player_money)

# assign upgrade options information
# like name, sprite, description
func assignUpgradeOptions():
	upgrade_option_1.assignItem(getRandomItem()) 
	upgrade_option_2.assignItem(getRandomItem())
	upgrade_option_3.assignItem(getRandomItem())


######### Godot functions #########

# Called when the node enters the scene tree for the first time.
func _ready():
	if !player:
		player = get_node("../Player")
	
	resumeGame()
	
	# connect signals
	if level_objective:
		level_objective.connect("show_upgrades", _on_show_upgrades)
	
	# assign upgrade options
	assignUpgradeOptions()
	
	#updateHealthbar()
	
	updateMoney()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if player dies
	if Manager.player_is_dead:
		died_message.modulate.a += 0.5 * delta
		died_message.modulate.a = min(died_message.modulate.a, 255)
	
	getInput()
	
	updateHealthbar()
	
	updateMoney()
	
	# fade effect
	if fade.modulate.a > 0:
		fade.modulate.a -= 0.7 * delta


######### Godot signal functions #########

# Called when menu button pressed
func _on_menu_button_pressed():
	#unpause
	resumeGame()
	
	# change scene to main menu scene
	
	get_tree().change_scene_to_file("res://Scenes/Levels/main_scene.tscn")

# Called when resume button pressed
func _on_resume_buttom_pressed():
	# toggle off the pause screen
	togglePauseScreen()

# Called when player enters level objective
func _on_show_upgrades():
	# show the upgrade panel
	toggleUpgradePanel()

# these are all called when corresponding upgrade buttons are pressed
func _on_upgrade_options_pressed():
	# only allowing one upgrade to be selected
	upgrade_option_2.button_pressed = false
	upgrade_option_3.button_pressed = false
	selected_upgrade_option = 0


func _on_upgrade_options_2_pressed():
	# only allowing one upgrade to be selected
	upgrade_option_1.button_pressed = false
	upgrade_option_3.button_pressed = false
	selected_upgrade_option = 1


func _on_upgrade_options_3_pressed():
	# only allowing one upgrade to be selected
	upgrade_option_1.button_pressed = false
	upgrade_option_2.button_pressed = false
	selected_upgrade_option = 2


# Called when next level button is pressed
func _on_next_level_pressed():
	
	
	# default upgrade is none
	var current_upgrade: String = "none"
	var current_upgrade_price = 0
	
	# if an upgrade is selected
	if (selected_upgrade_option != -1):
		current_upgrade = offered_upgrades[selected_upgrade_option]
		current_upgrade_price = Database.UPGRADES[current_upgrade]["cost"]
	
	# if player cant afford 
	if current_upgrade != "none" && current_upgrade_price > Manager.player_money:
		var effect: Label = cant_afford.instantiate()
		
		add_child(effect)
		
		toggleUpgradePanel()
		
		return

	resumeGame()
	
	Manager.player_money -= current_upgrade_price
	
	# proceed to the next level with the selected upgrade
	Manager.nextLevel(current_upgrade)


