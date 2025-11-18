extends Control

#region Global Variables

var temp_blood_bags : int
var temp_brains : int
var temp_current_money : int
var temp_eyeballs : int
var temp_spaghetti : int
var temp_toasts : int

#endregion

#region Global UI Elements Variables

@onready var ui_night_stats = $night_stats
@onready var ui_shop = $shop
@onready var ui_menu = $menu

#endregion

#region Night Stats UI Elements Variables

@onready var ui_night_indicator = $night_stats/night_indicator
@onready var ui_earned_from_plates = $night_stats/earned_from_plates
@onready var ui_nightly_fee = $night_stats/nightly_fee
@onready var ui_tips = $night_stats/tips
@onready var ui_clients = $night_stats/clients
@onready var ui_served_dishes = $night_stats/served_dishes
@onready var ui_new_balance = $night_stats/new_balance
@onready var ui_old_balance = $night_stats/old_balance

#endregion

#region Night Stats Variables

var nightly_fee : int = 10

#endregion

#region Shop Ingredient Variables


@export var shop_brain : Resource
@export var shop_spaghetti : Resource
@export var shop_bread : Resource
@export var shop_eyeball : Resource

#endregion

#region Nightly Menu Ready

func _ready():
	get_inventory()
	set_tab_visibility()
	load_night_stats()
	pass

func get_inventory():
	temp_blood_bags = InventoryManager.blood_bags
	temp_brains = InventoryManager.brains
	temp_current_money = InventoryManager.current_money
	temp_eyeballs = InventoryManager.eyeballs
	temp_spaghetti = InventoryManager.spaghetti
	temp_toasts = InventoryManager.toasts

func set_tab_visibility():
	ui_night_stats.visible = true
	ui_shop.visible = false
	ui_menu.visible = false

#endregion

#region Night Stats

func load_night_stats():
	ui_old_balance.text = str(temp_current_money)
	ui_nightly_fee.text = ("-" + str(nightly_fee))
	ui_earned_from_plates.text = ("+" + str(InventoryManager.earned_from_plates))
	ui_tips.text = ("+" + str(InventoryManager.tips))
	temp_current_money = temp_current_money - nightly_fee + InventoryManager.earned_from_plates + InventoryManager.tips
	ui_new_balance.text = str(temp_current_money)
	ui_clients.text = ("Clients: " + str(InventoryManager.clients))
	ui_served_dishes.text = ("Served Dishes: " + str(InventoryManager.served_dishes))

func _on_button_pressed() -> void:
	ui_night_stats.visible = false
	ui_shop.visible = true

#endregion
