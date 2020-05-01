extends Node

var gol_ai = 0
var gol_player = 0

func _ready():
	$CanvasLayer/GUI/Player_Placar.text = str(gol_player)
	$CanvasLayer/GUI/AI_Placar.text = str(gol_ai)
	pass

func _on_Area2D_area_entered(area):
	if area.name == "Gol2":
		gol_ai += 1
		$CanvasLayer/GUI/AI_Placar.text = str(gol_ai)
	else:
		gol_player += 1
		$CanvasLayer/GUI/Player_Placar.text = str(gol_player)
	$Linhas.hide()
	reiniciar()
	pass

func reiniciar():
	$Astar.reiniciar()
	$Linhas.lista_pontos.clear()
	$Linhas.desenhar(Vector2(168,312))
	$Bola.position = Vector2(168,312)
	$Turno.get_node("Player").reiniciar(Vector2(168,312))
	pass
