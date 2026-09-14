(define (problem p0) (:domain booknew)
(:objects changmin room1 room2 room3 room4 book1 book2 book3 book4 tray1
)

(:init
(robot changmin)
(room room1)
(room room2)
(room room3)
(room room4)
(book book1)
(book book2)
(book book3)
(book book4)
(tray tray1)
;location
(at-room changmin room1)
(at book1 room2)
(at book2 room2)
(at book3 room2)
(at book4 room2)
(at tray1 room1)
;agent
(free changmin)

)

(:goal (and
(at book1 room4)
(at book2 room4)
(at book3 room4)
(at book4 room4)
)))
