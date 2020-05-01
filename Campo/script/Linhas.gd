extends Node2D

onready var inicio = get_node("/root/Game/Campo").posicao_inicial
var lista_pontos = []
 
func _ready():
	lista_pontos.append(inicio)
	hide()
	pass

func desenhar(click):
	show()
	lista_pontos.append(click)
	update()
	pass

func _draw():
	for x in range(0,lista_pontos.size()-1):
		draw_line(lista_pontos[x],lista_pontos[x+1],Color("ffffff"),5.0)
	pass