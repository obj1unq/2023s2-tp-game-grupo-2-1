import wollok.game.*

object harry {

method position() = game.center()

	method image() = "harry.png"
	
	method tomarPocion(pocion){
		
	} 
	
	method puedeOcupar(posicion) {
		return tablero.pertenece(posicion)
	}
	
	method sePuedeMover(direccion) {
	const proxima = direccion.siguiente(self.position())
	return self.puedeOcupar(proxima) and self.estado().puedeMover()
	}
	
	method validarMover(direccion) {
		if(not self.sePuedeMover(direccion)) {
			self.error("No puedo pasar por ahí")
		} 
	}
	
	method mover(direccion) {
		self.validarMover(direccion)
		const proxima = direccion.siguiente(self.position())		
		self.mover(1)
		self.position(proxima)		
	}

}

object caminando {
	method puedeMover() {
		
	}

}

object sirius {
	
	method position() = game.center()

	method image() = "harry.png"
}
