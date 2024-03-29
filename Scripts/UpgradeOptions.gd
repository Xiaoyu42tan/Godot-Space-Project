extends Button

class_name UpgradeOption

@onready var upgrade_name = $VBoxContainer/UpgradeName
@onready var upgrade_description = $VBoxContainer/UpgradeDesc
@onready var upgrade_icon = $UpgradeIcon
@onready var cost = $Cost

var cost_value: int = 0


######### initialise variables #########




######### my functions #########

# based on the key that we received, we will assign 
# information 

func assignItem(item):
	upgrade_name.text = Database.UPGRADES[item]["displayname"]
	upgrade_description.text = Database.UPGRADES[item]["details"]
	upgrade_icon.texture = Database.UPGRADES[item]["texture"]
	cost_value = Database.UPGRADES[item]["cost"]
	cost.text = "$" + str(cost_value)
	
	if Database.UPGRADES[item]["cost"] > Manager.player_money:
		cost.add_theme_color_override("font_color", Color(1,0,0))





######### Godot functions #########




######### Godot signal functions #########


