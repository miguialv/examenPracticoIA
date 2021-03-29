;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------
;       VARIABLES AUXILIARES
;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------

(defglobal 
    ?*resultado* = 21
)

;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------
;       BASE DE HECHOS
;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------

(deffacts base-de-hechos	
    (lista 3 5 7 8 14)
)

;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------
;       REGLAS
;---------------------------------------------------------------------------------
;---------------------------------------------------------------------------------

(defrule acabar
    (declare (salience 99))
    (resulado ?resultado)
    (?resultado = resultadoOp)
    (test (= resultado ?resultado))
    => 
    (halt)
)

(defrule sumar
    (lista ?sumando1 ?sumando2 resultado)
    (?resultadoSuma = (?sumando1 + ?sumando2)
    (?resultadoOp = ?resultadoSuma)	 	
    
    =>
    (assert (robot ?robotX ?robotY true 0 camino $?camino))
    (printout t "El resultado de la suma es:" resultadoSuma) 
)

(defrule restar
    (lista ?restando1 ?restando2 resultado)
    (resultadoResta = (?restando1 + ?restando2)
    (?resultadoOp = resultadoResta)	  
    =>
    (assert (robot ?robotX ?robotY false ?profundidad camino $?camino))
    (retract ?a)
    (assert (almacen ?almacenX ?almacenY true))
    (assert (paquete ?almacenX ?almacenY))
    (printout t "El camino que hizo el robot para entregar el paquete es:" $?camino)
)

(defrule multiplicar
    (lista ?restando1 ?restando2 resultado)
    (resultadoResta = (?restando1 * ?restando2)
    (?resultadoOp = resultadoMultiplicacion)
    => 
    (assert (robot (+ ?robotX 1) ?robotY ?estado =(+ ?profundidad 1) camino $?camino x (+ ?robotX 1) y ?robotY))
)

(defrule dividir
    (lista ?dividendo ?divisor ?resto resultado)
    (?resto = 0)
    ((= mod(?dividendo ?divisor), ?resto)  
    (resultadoResta = (div (?dividendo ?divisor)))
    (?resultadoOp = resultadoDivision)
    => 
    (assert (robot (- ?robotX 1) ?robotY ?estado =(+ ?profundidad 1) camino $?camino x (- ?robotX 1) y ?robotY))
)



(defrule mover-a-abajo
    (cuadricula ?Xmax ?Ymax)
    (robot ?robotX ?robotY ?estado ?profundidad camino $?camino)
    (not (obstaculos $?inicio x ?robotX y =(+ ?robotY 1) $?fin))  
    (test (<= (+ ?robotY 1) ?Ymax))
    (test (<= ?profundidad ?*profundidad-maxima*))
    => 
    (assert (robot ?robotX (+ ?robotY 1) ?estado =(+ ?profundidad 1) camino $?camino x ?robotX y (+ ?robotY 1)))
)