#Escudo.gd
class_name Escudo
extends Area2D

## Variables
var esta_activado:bool = false 

## Variables Export
export var energia:float = 8.0
export var radio_desgaste:float = 1.6

##Setters y Getters
func get_esta_activado() -> bool:
	return esta_activado

##Metodos
func _ready() -> void:
	set_process(false)
	controlar_collisionador(true)

func _process(delta: float) -> void:
	energia += radio_desgaste * delta
	if energia <= 0.0:
		desactivar()

##Metodos Custom
func controlar_collisionador(esta_descativado: bool) -> void:
	$CollisionShape2D.set_deferred("diasbled", esta_descativado)

func desactivar() -> void:
	set_process(false)
	esta_activado = false
	controlar_collisionador(true)
	$AnimationPlayer.play_backwards("activando")

func activar() -> void:
	if energia <= 0.0:
		return
	esta_activado = true
	controlar_collisionador(false)
	$AnimationPlayer.play("activando")

## Señales Internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "activando" and esta_activado:
		$AnimationPlayer.play("activado")
		set_process(true)

func _on_body_entered(body: Node) -> void:
	body.queue_free()

func _on_area_entered(area: Node) -> void:
	queue_free()
