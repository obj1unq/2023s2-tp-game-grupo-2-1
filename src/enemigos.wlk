import wollok.game.*
import direcciones.*
import personajes.*
import nivelx.*
import objetosUtiles.*


class Guardia {

	var property position = game.at(2, 3)
	var ladoAMover = derecha
	var property estado = guardiaHabitual


	method image() {

		return "dementor_" + ladoAMover.toString() + ".png"
	}

	method perseguir() {
		const proxima = ladoAMover.siguiente(position)
		if (not self.puedeMover(proxima)) {
			self.cambiarLado()
		} else {
			position = proxima
		}
	}

	
	method puedeMover(posicion){
		return estado.puedeMover(posicion)
	}
	method cambiarLado() {
		ladoAMover = ladoAMover.opuesto()
	}
	

	method esSolidoPara(personaje) {
		return true
	}
	
	method elGuardiaEsSolido() = true
	
	method colisionarCon(personaje) {
		game.say(self, "te atrapé!")
		personaje.serAtrapado()
	}

	method estatico(){
		estado = guardiaEstatico
		game.schedule(5000, {estado = guardiaHabitual})
	}

	method puedePasar(personaje)=false

	
}

object guardiaHabitual {
	method puedeMover(posicion){
		return tablero.puedeOcupar(posicion, self)
	}
	method elGuardiaEsSolido() = true
	method puedePasar(personaje)=false
}

object guardiaEstatico {
	method puedeMover(posicion){
		return false
	}
	method puedePasar(personaje)=false
	method elGuardiaEsSolido() = true
}


class GuardiaPerseguidor inherits Guardia {

	const property posicionDeCustodia

	override method perseguir() {
		const intrusoCercano = self.intrusoMasCercano()
		if (self.puedePerseguir(intrusoCercano)) {
			self.acercarseHacia(intrusoCercano.position())
		} else {
			self.volverPosicionCustodia()
		}
	}

	method acercarseHacia(destino) {
		
		if (self.estaAlLado(destino)) {
			self.posicionarseEncima(destino)
		} else {
			self.avanzarHacia(self.siguientePosicion(destino))
		}
	}

	method avanzarHacia(posicionSig) {
		if (self.puedeMover(posicionSig)) {
			position = posicionSig
		}
	}

	method volverPosicionCustodia() {
		if (self.position() != self.posicionDeCustodia()) {
			self.acercarseHacia(self.posicionDeCustodia())
		}
	}


	method posicionarseEncima(destino) {
		position = game.at(destino.x(), destino.y())
	}

	method siguientePosicion(destino) {
		return game.at(self.position().x() + (destino.x() - self.position().x()).div(2), 
			self.position().y() + (destino.y() - self.position().y()).div(2)
		)
	}
	
	method intrusoMasCercano() {
		return protagonistas.personajes().min({ personaje => self.distanciaMenorEntre(personaje) })
	}
	
	method distanciaMenorEntre(personaje) {
		return (self.position().x() - personaje.position().x()).min(self.position().y() - personaje.position().y())
	}
	
	method puedePerseguir(intrusoCercano) {
		return self.puedeVerlo(intrusoCercano)
	}
	
	method estaAlLado(destino) {
		return 1 == (self.position().x() - destino.x()).abs() and 
			   1 == (self.position().y() - destino.y()).abs()
	}
	

	method puedeVerlo(personaje) {
		return personaje.esPerseguible() and 
		self.verAInfiltrado() >= self.position().x() - personaje.position().x() and self.verAInfiltrado() >= self.position().y() - personaje.position().y()
	}

	method verAInfiltrado() {
		return 5
	}

	override method esSolidoPara(personaje) {
		return personaje.elGuardiaEsSolido()
	}

	override method colisionarCon(personaje) {
			game.say(self, "¡TE ATRAPE!")
			personaje.volverAlPrincipio()
			self.volverPosicionCustodia()
	}
  
}



class ListaGuardias {


	const property guardias = #{}

	method agregarGuardia(guardia) {
		guardias.add(guardia)
	}

	method acercarseHacia(){
		guardias.forEach({ guardia => guardia.acercarseHacia(guardia.intrusoMasCercano().position())})
	}
	
	method perseguir() {
		guardias.forEach({ guardia => guardia.perseguir()})
	}
	
	method estaticos(){
			guardias.forEach({guardia => guardia.estatico()})
	}
}


object guardiasNoPerseguidores inherits ListaGuardias {}

object guardiasPerseguidores inherits ListaGuardias {}


class CaminoInvalido {

