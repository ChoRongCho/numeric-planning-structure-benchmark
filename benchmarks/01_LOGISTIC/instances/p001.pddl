(define (problem amazon) (:domain logistic)
(:objects 
    changmin 
    truck1 truck2 truck3 
    pack1 pack2 pack3
    te805a cy301 cy303 sogang hub1 harbor home
)

(:init
    (driver changmin)
    (truck truck1)
    (truck truck2)
    (truck truck3)
    (package pack1)
    (package pack2)
    (package pack3)
    ; place
    (place te805a)
    (place cy301)
    (place cy303)
    (place sogang)
    (place hub1)
    (place harbor)
    (place home)
    ; position
    (at changmin home)
    (at truck1 harbor) ; solvable
    ; (at truck1 te805a) ; unsolvable
    (at truck2 te805a)
    (at truck3 sogang)
    
    (at pack1 harbor)
    (at pack2 sogang)
    (at pack3 te805a)

    ; connectivity // no truck
    (path te805a cy301)
    (path te805a cy303)
    (path cy301 te805a)
    (path cy301 cy303)
    (path cy303 te805a)
    (path cy303 cy301)
    (path sogang te805a)
    (path te805a sogang)
    (path home harbor)
    (path harbor home)

    ; road
    (link sogang hub1)
    (link hub1 sogang)
    (link harbor hub1)
    (link hub1 harbor)
    (link home harbor)
    (link harbor home)

    (= (total-cost) 0)
)

(:goal (and
    (at pack1 cy301)
    (at pack2 cy301)
    (at pack3 cy301)
))

(:metric minimize (total-cost))
)
