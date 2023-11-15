import wollok.game.*
import direcciones.*
import personajes.*
import nivelx.*

class Guardia {

	var property position = game.at(2, 3)
	var ladoAMover = derecha
	var property estado = guardiaHabitual


	method image() {

		return "guardia." + ladoAMover.toString() + ".png"
	}

	method perseguir(){
		const proxima = ladoAMover.siguiente(position)
		if (not self.puedeMover(proxima)) {
			self.cambiarLado()
		} else {
			position = proxima
		}
	}
method puedePisarGuardia(){
		return false 
	}

	method cambiarLado(){

		ladoAMover = ladoAMover.opuesto()
	}

	
	method puedeMover(posicion){
		return estado.puedeMover(posicion)
	}
	
	method esSolidoPara(personaje) {
		return false
	}

	method colisionarCon(personaje) {
		game.say(self, "te atrapé!")
		personaje.serAtrapado()
	}

	method estatico(){
		estado = guardiaEstatico
		game.schedule(5000, {estado = guardiaHabitual})
	}

	
}

object guardiaHabitual {
	method puedeMover(posicion){
		return tablero.puedeOcupar(posicion, self)
	}
}

object guardiaEstatico {
	method puedeMover(posicion){
		return false
	}
}


class GuardiaPerseguidor inherits Guardia {

	const personajes = #{ harry, sirius }
	const property posicionDeCustodia

	override method perseguir() {
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
	}
  
  }


class ListaGuardias{

	const property guardias = #{}

	method agregarGuardia(guardia) {
		guardias.add(guardia)
	}
		method perseguir(){
		guardias.forEach({guardia => guardia.perseguir()})
	}
	
	method estaticos(){
			guardias.forEach({guardia => guardia.estatico()})
		}
}

object guardiasNoPerseguidores inherits ListaGuardias{
	
}

object guardiasPerseguidores inherits ListaGuardias{
}

class CaminoInvalido {

	const property position
	var property posicionEntrada = tunel.position()
	
	method colisionarCon(personaje){
		personaje.position(self.arribaDeLaEntrada())
	}

	method arribaDeLaEntrada() {
		return arriba.siguiente(posicionEntrada)
	}

	method esSolidoPara(personaje) {
		return false
	}

}

object caminosInvalidos{
	const property caminos = #{}
	
	method agregarCamino(camino){
		caminos.add(camino)
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


	method esSolidoPara(personaje){
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

object puertaANivel{
	var property position = game.at(0,0)
	
	method image()= "tunel.png"
	
	method esSolidoPara(personaje){
		return false
	}
	
	method colisionarCon(personaje){
		if (self.estanHarryYSirius()){
			protagonistas.congelar()
			game.schedule(100, {protagonistas.descongelar()})
			nivelActual.pasarDeNivel()
		}
	}
	
	method estanHarryYSirius(){ // se fija si estan los dos para cambiar de nivel
		return harry.position() == position && sirius.position() == position
	}
}





