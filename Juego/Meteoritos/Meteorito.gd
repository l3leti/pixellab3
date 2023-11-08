#Meteorito.gd
class_name Meteorito
extends RigidBody2D


## Atributos Export
export var vel_lineal_base:Vector2 = Vector2(300.0, 300.0)
export var vel_ang_base:float = 3.0

## Metodos 
func _ready() -> void:
	linear_velocity = vel_lineal_base
	angular_velocity = vel_ang_base

