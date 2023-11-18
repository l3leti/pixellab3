#BaseEnemiga.gd
class_name BaseEnemiga
extends Node2D

##Atributos export

export var hitpoints:float = 30.0
export var orbital:PackedScene = null
export var numero_orbitales:int = 10
export var intervalo_spawn:float = 0.8

#Atributos onready

onready var impacto_sfx:AudioStreamPlayer2D = $ImpactosSFX
onready var time_spawner:Timer = $TimerSpawnearEnemigos

##Atributos

var esta_destruida:bool = false
var posicion_spawn:Vector2 = Vector2.ZERO

##Metodos
func _ready()->void:
	time_spawner.wait_time = intervalo_spawn
	$AnimationPlayer.play(elegir_animacion_aleteoria())


func _process(delta:float)->void:
	var player_objetivo:Player = DatosJuego.get_player_actual()
	if not player_objetivo:
		return
	var dir_player:Vector2 = player_objetivo.global_position - global_position
	var angulo_player:float = rad2deg(dir_player.angle())
	print(angulo_player)

##Metodos Custom
func elegir_animacion_aleteoria()->String:
	randomize()
	var num_anim:int = $AnimationPlayer.get_animation_list().size() - 1
	var indice_anim_aleatoria:int = randi() % num_anim + 1
	var lista_animacion: Array = $AnimationPlayer.get_animation_list()
	return lista_animacion[indice_anim_aleatoria]

func recibir_danio(danio:float) -> void:
	hitpoints -= danio
	if hitpoints <= 0 and not esta_destruida:
		esta_destruida = true
		destuir()
	impacto_sfx.play()

func destuir() -> void :
	var posicion_partes = [
		$Sprites/Sprite2.global_position,
		$Sprites/Sprite3.global_position,
		$Sprites/Sprite4.global_position,
		$Sprites/Sprite1.global_position
	]
	Eventos.emit_signal("base_destruida", self ,posicion_partes)
	queue_free()

func spawnear_orbital()->void:
	numero_orbitales -= 1
	$PosicionesSpanw/RutaEnemigo.global_position = global_position
	var pos_spawn:Vector2 = deteccion_cuadrante()
	$PosicionesSpanw/RutaEnemigo.global_position = global_position
	var new_orbital:EnemigoOrbital = orbital.instance()
	new_orbital.crear(global_position + pos_spawn, self, $PosicionesSpanw/RutaEnemigo)
	Eventos.emit_signal("spawn_orbital", new_orbital)

func deteccion_cuadrante() -> Vector2:
	var player_objetivo:Player = DatosJuego.get_player_actual()
	
	if not player_objetivo:
		return Vector2.ZERO
	
	var dir_player:Vector2 = player_objetivo.global_position - global_position
	var angulo_player:float = rad2deg(dir_player.angle())

	if abs(angulo_player) <= 45.0:
		$PosicionesSpanw/RutaEnemigo.rotation_degrees = 180.0
		return $PosicionesSpawns/Este.position
	elif abs(angulo_player) > 135.0 and abs(angulo_player) <= 180.0:
		$PosicionesSpanw/RutaEnemigo.rotation_degrees = 0.0
		return $PosicionesSpawns/Oeste.position
	elif abs(angulo_player) > 45.0 and abs(angulo_player) <= 135.0:
		if sign(angulo_player) > 0:
			$PosicionesSpanw/RutaEnemigo.rotation_degrees = 270.0
			return $PosicionesSpawns/Sur.position
		else:
			$PosicionesSpanw/RutaEnemigo.rotation_degrees = 90.0
			return $PosicionesSpawns/Norte.position
	return $PosicionesSpawns/Norte.position


##Señales Internas

func _on_AreaColision_body_entered(body:Node)-> void:
	if body.has_method("destruir"):
		body.destruir()


func _on_VisibilityNotifier2D_screen_entered():
	$VisibilityNotifier2D.queue_free()
	spawnear_orbital()
	time_spawner.start()


func _on_TimerSpawnearEnemigos_timeout()-> void:
	if numero_orbitales == 0:
		time_spawner.stop()
		return
	spawnear_orbital()

