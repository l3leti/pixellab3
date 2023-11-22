#MusicaJuego.gd
extends Node

##Atributos onready

onready var musica_nivel:AudioStreamPlayer = $MusicaNivel
onready var musica_combate:AudioStreamPlayer = $MusicaCombate
onready var tween_on:Tween = $TweenMusicaOn
onready var tween_off:Tween = $TweenMusicaOff

##Metodos Custom
func set_streams(stream_musica: AudioStream, stream_combate:AudioStream)->void:
	musica_nivel.stream = stream_musica
	musica_combate.stream = stream_combate

func play_musica_nivel()-> void:
	stop_todo()
	musica_nivel.play()

func stop_todo()->void:
	for nodo in get_children():
		if nodo is AudioStreamPlayer:
			nodo.stop()
