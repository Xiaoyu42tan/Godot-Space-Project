extends Node

#database of upgrades to be applied to the player

# upgrade textures

# weapon textures
var test_weapon_texture: Texture2D = preload("res://Sprites/Weapons/test weapon.png")
var turret_weapon_texture: Texture2D = preload("res://Sprites/Weapons/Turret Weapon.png")
var thicc_blaster_texture: Texture2D = preload("res://Sprites/Weapons/ThickBlaster.png")
var energy_blaster_texture: Texture2D = preload("res://Sprites/Weapons/EnergyBlaster.png")
var raygun_texture: Texture2D = preload("res://Sprites/Weapons/Raygun.png")

const FLAME_BLASTER = preload("res://Sprites/Weapons/FlameBlaster.png")
const INVERTED_BLASTER = preload("res://Sprites/Weapons/InvertedBlaster.png")
const INVERTED_HEAVY = preload("res://Sprites/Weapons/InvertedHeavy.png")
const NOT_A_BLASTER = preload("res://Sprites/Weapons/NotABlaster.png")
const RAPID_BLASTER = preload("res://Sprites/Weapons/RapidBlaster.png")




# other textures
var heart_texture: Texture2D = preload("res://Sprites/Others/Heart.png")
var move_speed_texture: Texture2D = preload("res://Sprites/Others/Movement Speed.png")

var teleport_icon: Texture2D = preload("res://Sprites/Others/Teleport Icon.png")
var turret_icon: Texture2D = preload("res://Sprites/Others/Turret Mode Icon.png")

var not_drawn_yet: Texture2D = preload("res://Sprites/Others/notDrawnYet.png")



var UPGRADES = {
	"upgrade 1": {
		
		"displayname": "Max Health Up",
		"details" : "Increase Max Health by 100",
		"texture" : heart_texture,
		"disabled" : false,
		"cost" : 100
	},
	
	"upgrade 2": {
		
		"displayname": "Unlock Teleport",
		"details" : "Press F to teleport towards your cursor",
		"texture" : teleport_icon,
		"disabled" : false,
		"cost" : 700
	},
	
	"upgrade 3": {
		
		"displayname": "Blaster",
		"details" : "Adds a Blaster to your inventory",
		"texture" : turret_weapon_texture,
		"disabled" : false,
		"cost" : 100
		
	
	},
	
	"upgrade 4": {
		"displayname": "Mini Blaster",
		"details" : "Add a Mini Blaster weapon to your inventory",
		"texture" : test_weapon_texture,
		"disabled" : false,
		"cost" : 100
	},
	
	"upgrade 5": {
		"displayname": "Movement Speed Up",
		"details" : "Increase your movement speed by 1.5",
		"texture" : move_speed_texture,
		"disabled" : false,
		"cost" : 100
	},
	
	"upgrade 6": {
		"displayname": "Unlock Turret Mode",
		"details": "Hold SHIFT to go into Turret Mode",
		"texture" : turret_icon,
		"disabled" : false,
		"cost" : 200
	},
	
	"upgrade 7": {
		"displayname": "Thicc Blaster",
		"details": "Adds a Thicc Blaster to your inventory",
		"texture" : thicc_blaster_texture,
		"disabled" : false,
		"cost" : 200
	},
	
	"upgrade 8": {
		"displayname": "Energy Blaster",
		"details": "Adds an Energy Blaster to your inventory",
		"texture" : energy_blaster_texture,
		"disabled" : false,
		"cost" : 200
	},
	
	"upgrade 9": {
		"displayname": "Ray Blaster",
		"details": "Adds a Ray Blaster to your inventory",
		"texture" : raygun_texture,
		"disabled" : false,
		"cost" : 600
	},
	
	"upgrade 10": {
		"displayname": "Flame Blaster",
		"details": "Adds a Flame Blaster to your inventory",
		"texture" : FLAME_BLASTER,
		"disabled" : false,
		"cost" : 300
	},
	
	"upgrade 11": {
		"displayname": "Inverted Blaster",
		"details": "Adds an Inverted Blaster to your inventory",
		"texture" : INVERTED_BLASTER,
		"disabled" : false,
		"cost" : 400
	},
	
	"upgrade 12": {
		"displayname": "Inverted Heavy Blaster",
		"details": "Adds an Inverted Heavy Blaster to your inventory",
		"texture" : INVERTED_HEAVY,
		"disabled" : false,
		"cost" : 400
	},
	
	"upgrade 13": {
		"displayname": "Not A Blaster",
		"details": "Does not add a Blaster to your inventory",
		"texture" : NOT_A_BLASTER,
		"disabled" : false,
		"cost" : 200
	},
	
	"upgrade 14": {
		"displayname": "Rapid Blaster",
		"details": "Adds a Rapid Blaster to your inventory",
		"texture" : RAPID_BLASTER,
		"disabled" : false,
		"cost" : 200
	}
	
}
