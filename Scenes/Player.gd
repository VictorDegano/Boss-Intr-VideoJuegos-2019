extends KinematicBody2D

var moved = false # Es solo para poner un "delay" entre accion y accion
export(int) var tile_size = 16
export(int) var life = 100

onready var rayCastUp = $RayCastNode/Up
onready var rayCastDown = $RayCastNode/Down
onready var rayCastLeft = $RayCastNode/Left
onready var rayCastRight = $RayCastNode/Right
onready var movementTimer = $MovementTimer

func _ready():
	pass

func _input(event):
	checkAndMove(event,"ui_up",rayCastUp,Vector2.UP)
	checkAndMove(event,"ui_down",rayCastDown,Vector2.DOWN)
	checkAndMove(event,"ui_left",rayCastLeft,Vector2.LEFT)
	checkAndMove(event,"ui_right",rayCastRight,Vector2.RIGHT)


# Es una funcion generica para chequear el movimiento
# si no colisiona cuando se va a mover
# se mueve, sino no realiza la accion
func checkAndMove(event,action:String,raycast:RayCast2D,directionToMove:Vector2):
	if event.is_action(action):
		raycast.force_raycast_update() #Es para tener antes los datos
		if not raycast.is_colliding() and not moved:
			moved = true
			movementTimer.start()
			position += directionToMove * tile_size
			EventBus.emit_signal("taked_turn")

func _on_MovementTimer_timeout():
	moved = false
