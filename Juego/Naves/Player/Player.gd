class_name Player
extends NaveBase

## Atributos export

export var potencia_motor:int = 18
export var potencia_rotacion:int = 260
export var estela_maxima:int = 150

##Atributos 
var empuje:Vector2 = Vector2 .ZERO
var dir_rotacion:int = 0


##Atributos onready
onready var escudo:Escudo = $Escudo setget , get_escudo 
onready var laser: RayoLaser = $LaserBeam2D setget ,get_laser
onready var estela:Estela = $EstelaPuntoInicio/Trail2D
onready var motor_sfx:Motor = $MotorSFX

## SEtters y Getters
func get_laser() -> RayoLaser:
	return laser

func get_escudo() -> Escudo:
	return escudo

##Metodos 
func _unhandled_input(event: InputEvent) -> void:
	if not esta_input_activo():
		return
	#Disparo Rayo
	if event.is_action_pressed("disparo_secundario"):
		laser.set_is_casting(true)
	if event.is_action_released("disparo_secundario"):
		laser.set_is_casting(false)
	# Control Estela y sonido motor
	if event.is_action_pressed("mover_adelante"):
		estela.set_max_points(estela_maxima)
		motor_sfx.sonido_on()
	elif event.is_action_pressed("mover_atras"):
		estela.set_max_points(0)
		motor_sfx.sonido_on()
	if (event.is_action_released("mover_adelante") or event.is_action_released("mover_atras")):
		motor_sfx.sonido_off() 
	#control Escudo
	if event.is_action_pressed("escudo") and not escudo.get_esta_activado():
		escudo.activar()

func _integrate_forces(_state: Physics2DDirectBodyState): 
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(dir_rotacion * potencia_rotacion)

func _process(_delta: float): #-> void"# :
	player_input()

func _ready():
	DatosJuego.set_player_actual(self)

## Metodos Custom
func player_input()-> void:
	if not esta_input_activo():
		return
	#Empuje
	empuje = Vector2.ZERO
	if Input.is_action_pressed("mover_adelante"):
		empuje = Vector2(potencia_motor, 0)
	elif Input.is_action_pressed("mover_atras"):
		empuje = Vector2(-potencia_motor, 0)
	# Rotacion
	dir_rotacion = 0
	if Input.is_action_pressed("rotar_antihorario"):
		dir_rotacion -= 1
	elif Input.is_action_pressed("rotar_horario"):
		dir_rotacion += 1
	#Disparo
	if Input.is_action_pressed("disparo_principal"):
		canion.set_esta_disparando(true)
	if Input.is_action_just_released("disparo_principal"):
		canion.set_esta_disparando(false)

func esta_input_activo() -> bool:
	if estado_actual in [ESTADO.MUERTO, ESTADO.SPAWN]:
		return false
	return true

func desactivar_controles()->void:
	controlador_estados(ESTADO.SPAWN)
	empuje = Vector2.ZERO
	motor_sfx.sonido_off()
	laser.set_is_casting(false)
