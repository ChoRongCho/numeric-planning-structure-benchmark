(define (domain tsp-connected-numeric)
  (:requirements
    :strips
    :typing
    :negative-preconditions
    :fluents
    :action-costs
  )

  (:types
    city
    agent
  )

  (:predicates
    (at ?a - agent ?c - city)
    (visited ?c - city)
    (connected ?from - city ?to - city)
    (test-ok)
  )



  ;; ★ 중요: - number 리턴 타입을 명시
  (:functions
    (distance ?from - city ?to - city) - number
    (total-cost) - number
  )

  (:action move
    :parameters (?a - agent ?from - city ?to - city)
    :precondition
      (and
        (at ?a ?from)
        (connected ?from ?to)
      )
    :effect
      (and
        (not (at ?a ?from))
        (at ?a ?to)
        (visited ?to)
        (increase (total-cost) (distance ?from ?to))
      )
  )
)
