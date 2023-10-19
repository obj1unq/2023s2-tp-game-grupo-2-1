import wollok.game.*
import objetosUtiles.*
import direcciones.*


class Personaje {
	
	var property estado   = self.estadoHabitual() 
	var property position = game.at(0,0)
	
	method initialize()
	method transformacion()
	method estadoHabitual()
	method puedePasar(puerta)
	method entrarEnZonaGuardias()
	method image() = estado.image()
	
	method transformarse(){
		estado = self.transformacion()
		game.schedule(10000, {self.estadoHabitual()})
	}
	
	method puedeOcupar(posicion) {
		return tablero.puedeOcupar(posicion, self)
	}

		
	method usarObjeto() {
		const colisiones = objetosUsables.losQuePertenecen(game.colliders(self))
		self.validarUso(colisiones)
		colisiones.head().serUsado(self)
	}
	
	method validarUso(objetos) {
		if (objetos.isEmpty()) {
			self.error("No tengo nada para usar")
		}
	}
	
		method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima)
	}

	method mover(direccion) {
		if (self.sePuedeMover(direccion)) {
			const proxima = direccion.siguiente(self.position())
			self.position(proxima)
		}
	}
	
	method volverAlPrincipio(){
		self.position(game.at(0,0))
	}
	
}

object harryy inherits Personaje{
	
	
	override method transformacion(){
		return harryInvisible
	}
	override method estadoHabitual(){
		return harryHumano
	}
	
	override method puedePasar(puerta){
		return false
	}
	
	override method entrarEnZonaGuardias(){
		estado.entrarEnZonaGuardias(self)
	}
}

object siriuss inherits Personaje{
	
	override method transformacion(){
		return siriusHumano
	}
	override method estadoHabitual(){
		return siriusPerro
	}
	
	override method puedePasar(puerta){
		return estado.puedePasar(puerta)
	}
	
	override method entrarEnZonaGuardias(){
		game.say(self, "Me pueden ver!")
		game.schedule(1500, {self.volverAlPrincipio()})
	}
}

object harry {

	var property estado = harryHumano
	var property position = game.center()

	method image() = estado.image()

	method ocultarse() {
		estado = harryInvisible
		game.schedule(10000, { self.estado(harryHumano)})
	}

	method puedeOcupar(posicion) {
		return tablero.puedeOcupar(posicion, self)
	}
	
	method puedePasar(puerta){
		return false
	}
	
	method entrarEnZonaGuardias(){
		estado.entrarEnZonaGuardias(self)
	}

//	method equiparSiPuede(objetoUtil) {
//		if (not objetoUtil.esEquipable()) {
//			game.say(self, "No hay nada acá")
//		}else{
//		objeto = objetoUtil
//		}
//	}
	method usarObjeto() {
		const colisiones = objetosUsables.losQuePertenecen(game.colliders(self))
		self.validarUso(colisiones)
		colisiones.head().serUsado(self)
	}

	method validarUso(objetos) {
		if (objetos.isEmpty()) {
			self.error("No tengo nada para usar")
		}
	}

	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima)
	}

	method mover(direccion) {
		if (self.sePuedeMover(direccion)) {
			const proxima = direccion.siguiente(self.position())
			self.position(proxima)
		}
	}

/*	method colisionasteConHarry() {
	}

	method colision(objeto) {
		objeto.colisionasteConHarry(self)
	}
*/
	
	method esSolidoPara(personaje){
		return false
	}
	
	method volverAlPrincipio(){
		self.position(game.at(0,0))
	}
	
	method colisionarCon(personaje){
		
	}

}


object sirius {

	var property estado = siriusHumano
	var property position = game.center()

	method image() = estado.image() + ".png"

	method ocultarse() {
		estado = siriusPerro
		game.schedule(10000, { self.estado(siriusHumano)})
	}

//	validar:
//	method validarEquipar(objetoUtil) {
//		if (not objetoUtil.esEquipable()) {
//			game.say(self, "No hay nada acá")
//		}
//	}
//	method equiparSiPuede(objetoUtil) {
//		self.validarEquipar(objetoUtil)
//		objeto = objetoUtil
//	}
	method usarObjeto() {
		const colisiones = objetosUsables.losQuePertenecen(game.colliders(self))
		self.validarUso(colisiones)
		colisiones.head().serUsado(self)
	}

	method validarUso(objetos) {
		if (objetos.isEmpty()) {
			self.error("No tengo nada para usar")
		}
	}

	method puedeOcupar(posicion) {
		return tablero.puedeOcupar(posicion, self)
	}
	
	method puedePasar(puerta){
		return estado.puedePasar(puerta)
	}
	
	method entrarEnZonaGuardias(){
		game.say(self, "Me pueden ver!")
		game.schedule(1500, {self.volverAlPrincipio()})
	}

	method sePuedeMover(direccion) {
		const proxima = direccion.siguiente(self.position())
		return self.puedeOcupar(proxima)
	}

	method mover(direccion) {
		if (self.sePuedeMover(direccion)) {
			const proxima = direccion.siguiente(self.position())
			self.position(proxima)
		}
	}
	
	method esSolidoPara(personaje){
		return false
	}
	
	method volverAlPrincipio(){
		self.position(game.at(0,0))
	}
	
	method colisionarCon(personaje){
		
	}

}

object harryHumano {

	method image() = "harry.png"
	
	method entrarEnZonaGuardias(personaje){
		game.say(personaje, "Me pueden ver!")
		game.schedule(1500, {personaje.volverAlPrincipio()})
	}

}

object harryInvisible {

	method image() = "harryInvisible.png"
	
	method entrarEnZonaGuardias(personaje){
		
	}

}

object caminando {

	method puedeMover() {
	}

}

object siriusHumano {

	method image() {
		return "sirius"
	}
	
	method puedePasar(puerta){
		return false
	}
	

}

object siriusPerro {

	method image() {
		return "siriusPerro"
	}
	
	method puedePasar(puerta){
		return true
	}
	

}


