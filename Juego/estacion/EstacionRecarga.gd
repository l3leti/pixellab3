#EstacionRecarga.gd
class_name EstacionRecarga
extends Node2D

## Atributos export

export var energia:float = 6.0
export var radio_energia_entregada:float= 0.005

##Atributos

var nave_player:Player = null
var player_en_zona:bool = false

##Metodos

func _unhandled_input(event: InputEvent) -> void:
	if not puede_recargar(event):
		return
	
	energia -= radio_energia_entregada
	print ("Escudo Estacion; ", energia)
	
	if event.is_action("recarga_escudo"):
		nave_player.get_escudo().controlar_energia(radio_energia_entregada)
	elif event.is_action("recarga_laser"):
		nave_player.get_laser().controlar_energia(radio_energia_entregada)
 
## Metodos Custom
func puede_recargar(event:InputEvent) ->bool:
	var hay_input = event.is_action("recarga_escudo") or event.is_action("recarga_laser")
	if hay_input and player_en_zona and energia > 0.0:
		return true
	return false

# Señales Internas

func _on_AreaColision_body_entered(body: Node) ->void:
	if body.has_method("destruir"):
		body.destruir()

func _on_AreaRecarga_body_entered(body:Node)-> void:
	if body is Player:
		nave_player= body

func _on_AreaRecarga_body_exited(body:Node)-> void:
	body.set_gravity_scale(0.0)
