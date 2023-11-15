import wollok.game.*
import direcciones.*
import personajes.*

class Guardia {

	var property position = game.at(2, 3)
	var ladoAMover = derecha

	method image() {
		return "guardia." + ladoAMover.toString() + ".png"
	}

//	method moverse(){
//		game.onTick(1000, "CaminataGuardias" + self , {self.caminar()})
//	}
	method caminar() {
		const proxima = ladoAMover.siguiente(position)
		if (not self.puedeMover(proxima)) {
			self.cambiarLado()
		} else {
			position = proxima
		}
	}

	method cambiarLado() {
		// position.x() == game.width() -1 or position.x() == 0 or 
		ladoAMover = ladoAMover.opuesto()
	}

	method puedeMover(posicion) {
		return tablero.puedeOcupar(posicion, self)
	}
	
	method esSolidoPara(personaje) {
		return false
	}

	method colisionarCon(personaje) {
		game.say(self, "te atrapé!")
		personaje.volverAlPrincipio()
	}

}

class GuardiaPerseguidor inherits Guardia {

	const personajes = #{ harry, sirius }
	const property posicionDeCustodia

	method perseguir() {
		const intrusoCercano = self.intrusoMasCercano()
		if (self.puedePerseguir(intrusoCercano)) {
			self.irHacia(intrusoCercano.position())
		} else {
			self.volverPosicionCustodia()
		}
	}

	method irHacia(destino) {
		self.posicionarseEncima(destino)
		self.siguienteMovimiento(destino)
	}

	method volverPosicionCustodia() {
		if (self.position() != self.posicionDeCustodia()) {
			self.irHacia(self.posicionDeCustodia())
		}
	}

	method puedePerseguir(intrusoCercano) {
		return self.puedoVerlo(intrusoCercano)
	}

	method posicionarseEncima(destino) {
		if (self.estaAlLado(destino)) {
			position = game.at(destino.x(), destino.y())
		}
	}

	
	method siguienteMovimiento(destino) {
		 if (self.puedeMover(destino)){
				position = game.at(self.position().x() + (destino.x() - self.position().x()).div(2), 
				self.position().y() + (destino.y() - self.position().y()).div(2))
		}else{
			self.cambiarLado()	
		}
		
	}
	
	
	override method esSolidoPara(personaje){
		return personaje.puedePisarGuardia() 
	}
	
	method puedePisarGuardia(){
		return false 
	}

	method intrusoMasCercano() {
		return personajes.min({ personaje => self.distanciaMenorEntre(personaje) })
	}

	method estaAlLado(destino) {
		return 1 >= (self.position().x() - destino.x()).abs() and 1 >= (self.position().y() - destino.y()).abs()
	}

	method puedoVerlo(personaje) {
		return personaje.esPerseguible()
			   and self.verAInfiltrado() >= self.position().x() - personaje.position().x() 
			   and self.verAInfiltrado() >= self.position().y() - personaje.position().y()
	}

	method verAInfiltrado() {
		return 5
	}

	method distanciaMenorEntre(personaje) {
		return self.position().x() - personaje.position().x().min(self.position().y() - personaje.position().y())
	}

	override method colisionarCon(personaje) {
		game.say(self, "te atrapé!")
		personaje.volverAlPrincipio()
		self.volverPosicionCustodia()
	}

}

object listaGuardias {

	const property guardias = #{}

	method agregarGuardia(guardia) {
		guardias.add(guardia)
	}

	method caminar() {
		guardias.forEach({ guardia => guardia.caminar()})
	}

}

class CaminoInvalido {

	const property position
	const posicionEntrada = tunel.position()

//	method image(){
//		return "nada.png"
//	}
	method colisionarCon(personaje) {
		personaje.position(self.arribaDeLaEntrada())
	}

	method arribaDeLaEntrada() {
		return arriba.siguiente(posicionEntrada)
	}

	method esSolidoPara(personaje) {
		return false
	}

}

object tunel {

	var property position = game.at(0, 0)

	method image() {
		return "tunel.png"
	}

	method esSolidoPara(personaje) {
		return not personaje.puedePasar(self)
	}

	method colisionarCon(personaje) {
	}

}

class Pared {

	const property position

//	method image(){
//		return "pared.png"
//	}
	method esSolidoPara(personaje) {
		return true
	}

	method colisionarCon(personaje) {
	}

}

class ZonaDeGuardias {

	const property position

	method colisionarCon(personaje) {
		personaje.entrarEnZonaGuardias()
	}

	method esSolidoPara(personaje) {
		return false
	}

}

