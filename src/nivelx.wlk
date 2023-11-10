import wollok.game.*
import enemigos.*
import personajes.*
import objetosUtiles.*
import direcciones.*
 
object nivelx {
	
	const celdas = 
		[[[i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [p], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_]],
		 [[i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_]],
		 [[i], [i], [i], [i], [i], [i], [i], [i], [i], [_], [_], [_], [i], [i], [_], [p], [a], [a], [a], [a], [a], [a, g], [a], [a], [a], [a], [a], [a], [a], [a]],
		 [[i], [i], [i], [i], [i], [i], [i], [i], [i], [_], [i], [_], [_], [i], [_], [p], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a, g], [a], [a]],
		 [[i], [i], [i], [i], [i], [i], [i], [i], [i], [_], [_], [i], [_], [_], [_], [p], [a], [a], [a], [a, g], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a]],
		 [[i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [_], [i], [i], [i], [i], [p], [a], [a], [a], [a], [a], [a, g], [a], [a], [a], [a], [a], [a], [a], [a]],
		 [[i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [_], [_], [i], [i], [i], [p], [a], [a], [a], [a], [a], [a], [a], [a, g], [a], [a], [a], [a], [a], [a]],
		 [[i], [i], [i], [i], [_], [_], [_], [_], [i], [i], [i], [_], [i], [i], [i], [p], [a, o], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a]],
		 [[i], [i], [_], [_], [_], [i], [i], [_], [_], [_], [i], [_], [i], [i], [i], [p], [a], [a], [a, g], [a], [a], [a, g], [a], [a], [a], [a], [a, g], [a], [a], [a]],
		 [[i], [i], [_], [i], [i], [i], [i], [i], [i], [_], [i], [_], [i], [i], [i], [p], [a], [a], [a], [a], [a], [a], [a], [a], [a, g], [a], [a], [a], [a], [a]],
		 [[i], [i], [_], [i], [i], [i], [i], [i], [i], [_], [_], [_], [i], [i], [i], [p], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a]],
		 [[i], [i], [_], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [p], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a, g], [a], [a], [a]],
		 [[i], [i], [_], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [i], [p], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a], [a]],
		 [[i], [i], [_], [_], [i], [_], [_], [_], [i], [i], [i], [i], [i], [i], [i], [p], [a], [a], [a], [a, g], [a], [a], [a], [a], [a, g], [a], [a], [a], [a], [a]],
		 [[i], [i], [i], [_], [_], [_], [i], [_], [i], [i], [i], [i], [i], [i], [i], [p], [a], [a], [a], [a], [a, g], [a], [a], [a], [a], [a], [a], [a], [a], [a]],
		 [[p], [p], [p], [p], [p], [p], [p], [tn], [p], [p], [p], [p], [p], [p], [p], [p], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_]],
		 [[_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [o], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_]],
		 [[h], [s], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_], [_]]
	].reverse()
	
	
/*	const guardiasYOculto=
		[[_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, p, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, o, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, g, _, _, _, _, g, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, g, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, g, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _],
		 [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]
	].reverse()
	
	*/
	
	
	method generar(){
		(0..game.width() -1).forEach({x=> 
					(0..game.height() -1).forEach({y=>
								self.generarCelda(x,y)})
		})
		
		
	}

	method generarCelda(x,y){
		const celda = celdas.get(y).get(x)
		celda.forEach({objeto => objeto.generar(game.at(x,y))})
	}
	
}

object _{
	method generar(position){}
}

object i{
	method generar(_position){
		game.addVisual(new CaminoInvalido(position = _position))
	}
}

object tn{
	
	method validarEntrada(personaje){
		if  (not personaje.puedePasarCueva()){
			self.error("No puedo entrar ahi!")
		}
	}
	
	method generar(position){
		game.addVisual(tunel)
		tunel.position(position)
		
	}
}

object o{
	method generar(position){
		const oculto = new Oculto(position = position)
		game.addVisual(oculto)
		objetosUsables.agregarObjeto(oculto)
	}
}

object p{
	method generar(position){
		game.addVisual(new Pared(position = position))
	}
}

object g{

	method generar(position){
		const guardia = new Guardia(position = position)
		game.addVisual(guardia)
		listaGuardias.agregarGuardia(guardia)
	}
}

object a{
	method generar(position){
		game.addVisual(new ZonaDeGuardias(position = position))
	}
}

object h{
	method generar(position){
		harry.position(position)
		game.addVisual(harry)
	}
}

object s{
	method generar(position){
		sirius.position(position)
		game.addVisual(sirius)   
	}
}


//object nivel2{
//	
//		method generar(){
//		(0..game.width() -1).forEach({x=> 
//					(0..game.height() -1).forEach({y=>
//								self.generarCelda(x,y)})
//		})
//		
//		
//	}
//
//	method generarCelda(x,y){
//		const celda = celdas.get(y).get(x)
//		celda.forEach({objeto => objeto.generar(game.at(x,y))})
//	}
//}

