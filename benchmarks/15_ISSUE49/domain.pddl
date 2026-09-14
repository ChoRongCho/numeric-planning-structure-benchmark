;; Small test domain for the problem of issue49.

(define (domain issue49)
  (:requirements :strips)
  (:predicates
   (A)
   (B)
   (C)
   )

  (:action action-a
	           :parameters ()
	           :precondition (A)
           :effect (B)
           )
)
