extends Node

var player

func _ready():
	proximo_turno(0)
	pass

func proximo_turno(valor):
	var player = get_child(valor)
	player.iniciar_turno()
	pass