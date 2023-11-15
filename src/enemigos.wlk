import wollok.game.*
import direcciones.*
import personajes.*
import nivelx.*

class Guardia {
	var property position = game.at(2,3)
	var ladoAMover = derecha
	
	
	method image(){
		return "guardia." + ladoAMover.toString() + ".png"
	}
	
	method perseguir(){
		const proxima = ladoAMover.siguiente(position)
		if (not self.puedeMover(proxima)){
			self.cambiarLado()
		}else {position = proxima}
	}
	
	method cambiarLado(){
		ladoAMover = ladoAMover.opuesto()
	}
	
	method puedeMover(posicion){
		return tablero.puedeOcupar(posicion, self)
	}
	
	method esSolidoPara(personaje){
		return false
	}
	
	method colisionarCon(personaje){
		game.say(self, "te atrapé!")
		personaje.serAtrapado()
	}
	
}

class GuardiaPerseguidor inherits Guardia{
    
    const property posicionDeCustodia

    override method perseguir(){
    	
    	
    	if (self.puedePerseguir()){
    		const destino = self.intrusoMasCercano().position()	
    		self.atraparSiEstaCerca(destino)
    		self.darUnPaso(destino)
    	}else{
    		self.volverPosicionCustodia()
    	}
    }
    
    method volverPosicionCustodia(){
    	if (self.position() != self.posicionDeCustodia()){
    		self.darUnPaso(self.posicionDeCustodia())
    	}
    }
   
    
    method puedePerseguir(){
    	return  self.veAlgunIntruso() 
    }
    
    method atraparSiEstaCerca(destino){
    	if (self.estaAlLado(destino)){
    			 position = game.at( destino.x(), destino.y())
    	}
    }
    
    method darUnPaso(destino){
    		    position = game.at (
            	   self.position().x() + (destino.x() - self.position().x()).div(2),
            	   self.position().y() + (destino.y() - self.position().y()).div(2))
    }
    
    method veAlgunIntruso(){
    	  return protagonistas.personajes().any({personaje => self.puedoVerlo(personaje)})
    }
    
    method intrusoMasCercano(){
    	  return protagonistas.personajes().min({personaje => self.distanciaMenorEntre(personaje) })
    }
    
	method estaAlLado(destino){
		return  1 >= (self.position().x() - destino.x()).abs() and
				1 >= (self.position().y() - destino.y()).abs()    
  			
	}
   
    method puedoVerlo(personaje){
    	   
    	return personaje.esPerseguible() and
    		self.verAInfiltrado() >= self.position().x() - personaje.position().x() and  
			self.verAInfiltrado() >= self.position().y() - personaje.position().y() 
			
  			
    }	
    
     method verAInfiltrado(){
        return 3
    }   
    
    method distanciaMenorEntre(personaje){
        return self.position().x() - personaje.position().x().min( self.position().y() - personaje.position().y())
    }
    
    override method colisionarCon(personaje){
		game.say(self, "te atrapé!")
		personaje.volverAlPrincipio()
	}
    
    
}

class ListaGuardias{
	const property guardias = #{}
	
	method agregarGuardia(guardia){
		guardias.add(guardia)
	}
	
		method perseguir(){
		guardias.forEach({guardia => guardia.perseguir()})
	}
}

object guardiasNoPerseguidores inherits ListaGuardias{

}

object guardiasPerseguidores inherits ListaGuardias{
}


class CaminoInvalido{
	const property position
	var property posicionEntrada = tunel.position()
	
	method colisionarCon(personaje){
		personaje.position(self.arribaDeLaEntrada())
	}
	
	method arribaDeLaEntrada(){
		return arriba.siguiente(posicionEntrada)
	}
	
	method esSolidoPara(personaje){
		return false
	}
}

object caminosInvalidos{
	const property caminos = #{}
	
	method agregarCamino(camino){
		caminos.add(camino)
	}
}


object tunel{
	var property position = game.at(0,0)
	
	method image(){
		return "tunel.png"
		
	}
	
	method esSolidoPara(personaje){

		return not personaje.puedePasar(self)
	}
	
	method colisionarCon(personaje){

	}
	
}


class Pared{
	const property position
	
	method image(){ //Lo habian comentado no se por que, si alguien lo necesita invisible avise o haga una clase distinta!
		return "pared.png"
	}
	
	method esSolidoPara(personaje){
		return true
	}
	
	method colisionarCon(personaje){}
}

class ZonaDeGuardias{
	const property position
	
	
	method colisionarCon(personaje){
		personaje.entrarEnZonaGuardias()
	}
	
	method esSolidoPara(personaje){
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




