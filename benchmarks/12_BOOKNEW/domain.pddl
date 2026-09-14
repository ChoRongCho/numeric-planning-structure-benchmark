(define (domain booknew)

;remove requirements that are not needed
(:requirements :strips :fluents :typing)


(:predicates ;todo: define predicates here
    (room ?r)
    (robot ?a)
    (book ?b)
    (tray ?t)
    (at-room ?a ?r)
    (at ?o ?r)
    (load ?a ?t)
    (free ?a)
    (carry ?o ?a)
)


; (:functions (capaicity ?c - container))

;define actions here
(:action move
    :parameters (?agent ?from ?to)
    :precondition (and 
        (room ?from) 
        (room ?to) 
        (at-room ?agent ?from)
    )
    :effect (and 
        (at-room ?agent ?to)
        (not (at-room ?agent ?from))
    )
)


(:action pick
    :parameters (?agent ?obj ?room)
    :precondition (and 
        (book ?obj) 
        (robot ?agent)
        (room ?room)
        (at ?obj ?room)
        (at-room ?agent ?room)
        (free ?agent)

    )
    :effect (and 
        (carry ?obj ?agent)
        (not (at ?obj ?room)) 
        (not (free ?agent))
    )
)
(:action load-book
    :parameters (?agent ?obj ?tray)
    :precondition (and 
        (book ?obj) 
        (tray ?tray) 
        (robot ?agent)
        (load ?agent ?tray)
        (carry ?obj ?agent)
    )
    :effect (and 
        (free ?agent)
    )
)
(:action drop
    :parameters  (?agent ?obj ?room)
    :precondition  (and
        (book ?obj) 
        (robot ?agent)
        (room ?room)
        (carry ?obj ?agent)
        (at-room ?agent ?room)
    )
    :effect (and 
        (at ?obj ?room)
        (free ?agent)
        (not (carry ?obj ?agent))
    )
)

(:action hold-tray
    :parameters (?agent ?tray ?room)
    :precondition (and 
        (tray ?tray) 
        (robot ?agent)
        (room ?room)
        (at ?tray ?room)
        (at-room ?agent ?room)
    )
    :effect (and 
        (load ?agent ?tray)
        (not (at ?tray ?room))
    )
)

(:action unhold-tray
    :parameters (?agent ?tray ?room)
    :precondition (and 
        (tray ?tray) 
        (robot ?agent)
        (room ?room)
        (load ?agent ?tray)
        (at-room ?agent ?room)
    )
    :effect (and 
        (at ?tray ?room)
        (not (load ?agent ?tray))
    )
)



)