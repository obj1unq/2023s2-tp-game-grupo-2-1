import wollok.game.*

object derecha {

	method siguiente(position) {
		return position.right(1)
	}
	
	method opuesto(){
		return izquierda
	}
 
}

object izquierda {

	method siguiente(position) {
		return position.left(1)
	}
	
	method opuesto(){
		return derecha
	}

}

object arriba {

	method siguiente(position) {
		return position.up(1)
	}
	
	method opuesto(){
		return abajo
	}

}

object abajo {

	method siguiente(position) {
		return position.down(1)
	}
	
	method opuesto(){
		return arriba
	}

}

object tablero {

	method pertenece(position) {
		return position.x().between(0, game.width() - 1) and position.y().between(0, game.height() - 1)
	}
	
	method puedeOcupar(posicion, personaje){
		return self.pertenece(posicion) and not self.haySolido(posicion, personaje)
	}
	
	method haySolido(position, personaje){
		return game.getObjectsIn(position).any({objeto => objeto.esSolidoPara(personaje)})
	}
	

}



