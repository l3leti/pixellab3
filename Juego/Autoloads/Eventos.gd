#Eventos.gd
extends Node

# warning-ignore:unused_signal
signal disparo(proyectil) 
# warning-ignore:unused_signal
signal nave_destruida(posicion, explosiones)
signal spawn_meteoritos(posicion, direccion, tamanio)
signal meteorito_destruido(posicion)
signal nave_en_sector_peligro(centro_camara, yipo_peligro, num_peligros)
