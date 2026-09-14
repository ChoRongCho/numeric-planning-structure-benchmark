(define (domain watering)

(:requirements :strips :fluents :action-costs)

(:predicates
    (agent ?agent)
    (plant ?plant)
    (container ?container)
    (tap ?tap)
    (room ?room)
    (station ?station)
    
    (holding ?agent ?container)
    (free ?agent)
    (at ?item ?room)
    (connected ?from ?to)
)


(:functions ;todo: define numeric functions here
    ;;constant
    (battery-cap ?agent)
    (distance ?from ?to)
    (max-carry ?container) ; The maximum volume of water the agent can carry-out

    ;;fluent
    (current-battery ?agent) ; the current-battery level
    (carrying ?agent ?container)
    (poured ?plant)
    
    ;;counters
    (total-cost)
)


(:action move
    :parameters (?agent ?from ?to)
    :precondition (and 
        (agent ?agent)
        (room ?from)
        (room ?to)
        (connected ?from ?to)
        (at ?agent ?from)
        (> (current-battery ?agent)(distance ?from ?to))
    )
    :effect (and 
        (at ?agent ?to)
        (not (at ?agent ?from))
        (decrease (current-battery ?agent) (distance ?from ?to))
        (increase (total-cost) (distance ?from ?to))
    )
)


(:action pick
    :parameters (?agent ?container ?room)
    :precondition (and 
        (agent ?agent)
        (container ?container)
        (room ?room)
        (free ?agent)
        (at ?container ?room)
        (at ?agent ?room)
        (> (current-battery ?agent) 10)
    )
    :effect (and 
        (holding ?agent ?container)
        (not (free ?agent))
        (not (at ?container ?room))
        (decrease (current-battery ?agent) 10)
        (increase (total-cost) 1)
    )
)

(:action drop
    :parameters (?agent ?container ?room)
    :precondition (and 
        (agent ?agent)
        (container ?container)
        (room ?room)
        (holding ?agent ?container)
        (at ?agent ?room)
        (> (current-battery ?agent) 10)
    )
    :effect (and 
        (free ?agent)
        (at ?container ?room)
        (not (holding ?agent ?container))
        (decrease (current-battery ?agent) 10)
        (increase (total-cost) 1)
    )
)

(:action load-water
    :parameters (?agent ?container ?tap)
    :precondition (and 
        (agent ?agent)
        (container ?container)
        (room ?tap)
        (tap ?tap)
        (at ?agent ?tap)
        (holding ?agent ?container)
        (< (carrying ?agent ?container) (max-carry ?container))
        (> (current-battery ?agent) 10)
    )
    :effect (and 
        (assign (carrying ?agent ?container) (max-carry ?container)) ; container is full
        (decrease (current-battery ?agent) 10)
        (increase (total-cost) 15)
    )
)

(:action pour-all-water
    :parameters (?agent ?container ?plant ?room)
    :precondition (and 
        (agent ?agent)
        (container ?container)
        (plant ?plant)
        (room ?room)
        (at ?agent ?room)
        (at ?plant ?room)
        (holding ?agent ?container)
        (> (carrying ?agent ?container) 0)
        (> (current-battery ?agent) 3)
    )
    :effect (and 
        (assign (carrying ?agent ?container) 0)
        (increase (poured ?plant) (carrying ?agent ?container))
        (decrease (current-battery ?agent) 3)
        (increase (total-cost) 5)
    )
)

(:action pour-water
    :parameters (?agent ?container ?plant ?room)
    :precondition (and 
        (agent ?agent)
        (container ?container)
        (plant ?plant)
        (room ?room)
        (at ?agent ?room)
        (at ?plant ?room)
        (holding ?agent ?container)
        (> (carrying ?agent ?container) 0)
        (> (current-battery ?agent) 3)
    )
    :effect (and 
        (decrease (carrying ?agent ?container) 1)
        (increase (poured ?plant) 1)
        (decrease (current-battery ?agent) 3)
        (increase (total-cost) 3)
    )
)

(:action charge-battery
    :parameters (?agent ?station)
    :precondition (and 
        (agent ?agent)
        (room ?station)
        (station ?station)
        (at ?agent ?station)
    )
    :effect (and 
        (assign (current-battery ?agent) (battery-cap ?agent))
        (increase (total-cost) 40)
    )
)
)