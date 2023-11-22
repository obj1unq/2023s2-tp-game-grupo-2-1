import wollok.game.*
import personajes.*
import nivelx.*
import enemigos.*

class Objeto {
 
	var property position = game.at(0,0) 

	method image() 
	method esVacio() = false
	method serUsado(personaje) {}
	method abrir(personaje){}
	method colisionarCon(personaje){}

	method esSolidoPara(personaje) = false
	method esLlave() = false 
	method esVarita() = false
	method esNada()  = false
	
}


class Oculto inherits Objeto{
	
	override method image() = "ocultoo.png"
	
	override method serUsado(personaje) {
		personaje.transformarse()
	}
	
}

object objetosUsables {

	const objetosUsables = #{}

	method objetosUsables() {
		return objetosUsables
	}
	
	method agregarObjeto(objeto){
		objetosUsables.add(objeto)
	}

	method losQuePertenecen(objetos) {
		return objetos.filter({ objeto => objetosUsables.contains(objeto) })
	}

}

class LlaveRota inherits Objeto{
	 
	method generar (_position){
		self.position(_position)
		game.addVisual(self)
		objetosUsables.agregarObjeto(self)
	}
	 
	override method serUsado(personaje) {
			personaje.guardarLlaveRota(self)
			game.removeVisual(self)
	}

}

class Varita inherits Objeto{
	 
	override method image() = "varita.png"
	override method esVarita() = true
	
	
	override method serUsado(personaje){
			personaje.soltar()
			personaje.guardar(self)
			game.removeVisual(self)
	}
	

	method generar(posicion){
		position = posicion
		game.addVisual(self)
		objetosUsables.agregarObjeto(self)
	}

}

object llave inherits Varita{
	override method image() = "llave.png"
	override method esLlave() = true
	override method esVarita() = false

}



object cerrado{
	
	method estadoContrario() = abierto 
	method estaAbierto() = false
	method esSolidoPara(personaje) = true
}

object abierto{
	
	var property contenido = ""
	method estadoContrario() = cerrado
	method estaAbierto() = true
	method esSolidoPara(personaje) = false
}


class Sensor{
	
	const objetoApuntado 
	var property position = game.at(0,0)
	method colisionarCon(personaje){}
	method esSolidoPara(personaje) = false
	
	method serUsado(personaje){
			objetoApuntado.serUsado(personaje)
	
	}
	method abrir(personaje){
			objetoApuntado.abrir(personaje)
	}
	
}

class SensorPuertaM inherits Sensor(objetoApuntado = puertaNivelM){}


object varita inherits Varita{} 


object palanca inherits Palanca(objetoApuntado = puertaInteractuable){}

object vacio{}
object puertaInteractuable inherits Puerta{}

class Palanca {

	var property position = game.at(0,0)
	var property estado = palancaApagada
	var property objetoApuntado
	
	method image(){
		return estado.image()
	}
	
	method colisionarCon(personaje){
	}
	
 	method esSolidoPara(personaje) = true
	
	method puedePasar(personaje) = false
	
	method serUsado(personaje){
		estado.serUsado()
	}
	
	method cambiarEstado(){
		estado = estado.serCambiado()

	}
	method abrir(personaje){
		objetoApuntado.abrir(personaje)
	}
	
}


object palancaPrendida{
	
	method image(){
		return "palancag.gif"
	}
	
	method serUsado(){

	}
	
	method serCambiado(){
		return palancaApagada
	}
}

object palancaApagada{
	
	method image(){
		return "palanca off.png"
	}
	
	method serUsado(){
		palanca.cambiarEstado()
		puertaInteractuable.abrir()
	}
	
	method prenderse(){
		palanca.cambiarEstado()
	}
	
	method serCambiado(){
		return palancaPrendida
	}
	
}

class Puerta {
	
	var property position = game.at(0,0)
	var property estado = puertaCerrada
	
	method image(){
		
		return estado.image()
	}
	
	method colisionarCon(personaje){
	}
	
 	method esSolidoPara(personaje) = estado.esSolidoPara(personaje)
	
	method puedePasar(personaje) = estado.puedePasar()
	
	method serUsado(personaje){
		estado.serUsado()
	}
	
	method cambiarEstado(){
		estado = estado.serCambiado()
	}
	
	
	
	
	
	method abrir(){
		self.cambiarEstado()
	}
}

object puertaCerrada{
	
	method image(){
		return "puerta.png"
	}
	
	method serUsado(){
		puertaInteractuable.abrir()
	}
	
	method serCambiado(){
		return puertaAbierta
	}
}

object puertaAbierta{

	method serUsado(){

	}
	
	method serCambiado(){
		return puertaCerrada
	}
}

