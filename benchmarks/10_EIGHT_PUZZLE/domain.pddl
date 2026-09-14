(define (domain eight-puzzle)
  (:requirements :strips :typing)

  (:predicates
    (at ?t ?p)
    (empty ?p)

    (north-of ?p1 ?p2)
    (south-of ?p1 ?p2)
    (east-of  ?p1 ?p2)
    (west-of  ?p1 ?p2)
  )

  (:action move-north
    :parameters (?t ?from ?to)
    :precondition
      (and
        (at ?t ?from)
        (empty ?to)
        (north-of ?to ?from)
      )
    :effect
      (and
        (at ?t ?to)
        (empty ?from)
        (not (at ?t ?from))
        (not (empty ?to))
      )
  )

  (:action move-south
    :parameters (?t ?from ?to)
    :precondition
      (and
        (at ?t ?from)
        (empty ?to)
        (south-of ?to ?from)
      )
    :effect
      (and
        (at ?t ?to)
        (empty ?from)
        (not (at ?t ?from))
        (not (empty ?to))
      )
  )

  (:action move-east
    :parameters (?t ?from ?to)
    :precondition
      (and
        (at ?t ?from)
        (empty ?to)
        (east-of ?to ?from)
      )
    :effect
      (and
        (at ?t ?to)
        (empty ?from)
        (not (at ?t ?from))
        (not (empty ?to))
      )
  )

  (:action move-west
    :parameters (?t ?from ?to)
    :precondition
      (and
        (at ?t ?from)
        (empty ?to)
        (west-of ?to ?from)
      )
    :effect
      (and
        (at ?t ?to)
        (empty ?from)
        (not (at ?t ?from))
        (not (empty ?to))
      )
  )
)