(define (domain delayed-conflict-deep-low)
  (:requirements :strips :fluents)
  (:constants root good-1 good-2 good-3 good-4 good-5 good-6 good-7 good-8 bad-1-0-0 bad-2-0-0 bad-3-0-0 bad-4-0-0 bad-5-0-0 bad-6-0-0)
  (:predicates (at ?n) (done))
  (:functions (fuel) (total-cost))
  (:action z-good-1
    :parameters ()
    :precondition (and (at root))
    :effect (and (not (at root)) (at good-1) (increase (total-cost) 1)))

  (:action z-good-2
    :parameters ()
    :precondition (and (at good-1))
    :effect (and (not (at good-1)) (at good-2) (increase (total-cost) 1)))

  (:action z-good-3
    :parameters ()
    :precondition (and (at good-2))
    :effect (and (not (at good-2)) (at good-3) (increase (total-cost) 1)))

  (:action z-good-4
    :parameters ()
    :precondition (and (at good-3))
    :effect (and (not (at good-3)) (at good-4) (increase (total-cost) 1)))

  (:action z-good-5
    :parameters ()
    :precondition (and (at good-4))
    :effect (and (not (at good-4)) (at good-5) (increase (total-cost) 1)))

  (:action z-good-6
    :parameters ()
    :precondition (and (at good-5))
    :effect (and (not (at good-5)) (at good-6) (increase (total-cost) 1)))

  (:action z-good-7
    :parameters ()
    :precondition (and (at good-6))
    :effect (and (not (at good-6)) (at good-7) (increase (total-cost) 1)))

  (:action z-good-8
    :parameters ()
    :precondition (and (at good-7))
    :effect (and (not (at good-7)) (at good-8) (increase (total-cost) 1)))

  (:action a-bad-1-0-0
    :parameters ()
    :precondition (and (at root))
    :effect (and (not (at root)) (at bad-1-0-0) (increase (total-cost) 1)))

  (:action a-bad-2-0-0
    :parameters ()
    :precondition (and (at bad-1-0-0))
    :effect (and (not (at bad-1-0-0)) (at bad-2-0-0) (increase (total-cost) 1)))

  (:action a-bad-3-0-0
    :parameters ()
    :precondition (and (at bad-2-0-0))
    :effect (and (not (at bad-2-0-0)) (at bad-3-0-0) (increase (total-cost) 1)))

  (:action a-bad-4-0-0
    :parameters ()
    :precondition (and (at bad-3-0-0) (>= (fuel) 1))
    :effect (and (not (at bad-3-0-0)) (at bad-4-0-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-5-0-0
    :parameters ()
    :precondition (and (at bad-4-0-0) (>= (fuel) 1))
    :effect (and (not (at bad-4-0-0)) (at bad-5-0-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action a-bad-6-0-0
    :parameters ()
    :precondition (and (at bad-5-0-0) (>= (fuel) 1))
    :effect (and (not (at bad-5-0-0)) (at bad-6-0-0) (decrease (fuel) 1) (increase (total-cost) 1)))

  (:action finish-0
    :parameters ()
    :precondition (at bad-6-0-0)
    :effect (and (done) (increase (total-cost) 1)))
  (:action finish-1
    :parameters ()
    :precondition (at good-8)
    :effect (and (done) (increase (total-cost) 1)))
)
