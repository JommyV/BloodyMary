extends HBoxContainer

var item_name : String
var item_quantity : int = 1
var item_price : int = 0
var base_price : int = 0
@onready var base_item_name: Label = $base_item_name
@onready var base_item_quantity: Label = $base_item_quantity
@onready var base_item_price: Label = $base_item_price

func define_item(received: String, price: int):
	item_name = received
	base_price = price
	item_price = price
	base_item_name.text = item_name
	base_item_price.text = str(item_price)

func check_item():
	return item_name

func plus_one():
	item_quantity += 1
	base_item_quantity.text = str(item_quantity)
	calculate_price()

func minus_one():
	item_quantity -= 1
	base_item_quantity.text = str(item_quantity)
	calculate_price()

func empty():
	if item_quantity == 0:
		return true

func calculate_price():
	item_price = base_price * item_quantity
	base_item_price.text = str(item_price)
