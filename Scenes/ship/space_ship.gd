extends RigidBody3D

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
var x_mouse = 0

func _ready():
	gravity_scale = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		x_mouse = event.relative.x
		
		#rotation.x += event.relative.x*roll_speed*0.001
		#rotate_x(event.relative.x*roll_speed*0.001)
		var a = event.relative.x*roll_speed*0.001
		print(a)
		rotate(basis.x,a)
		#character.rotation.y -= event.relative.x * MOUSE_SENS * 0.001
		#character.rotation.y = wrapf(character.rotation.y, 0.0, TAU)

func _physics_process(delta):
	get_inputs()
	
	
	vel += basis.x*acceleration*delta*x_dir
	if (x_dir== 0) && (damp==true):
		vel = Vector3(lerpf(vel.x,0.0,0.02),lerpf(vel.y,0.0,0.02),lerpf(vel.z,0.0,0.02))
	if damp_toggle:
		damp = !damp
	
	#Falta el limite de velocidad del personaje quizá al normalizar un valor se pueda lograr
	# o con una funcion similar pero en vez de normalizar con el mismo valor actual, hacerlo con el máximo
	# y multiplicarlo por el maximo cuando se aplique
	#vel = clamp(vel, -speed_limit,speed_limit)
	
	#rotation.y += delta*rotate_speed*z_dir
	rotate(basis.y, delta*rotate_speed*z_dir)
	
	var distance #= #vel * delta
	distance = vel*delta
	
	#revisar como rotar 
	#print(rotation.y)
	#print(distance)
	move_and_collide(distance)

func get_inputs():
	x_dir = Input.get_axis("backward","forward")
	y_dir = Input.get_axis("down","up")
	z_dir = Input.get_axis("left","right")
	damp_toggle = Input.is_action_just_pressed("damp")
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
