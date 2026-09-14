;; Small test domain for the problem of issue49.

(define (domain test1)
  (:requirements :strips)
  (:predicates
   
   (place ?p)
   (item ?i)
   (ready)
   (at ?place)
   (handempty)
   (holdingKey ?item)
   (holdingCup ?item)
   (holdingCat ?item)
   (perfect)
   )

  (:action action-ready
  :parameters (?place)
           :precondition (and (at ?place)(place ?place))
           :effect (
            and (ready) (handempty)
           )
)

    (:action hold-Cat
        :parameters (?place ?item)
        :precondition (and 
            (ready)
            (place ?place)
            (at ?place)
            (item ?item)
            ; (handempty)
        )
        :effect (and 
            (not (handempty))
            (holdingCat ?item)
        )
    )
    (:action hold-Key
        :parameters (?place ?item)
        :precondition (and 
            (place ?place)
            (ready)
            (at ?place)
            (item ?item)
            ; (handempty)
        )
        :effect (and 
            (not (handempty))
            (holdingKey ?item)
        )
    )
    (:action hold-Cup
        :parameters (?place ?item)
        :precondition (and 
            (ready)
            (place ?place)
            (at ?place)
            (item ?item)
            ; (handempty)
        )
        :effect (and 
            (not (handempty))
            (holdingCup ?item)
        )
    )
    (:action get-all
        :parameters (?key ?cup ?cat)
        :precondition (and 
            (item ?key)
            (item ?cup)
            (item ?cat)
            (holdingCup ?cup)
            (holdingKey ?key)
            (holdingCat ?cat)
        )
        :effect (and (perfect))
    )
    
)
