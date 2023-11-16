#MeteoritoSpawner.gd
class_name MeteoritoSpawner
extends Position2D

## atriburos export
export var direccion:Vector2 = Vector2(1, 1)
export var rango_tamanio_meteorito: Vector2 = Vector2(0.5, 2.2)

##Metodos
func spawnear_meteoritos() -> void:
	Eventos.emit_signal(
		"spawn_meteoritos",
		 global_position,
		 direccion,
		tamanio_meteorito_aleatorio()
		)

func tamanio_meteorito_aleatorio() -> float:
	randomize()
	return rand_range(rango_tamanio_meteorito[0], rango_tamanio_meteorito[1])

##Señales Internas
