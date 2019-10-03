extends KinematicBody2D

export(int) var life = 50
onready var raycastEnemy = $Right

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.connect("taked_turn",self,"_on_taked_turn")
	
func _on_taked_turn():
	raycastEnemy.force_raycast_update() #Es para tener antes los datos
	if not raycastEnemy.is_colliding():
		print("do something")
