import wollok.game.*
import personajes.*
class Objeto {

	var property position = game.at(0,0) 

	method image() 

	method serUsado(personaje) {}
	method abrir(personaje){}
	method colisionarCon(personaje){}
	
	method esSolidoPara(personaje) = false
	
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

object varita inherits Objeto{
	 
	method esLlave() = false
	method esVarita() = true

	override method image() = "varita.png"
	override method serUsado(personaje){
		personaje.llevaVarita()
		game.removeVisual(self)
	}
}

class Cofre inherits Objeto{
	
	var property estado = cerrado
	override method image() = "cofre" + self.estado() + ".png"

	override method abrir(personaje){
		personaje.contenidoPermitido()
		self.estado(estado.estadoContrario())
	}
	
	method estaEnFrente(personaje){
		return personaje.position().y() == (position.y() - 1)
	}
		
	
	override method esSolidoPara(personaje) = true
	
	method estaAbierto(){
		return estado.estaAbierto()
	}
}

object cerrado{
	
	var property contenido = varita
	method estadoContrario() = "" + abierto + self.contenido() + ""
	method estaAbierto() = false

}

object abierto{
	
	method estadoContrario() = cerrado
	method estaAbierto() = true
	method esSolidoPara(personaje){
		return false
	}
}

class Sensor{
    
    const objetoApuntado 
    var property position = game.at(0,0)
    method colisionarCon(personaje){}
    method esSolidoPara(personaje) = false
    method serUsado(personaje){}
    method abrir(personaje){
            objetoApuntado.abrir(personaje)
    }

    
}

class SensorCofre inherits Sensor {
	
    override method serUsado(personaje){
        personaje.obtenerVarita()
        cerrado.contenido(vacio)
    }
}

class SensorPuerta inherits Sensor{
    
}

class SensorPalanca inherits Sensor{
    
    override method serUsado(personaje){
    	palanca.serUsado(personaje)
    }
    
}

object palanca inherits Palanca{}
object cofre inherits Cofre{}
object vacio{}
object puerta inherits Puerta{}

class Palanca {

	var property position = game.at(0,0)
	var property estado = palancaApagada
	
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
		puerta.abrir()
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
		puerta.abrir()
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