	const property position
	var property posicionEntrada = tunel.position()
	
	method image(){
		return "baldoza.png"
	}

	method colisionarCon(personaje) {
		personaje.position(self.arribaDeLaEntrada())
		caminosValidos.iluminar()
	}

	method arribaDeLaEntrada() {
		return arriba.siguiente(posicionEntrada)
	}

	method esSolidoPara(personaje) {
		return false
	}
	

}

class CaminoValido{
	const property position
	var estado = caminoNormal
	
	method image(){
		return estado.image()
	}
	
	method iluminar(){
		estado = caminoIluminado
		game.schedule(3000, {estado = caminoNormal})
	}
	
	method esSolidoPara(personaje) {
		return false
	}
	
	method colisionarCon(personaje){}
}

object caminosValidos{
	const caminos = #{}
	
	method iluminar(){
		caminos.forEach({camino => camino.iluminar()})
	}
	
	method agregarCamino(camino) {
		caminos.add(camino)
	}
}

object caminoNormal{
	method image(){
		return "baldoza.png"
	}
}

object caminoIluminado{
	method image(){
		return "baldozaAzul.png"
	}
}

class Tunel {

	var property position = game.at(0, 0)
	
	method image() = return "tunel.png"

	method esSolidoPara(personaje) {
		return not personaje.puedePasar(self)
	}

	method colisionarCon(personaje) {
	}

}

object tunel inherits Tunel(position = (game.at(7, 2))){}

class Pared {

	const property position

	method esSolidoPara(personaje) {
		return true
	}

	method colisionarCon(personaje) {
	}
   
}

class ParedVisible inherits Pared{
	method image() = "pared.png"
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

class ZonaVigilada inherits ZonaDeGuardias{
	override method colisionarCon(personaje){
		if (personaje.esPerseguible()){
			guardiasPerseguidores.acercarseHacia()	
		}
			 	
	}
}

class PuertaNivel{

	var property position = game.at(0, 0)
	var property estado 
	var property sensor = null
	
	method puedePasar(){
	}
	
	method esSolidoPara(personaje){
		// La puerta sabe si esta abierta o no segun el estado que posea.
		return estado.esSolidoPara(personaje)
	} 
	
	method serUsado(personaje){	
	}
	
	method abrir(personaje){
		if (personaje.tieneLlave()){
				estado = abierto		
			}
	}
	
	method colisionarCon(personaje) {
		if (self.sePuedePasarNivel()) {
			protagonistas.congelar()
			game.schedule(100, { protagonistas.descongelar()})
			nivelActual.pasarDeNivel()
			
		}
	}
	
	method sePuedePasarNivel(){

	return self.estanHarryYSirius() 

	}
	
	method estanHarryYSirius() { // se fija si estan los dos para cambiar de nivel
		return harry.position() == position && sirius.position() == position
	}

}

class ListaDePuas {
	
	const property puas = #{}

	method agregarPua(pua) {
		puas.add(pua)
	}
	
	method activarMovimiento(){
	puas.forEach({ pua => pua.activarMovimiento()})
	}
}


object puertaNivel inherits PuertaNivel(estado = abierto){}
object puertaNivelM inherits PuertaNivel (estado = cerrado){}

object caminoDePuas inherits ListaDePuas{}

class Pua {
	
	var property position
	var property estado = puaInactiva

	method image(){
		return estado.image()
	}
	
	method colisionarCon(personaje) {
		estado.colisionarCon(personaje)
	}

	method esSolidoPara(personaje) {
		return false
	}
	
	method puedePasar(personaje) = true
	
	method activarMovimiento(){
		estado = estado.serCambiado()	
		if(protagonistas.hayAlgunoEnLaMismaPosicionQue(self)){
				estado.colisionarCon(protagonistas)
		}
	}
	
}

object puaInactiva{
	
	method image(){
		return "puas adentro.png"
	}
	
	method haceDanio(){
		return false
	}
	
	method colisionarCon(personaje){
		
	}
	
	method serCambiado(){
		return puaActiva
	}

}

object puaActiva{
	
	method image(){
		return "puas.png"
	}
	
	method haceDanio(){
		return true
	}
	
	method colisionarCon(personaje){
		personaje.perder()
 }
	
	method serCambiado(){
		return puaInactiva
	}
}

class TunelInvisible {

    var property position 
    

    method esSolidoPara(personaje) {
        return not personaje.puedePasar(self)
    }

    method colisionarCon(personaje) {
    }

}

class TunelVisible inherits TunelInvisible{
    method image() = "tunel.png"
}
