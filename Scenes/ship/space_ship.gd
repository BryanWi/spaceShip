extends RigidBody3D

var acceleration = 5
var speed_limit = 10
var rotate_speed = -2

var dir:Vector3 = Vector3.ZERO
var vel:Vector3 = Vector3.ZERO
var damp:bool = true
var damp_toggle:bool = false
# Called when the node enters the scene tree for the first time.

#Input vars
var x_dir
var y_dir 
var z_dir

func _ready():
	gravity_scale = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(delta):
	#print(vel)
	get_inputs()
	vel += Vector3(acceleration*delta*x_dir*cos(rotation.y),0,acceleration*delta*x_dir*-sin(rotation.y))
	if (x_dir== 0) && (damp==true):
		vel = Vector3(lerpf(vel.x,0.0,0.02),lerpf(vel.y,0.0,0.02),lerpf(vel.z,0.0,0.02))
	if damp_toggle:
		damp = !damp
		pass
		
	#Falta el limite de velocidad del personaje quizá al normalizar un valor se pueda lograr
	# o con una funcion similar pero en vez de normalizar con el mismo valor actual, hacerlo con el máximo
	# y multiplicarlo por el maximo cuando se aplique
	#vel = clamp(vel, -speed_limit,speed_limit)
	
	rotation.y += delta*rotate_speed*z_dir
	
	var distance #= #vel * delta
	distance = vel*delta
	
	#revisar como rotar 
	print(rotation.y)
	#print(distance)
	move_and_collide(distance)

func get_inputs():
	x_dir = Input.get_axis("backward","forward")
	y_dir = Input.get_axis("down","up")
	z_dir = Input.get_axis("left","right")
	damp_toggle = Input.is_action_just_pressed("damp")
