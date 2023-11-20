#ContenedorInformacion
class_name ContenedorInformcaion
extends NinePatchRect

##Atributos Onready
onready var texto_contenedor:Label = $Label
onready var auto_ocultar_timer:Timer = $AutoOcultarTimer
onready var animaciones:AnimationPlayer = $AnimationPlayer

##Atributos Export
export var auto_ocultar:bool = false

##Metodos 
func mostrar()->void:
	$AnimationPlayer.play("mostrar")

func ocultar()-> void:
	$AnimationPlayer.play("ocultar")

func mostrar_suavizado()-> void:
	$AnimationPlayer.play("mostrar_suavizado")
	if auto_ocultar:
		auto_ocultar_timer.start()

func ocultar_suavizado()-> void:
	$AnimationPlayer.play("ocultar_suavizado")

func modificar_texto(text:String)->void:
	texto_contenedor.text = text

##Señales Internas

func _on_AutoOcultarTimer_timeout()->void:
	ocultar_suavizado()
