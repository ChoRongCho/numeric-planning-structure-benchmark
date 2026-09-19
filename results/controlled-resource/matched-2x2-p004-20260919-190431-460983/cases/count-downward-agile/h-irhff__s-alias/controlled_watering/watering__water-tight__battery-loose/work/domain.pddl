(define (domain robotic-watering)
  (:requirements :strips :typing :fluents)

  (:types robot plant container location)

  (:predicates
    (at-robot ?robot - robot ?location - location)
    (plant-at ?plant - plant ?location - location)
    (container-at ?container - container ?location - location)
    (holding ?robot - robot ?container - container)
    (hand-free ?robot - robot)
    (connected ?from ?to - location)
    (tap ?location - location)
    (charging-station ?location - location)
    (home ?location - location)
  )

  (:functions
    ;; Replenishable resources.
    (battery-capacity ?robot - robot)
    (battery-level ?robot - robot)
    (container-capacity ?container - container)
    (water-level ?container - container)

    ;; Service demand.
    (plant-demand ?plant - plant)
    (watered-amount ?plant - plant)

    ;; Static edge properties.
    (move-energy ?from ?to - location)
    (move-time ?from ?to - location)

    ;; Static manipulation/service costs.
    (pick-time)
    (drop-time)
    (fill-time)
    (watering-unit-time)
    (charge-time)
    (pick-energy)
    (drop-energy)
    (fill-energy)
    (watering-unit-energy)

    ;; Optimization objective.
    (total-watering-time)
  )

  (:action move
    :parameters (?robot - robot ?from ?to - location)
    :precondition (and
      (at-robot ?robot ?from)
      (connected ?from ?to)
      (>= (battery-level ?robot) (move-energy ?from ?to))
    )
    :effect (and
      (not (at-robot ?robot ?from))
      (at-robot ?robot ?to)
      (decrease (battery-level ?robot) (move-energy ?from ?to))
      (increase (total-watering-time) (move-time ?from ?to))
    )
  )

  (:action pick-container
    :parameters (?robot - robot ?container - container ?location - location)
    :precondition (and
      (at-robot ?robot ?location)
      (container-at ?container ?location)
      (hand-free ?robot)
      (>= (battery-level ?robot) (pick-energy))
    )
    :effect (and
      (not (container-at ?container ?location))
      (not (hand-free ?robot))
      (holding ?robot ?container)
      (decrease (battery-level ?robot) (pick-energy))
      (increase (total-watering-time) (pick-time))
    )
  )

  (:action drop-container
    :parameters (?robot - robot ?container - container ?location - location)
    :precondition (and
      (at-robot ?robot ?location)
      (holding ?robot ?container)
      (>= (battery-level ?robot) (drop-energy))
    )
    :effect (and
      (not (holding ?robot ?container))
      (hand-free ?robot)
      (container-at ?container ?location)
      (decrease (battery-level ?robot) (drop-energy))
      (increase (total-watering-time) (drop-time))
    )
  )

  (:action fill-container
    :parameters (?robot - robot ?container - container ?location - location)
    :precondition (and
      (at-robot ?robot ?location)
      (tap ?location)
      (holding ?robot ?container)
      (< (water-level ?container) (container-capacity ?container))
      (>= (battery-level ?robot) (fill-energy))
    )
    :effect (and
      (assign (water-level ?container) (container-capacity ?container))
      (decrease (battery-level ?robot) (fill-energy))
      (increase (total-watering-time) (fill-time))
    )
  )

  (:action water-one-unit
    :parameters
      (?robot - robot ?container - container ?plant - plant
       ?location - location)
    :precondition (and
      (at-robot ?robot ?location)
      (plant-at ?plant ?location)
      (holding ?robot ?container)
      (>= (water-level ?container) 1)
      (< (watered-amount ?plant) (plant-demand ?plant))
      (>= (battery-level ?robot) (watering-unit-energy))
    )
    :effect (and
      (decrease (water-level ?container) 1)
      (increase (watered-amount ?plant) 1)
      (decrease (battery-level ?robot) (watering-unit-energy))
      (increase (total-watering-time) (watering-unit-time))
    )
  )

  (:action charge-battery
    :parameters (?robot - robot ?location - location)
    :precondition (and
      (at-robot ?robot ?location)
      (charging-station ?location)
      (< (battery-level ?robot) (battery-capacity ?robot))
    )
    :effect (and
      (assign (battery-level ?robot) (battery-capacity ?robot))
      (increase (total-watering-time) (charge-time))
    )
  )
)
