(define (domain logistic-new)

(:requirements :strips :typing :action-costs)

(:predicates 
    (package ?i)
    (heavy ?i)
    (fragile ?i)
    (truck ?t)
    (driver ?d)
    (place ?p)

    (at ?item ?place)
    (loaded ?package ?truck)
    (in ?driver ?truck)
    (road ?place1 ?place2)
    (highway ?place1 ?place2)		



)

(:functions (total-cost))



(:action load-package
    :parameters (?driver ?package ?truck ?place)
    :precondition(and 
        (driver ?driver)
        (package ?package)
        (truck ?truck)
        (place ?place)
        (at ?driver ?place)
        (at ?truck ?place)
        (at ?package ?place)
    )
    :effect(and 
        (not (at ?package ?place))
        (loaded ?package ?truck)
        (increase (total-cost) 1)
    )
)

(:action unload-package
    :parameters (?driver ?package ?truck ?place)
    :precondition(and
        (driver ?driver)
        (package ?package)
        (truck ?truck)
        (place ?place)

        (at ?driver ?place)
        (at ?truck ?place)
        (loaded ?package ?truck)
    )
    :effect(and 
        (not (loaded ?package ?truck))
        (at ?package ?place)
        (increase (total-cost) 1)
    )
)

(:action board-truck
    :parameters (?driver ?truck ?place)
    :precondition (and 
        (driver ?driver)
        (truck ?truck)
        (place ?place)
        (at ?truck ?place)
        (at ?driver ?place)
    )
    :effect (and
        (not (at ?driver ?place))
        (in ?driver ?truck)
        (increase (total-cost) 1)
    )
)

(:action get-out
    :parameters (?driver ?truck ?place)
    :precondition (and 
        (driver ?driver)
        (truck ?truck)
        (place ?place)
        (at ?truck ?place)
        (in ?driver ?truck)
    )
    :effect (and
        (not (in ?driver ?truck))
        (at ?driver ?place)
        (increase (total-cost) 1)
    ) 
)

(:action drive-truck
    :parameters (?driver ?truck ?from ?to)
   
    :precondition (and 
        (driver ?driver)
        (truck ?truck)
        (place ?from)
        (place ?to)
        (at ?truck ?from)
        (in ?driver ?truck)
        (road ?from ?to)
    )
   
    :effect (and
        (not (at ?truck ?from))
        (at ?truck ?to)
        (increase (total-cost) 1)
        
    ) 
)

(:action highway-drive-truck
    :parameters (?driver ?truck ?from ?to)
   
    :precondition (and 
        (driver ?driver)
        (truck ?truck)
        (place ?from)
        (place ?to)
        (at ?truck ?from)
        (in ?driver ?truck)
        (highway ?from ?to)
    )
   
    :effect (and
        (not (at ?truck ?from))
        (at ?truck ?to)
        (increase (total-cost) 1)
        
    ) 
)

(:action walk-alone
    :parameters (?driver ?from ?to)
   
    :precondition (and 
        (driver ?driver)
        (place ?from)
        (place ?to)
        (at ?driver ?from)
        (road ?from ?to)
    )
    :effect (and
        (not (at ?driver ?from))
        (at ?driver ?to)
        (increase (total-cost) 1)
        
    ) 
)
(:action walk-with-package
    :parameters (?driver ?package ?from ?to)
    :precondition (and 
        (driver ?driver)
        (package ?package)
        (place ?from)
        (place ?to)
        (at ?driver ?from)
        (at ?package ?from)
        (road ?from ?to)
    )
    :effect (and 
        (not (at ?driver ?from))
        (not (at ?package ?from))
        (at ?driver ?to)
        (at ?package ?to)
        (increase (total-cost) 1)
    )
)

 
)
