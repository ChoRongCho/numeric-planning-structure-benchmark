(define (domain temporal-smoke)
  (:requirements :strips :durative-actions)
  (:predicates (ready) (done))
  (:durative-action finish
    :parameters ()
    :duration (= ?duration 1)
    :condition (and (at start (ready)))
    :effect (and (at end (done))))
)
