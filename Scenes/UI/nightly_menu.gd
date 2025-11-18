extends Control

#region Global Variables
var current_money : int
var toasts : int
var eyeballs : int
var brains : int
var spaghetti : int
var blood_bags : int
#endregion

#region Nightly Stats Tab References
@onready var ui_night_indicator = $night_stats/night_indicator
@onready var ui_profit = $night_stats/profit
@onready var ui_expenses = $night_stats/expenses
@onready var ui_tips = $night_stats/tips
@onready var ui_clients = $night_stats/clients
@onready var ui_served_dishes = $night_stats/served_dishes
#endregion

#region Nightly Stats Variables
var profit : int
var expenses : int
var tips : int
var clients : int
var served_dishes : int
#endregion
