# Proyectil.gd
class_name Proyectil
extends Area2D

## Atributos
var velocidad: Vector2 = Vector2.ZERO
<<<<<<< Updated upstream
var danio:float = 1.0
=======
var danio:float = 5.0

>>>>>>> Stashed changes
## Metodos
func _physics_process(delta: float) -> void:
	position += velocidad * delta

##Metodos Custom
func daniar(otro_cuerpo: CollisionObject2D) -> void:
	if otro_cuerpo.has_method("recibir_danio"):
<<<<<<< Updated upstream
		otro_cuerpo.recibir_danio()
=======
		otro_cuerpo.recibir_danio(danio)
>>>>>>> Stashed changes
	queue_free()

# Constructor
func crear(pos: Vector2, dir: float, vel: float, _danio_p: int) -> void:
	position = pos
	rotation = dir
	velocidad = Vector2(vel, 0).rotated(dir)

##Señales internas
  
func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:
	daniar(body)

<<<<<<< Updated upstream

func _on_body_entered(body: Node) -> void:
	daniar(body)

=======
>>>>>>> Stashed changes
func _on_area_entered(area: Area2D) -> void:
	if area.has_method("recibir_danio"):
		area.recibir_danio(danio)
	queue_free()
