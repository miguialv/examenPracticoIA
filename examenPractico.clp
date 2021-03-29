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
    (test (= resultado ?resultado))
    => 
    (halt)
)

(defrule sumar
    (robot ?robotX ?robotY false ?profundidad camino $?camino)
    (paquete ?paqX ?paqY)
    (test (= ?robotX ?paqX)) 
    (test (= ?robotY ?paqY))
    =>
    (assert (robot ?robotX ?robotY true 0 camino $?camino)) 
)

(defrule restar
    (robot ?robotX ?robotY true ?profundidad camino $?camino)
    ?a <- (almacen ?almacenX ?almacenY ?estado) 
    (test (= ?robotX ?almacenX))
    (test (= ?robotY ?almacenY)) 
    =>
    (assert (robot ?robotX ?robotY false ?profundidad camino $?camino))
    (retract ?a)
    (assert (almacen ?almacenX ?almacenY true))
    (assert (paquete ?almacenX ?almacenY))
    (printout t "El camino que hizo el robot para entregar el paquete es:" $?camino)
)

(defrule multiplicar
    (cuadricula ?Xmax ?Ymax)
    (robot ?robotX ?robotY ?estado ?profundidad camino $?camino)
    (not (obstaculos $?inicio x =(+ ?robotX 1) y ?robotY $?fin))
    (test (<= (+ ?robotX 1) ?Xmax))
    (test (<= ?profundidad ?*profundidad-maxima*))
    => 
    (assert (robot (+ ?robotX 1) ?robotY ?estado =(+ ?profundidad 1) camino $?camino x (+ ?robotX 1) y ?robotY))
)

(defrule dividir
    (cuadricula ?Xmax ?Ymax)
    (robot ?robotX ?robotY ?estado ?profundidad camino $?camino)
    (not (obstaculos $?inicio x =(- ?robotX 1) y ?robotY $?fin))  
    (test (>= (- ?robotX 1) 1))
    (test (<= ?profundidad ?*profundidad-maxima*))
    => 
    (assert (robot (- ?robotX 1) ?robotY ?estado =(+ ?profundidad 1) camino $?camino x (- ?robotX 1) y ?robotY))
)

(defrule mover-a-arriba
    (cuadricula ?Xmax ?Ymax)
    (robot ?robotX ?robotY ?estado ?profundidad camino $?camino)
    (not (obstaculos $?inicio x ?robotX y =(- ?robotY 1) $?fin))
    (test (>= (- ?robotY 1) 1))
    (test (<= ?profundidad ?*profundidad-maxima*))
    => 
    (assert (robot ?robotX (- ?robotY 1) ?estado =(+ ?profundidad 1) camino $?camino x ?robotX y (- ?robotY 1)))
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