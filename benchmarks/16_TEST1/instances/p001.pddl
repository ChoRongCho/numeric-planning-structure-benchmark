(define (problem test1) (:domain test1)
(:objects 
    place1 ;- place
    key cat cup ;- item
)

(:init
    (place place1)
    (item key)
    (item cup)
    (item cat)

    (at place1)
)

(:goal (and
    (perfect)
))

;un-comment the following line if metric is needed
;(:metric minimize (???))
)
