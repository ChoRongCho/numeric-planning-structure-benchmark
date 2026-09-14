(define (domain tsp-numeric)
  (:requirements :strips :typing :negative-preconditions :fluents :action-costs)
  (:types
    city
    agent
  )

  (:predicates
    (at ?a - agent ?c - city)     ; 에이전트 위치
    (visited ?c - city)           ; 해당 도시를 이미 방문했는지
  )

  (:functions
    (distance ?from - city ?to - city)   ; 도시 간 거리 (비용)
    (total-cost)                         ; 누적 비용 (플래너가 최소화)
  )

  (:action move
    :parameters (?a - agent ?from - city ?to - city)
    :precondition
      (and
        (at ?a ?from)
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
