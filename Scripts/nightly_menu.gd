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

#region Shop UI Elements Variables

@onready var shopping_cart_box: VBoxContainer = $shop/shopping_cart/shopping_cart_box
@onready var base_cart_item = preload("res://Scenes/UI/base_cart_item.tscn")
@onready var balance: Label = $shop/shopping_catalogue/balance
@onready var total: Label = $shop/shopping_catalogue/total

#endregion

#region Shop System Variables

var cart : Array

#endregion

#region Nightly Menu Ready

func _ready():
	get_inventory()
	set_tab_visibility()
	load_night_stats()
	load_shop_stats()
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

func _on_stats_next_pressed() -> void:
	ui_night_stats.visible = false
	ui_shop.visible = true

#endregion

#region Shop

func load_shop_stats():
	balance.text = ("Balance: " + str(temp_current_money))

func add_item(item, price):
	var new_child = base_cart_item.instantiate()
	new_child.add_to_group(item)
	shopping_cart_box.add_child(new_child)
	new_child.define_item(item, price)
	cart.append(new_child.item_name)
	total_update()

func look_for_item(item):
	if cart.has(item):
		return true
	else:
		return false

func update_child(item, add_or_remove):
	for child in shopping_cart_box.get_children():
		if child.is_in_group(item):
			if add_or_remove:
				child.plus_one()
			else:
				child.minus_one()
				if child.empty():
					cart.erase(item)
					child.queue_free()
	total_update()

#region Shop Buttons

func _on_bread_plus_pressed() -> void:
	plus_pressed("5 Bread Slices", 2)

func _on_bread_minus_pressed() -> void:
	update_child("5 Bread Slices", false)


func _on_eyeball_plus_pressed() -> void:
	plus_pressed("2 Eyeball Pack", 3)

func _on_eyeball_minus_pressed() -> void:
	update_child("2 Eyeball Pack", false)


func _on_brain_plus_pressed() -> void:
	plus_pressed("1 Brain", 5)

func _on_brain_minus_pressed() -> void:
	update_child("1 Brain", false)


func _on_spaghetti_plus_pressed() -> void:
	plus_pressed("1 Spaghetti Pack", 2)

func _on_spaghetti_minus_pressed() -> void:
	update_child("1 Spaghetti Pack", false)


func plus_pressed(item, price):
	if look_for_item(item):
		update_child(item, true)
	else:
		add_item(item, price)

#endregion

func total_update():
	var total_price : int
	for child in shopping_cart_box.get_children():
		total_price = total_price + child.item_price
	total.text = ("Total: " + str(total_price))

func _on_purchase_pressed() -> void:
	for child in shopping_cart_box.get_children():
		temp_current_money = temp_current_money - child.item_price
		if child.item_name == "5 Bread Slices":
			temp_brains = child.item_quantity
		elif child.item_name == "2 Eyeball Pack":
			temp_eyeballs = child.item_quantity
		elif child.item_name == "1 Brain":
			temp_brains = child.item_quantity
		elif child.item_name == "1 Spaghetti Pack":
			temp_spaghetti = child.item_quantity

#endregion


func _on_nextday_pressed() -> void:
	
	get_tree().change_scene_to_file("res://Scenes/main_world.tscn")
	
