(deffacts inicio
    (dd juan maria rosa m)
    (dd juan maria luis h)
    (dd jose laura pilar m)
    (dd luis pilar miguel h)
    (dd miguel isabel jaime h)
    (dd fernando rosa felipe h)
    (dd fernando rosa paz m))

(defrule padre
    (dd ?x ? ?y ?)
    =>
    (assert (padre ?x ?y)))

(defrule madre 
	(dd ? ?x ?y ?)
	=>
	(assert (madre ?x ?y)))

(defrule hijo
	(dd ?x ?y ?z h)
	=>
	(assert (hijo ?z ?x))
	(assert (hijo ?z ?y)))

(defrule hija
	(dd ?x ?y ?z m)
	=>
	(assert (hija ?z ?x))
	(assert (hija ?z ?y)))

(defrule hermano
	(dd ?p ?m ?hijo1 h)
	(dd ?p ?m ?hijo2 ?)
	(test (neq ?hijo1 ?hijo2)) ;; comprobacion porque uno mismo es hermano de si mismo
	=>
	(assert (hermano ?hijo1 ?hijo2)))

(defrule hermana
	(dd ?p ?m ?hijo1 m)
	(dd ?p ?m ?hijo2 ?)
	(test (neq ?hijo1 ?hijo2))
	=>
	(assert (hermana ?hijo1 ?hijo2)))

(defrule abuelo
	(padre ?y ?x)
	(or (dd ?x ? ?z ?)
		(dd ? ?x ?z ?))
	=>
	(assert (abuelo ?y ?z)))

(defrule abuela
	(madre ?y ?x)
	(or (dd ? ?x ?z ?)
		(dd ?x ? ?z ?))
	=>
	(assert (abuela ?y ?z)))

(defrule primo
	(hijo ?x ?padre) ;; padre como uno de los progenitores, no como exclusivamente el paterno
	(or (hermano ?padre ?y) (hermana ?padre ?y))
	(or (hijo ?z ?y) (hija ?z ?y))
	=>
	(assert (primo ?x ?z)))

(defrule prima
	(hija ?x ?padre)
	(or (hermano ?padre ?y) (hermana ?padre ?y))
	(or (hijo ?z ?y) (hija ?z ?y))
	=>
	(assert (prima ?x ?z)))

(defrule ascendienteDirecto
	(padre ?p ?x)
	(madre ?m ?x)
	=>
	(assert (ascendiente ?p ?x))
	(assert (ascendiente ?m ?x)))

(defrule ascendiente ;; ascendentes de mis ascendentes son los mios tambien
	(ascendiente ?a ?p)
	(or (hijo ?x ?p) (hija ?x ?p))
	=>
	(assert (ascendiente ?a ?x)))


