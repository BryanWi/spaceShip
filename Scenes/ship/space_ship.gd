#extends RigidBody3D
extends CharacterBody3D

var acceleration = 5
var speed_limit = 10
var rotate_speed = -2
var roll_speed = 3

var dir:Vector3 = Vector3.ZERO
var vel:Vector3 = Vector3.ZERO
var damp:bool = true
var damp_toggle:bool = false
# Called when the node enters the scene tree for the first time.

#Input vars
var x_dir
var y_dir 
var z_dir
var roll_dir = 0
var x_mouse = 0
var y_mouse = 0

func _ready():
	#gravity_scale = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		x_mouse = event.relative.x
		y_mouse = event.relative.y

func _physics_process(delta):
	get_inputs()
	
	
	vel += basis.x*acceleration*delta*x_dir
	vel += basis.y*acceleration*delta*y_dir
	vel += basis.z*acceleration*delta*z_dir
	if (x_dir== 0) &&(y_dir== 0)&&(z_dir== 0) && (damp==true):
		vel = Vector3(lerpf(vel.x,0.0,0.02),lerpf(vel.y,0.0,0.02),lerpf(vel.z,0.0,0.02))
	if damp_toggle:
		damp = !damp
	
	#Falta el limite de velocidad del personaje quizá al normalizar un valor se pueda lograr
	# o con una funcion similar pero en vez de normalizar con el mismo valor actual, hacerlo con el máximo
	# y multiplicarlo por el maximo cuando se aplique
	#vel = clamp(vel, -speed_limit,speed_limit)
	
	#rotation.y += delta*rotate_speed*z_dir
	rotate(basis.x.normalized(), delta*rotate_speed*-roll_dir)
	
	rotate(basis.y.normalized(),-x_mouse * roll_speed*0.001*0.5)
	rotate(basis.z.normalized(),-y_mouse * roll_speed*0.001)
	x_mouse = 0
	y_mouse = 0
	
	
	var distance = vel*delta
	move_and_collide(distance)

func get_inputs():
	x_dir = Input.get_axis("backward","forward")
	y_dir = Input.get_axis("down","up")
	z_dir = Input.get_axis("left","right")
	roll_dir = Input.get_axis("q","e")
	damp_toggle = Input.is_action_just_pressed("damp")
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("left_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_grid_map_cell_size_changed(cell_size):
	pass # Replace with function body.
