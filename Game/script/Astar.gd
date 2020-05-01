extends Node

onready var astar = AStar.new()

onready var Campo = get_node("../Campo")
onready var tamanho_tabuleiro = Campo.tamanho_tabuleiro_map

var ponto_lista = []

func _ready():
	adicionar_pontos()
	remover_pontos()
	conectar_pontos(ponto_lista)
	#printar_ponto_lista()
	pass

func adicionar_pontos():
	for y in range(tamanho_tabuleiro.y):
		for x in range(tamanho_tabuleiro.x):
			var ponto = Vector2(x, y)
			ponto_lista.append(ponto)
			var ponto_index = calcular_ponto_index(ponto)
			astar.add_point(ponto_index, Vector3(ponto.x, ponto.y, 0.0))
	pass

func calcular_ponto_index(ponto):
	return ponto.x + tamanho_tabuleiro.x * ponto.y


func conectar_pontos(lista_pontos):
	for ponto in lista_pontos:
		var ponto_index = calcular_ponto_index(ponto)
		var pontos_relativos
		if ponto.x == 0: 
			pontos_relativos = PoolVector2Array([
				Vector2(ponto.x+1, ponto.y+1),
				Vector2(ponto.x+1, ponto.y),
				Vector2(ponto.x+1, ponto.y-1),
				Vector2(ponto.x, ponto.y-1),
				Vector2(ponto.x, ponto.y+1)])
		else:
			if ponto.x == 6:
					pontos_relativos = PoolVector2Array([
					Vector2(ponto.x-1, ponto.y+1),
					Vector2(ponto.x-1, ponto.y),
					Vector2(ponto.x-1, ponto.y-1),
					Vector2(ponto.x, ponto.y-1),
					Vector2(ponto.x, ponto.y+1)])
			else:
				pontos_relativos = PoolVector2Array([
					Vector2(ponto.x+1, ponto.y+1),
					Vector2(ponto.x+1, ponto.y),
					Vector2(ponto.x+1, ponto.y-1),
					Vector2(ponto.x-1, ponto.y+1),#0
					Vector2(ponto.x-1, ponto.y),
					Vector2(ponto.x-1, ponto.y-1),
					Vector2(ponto.x, ponto.y+1),
					Vector2(ponto.x, ponto.y-1)])
		#printt(calcular_ponto_index(ponto),ponto, pontos_relativos)
		for ponto_relativo in pontos_relativos:
			var ponto_relativo_index = calcular_ponto_index(ponto_relativo)
			#print(ponto_relativo_index)
			astar.connect_points(ponto_index, ponto_relativo_index, false)
	pass

func remover_pontos():
	for y in range(tamanho_tabuleiro.y):
		for x in range(tamanho_tabuleiro.x):
			if Campo.get_cell(x,y) == -1:
				var ponto = calcular_ponto_index(Vector2(x,y))
				#printt(ponto, Vector2(x,y), Campo.get_cell(x,y))
				astar.remove_point(ponto)
	pass

func printar_ponto_lista():
	for x in range(0,91):
		printt(x,astar.get_point_connections(x))
	pass

func desconectar_pontos(vizinhos,click):
	var pt_vizinhos = calcular_ponto_index(vizinhos)
	var pt_click = calcular_ponto_index(click)
	astar.disconnect_points(pt_vizinhos, pt_click)
	#printar_ponto_lista()
	pass

func verificar_ponto(vizinhos,click):
	var pt_vizinhos = calcular_ponto_index(vizinhos)
	var pt_click = calcular_ponto_index(click)
	var resultado = astar.are_points_connected(pt_vizinhos,pt_click)
	return resultado
	pass

func caminhos_ai(bola):
	var id_bola = calcular_ponto_index(bola)
	var lista = astar.get_point_path(id_bola,87)
	if lista.size() == 0:
		return Vector2(0,0)
	else:
		var nova_bola = Campo.map_to_world(Vector2(lista[1].x, lista[1].y)) + Campo.tile_deslocamento
		return nova_bola
	pass

func vizinhos(valor):
	var valor_index = calcular_ponto_index(valor)
	var vizinhos = astar.get_point_connections(valor_index)
	if vizinhos.size() == 0:
		return false
	else:
		return true
	pass

func reiniciar():
	astar.clear()
	ponto_lista.clear()
	adicionar_pontos()
	remover_pontos()
	conectar_pontos(ponto_lista)
	pass