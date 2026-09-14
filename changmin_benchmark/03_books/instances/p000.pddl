(define (problem library-rearrangement-p000)
  (:domain library-books)
  (:objects
    robot1 - robot
    book001 - book
    cart1 - cart
    room1 - room
    shelf1 - shelf
    step1 - step
    slot1 - slot
    shelf-end - end-marker
  )
  (:init
    (at-robot robot1 room1)
    (hand-free robot1)
    (without-cart robot1)
    (grounded robot1)
    (staging-area room1)
    (cart-at cart1 room1)
    (step-at step1 room1)
    (book-at book001 room1)
    (shelf-at shelf1 room1)
    (assigned book001 shelf1 slot1)
    (next-to-fill shelf1 slot1)
    (successor slot1 shelf-end shelf1)
    (= (book-weight book001) 1)
    (= (book-thickness book001) 1)
    (= (cart-capacity cart1) 10)
    (= (cart-load cart1) 0)
    (= (shelf-capacity shelf1) 2)
    (= (shelf-used-space shelf1) 0)
    (= (shelf-height shelf1) 100)
    (= (current-reach robot1) 180)
    (= (step-boost step1) 10)
    (= (move-alone-time) 1)
    (= (move-cart-time) 1)
    (= (cart-handling-time) 1)
    (= (book-handling-time) 1)
    (= (shelf-handling-time) 1)
    (= (step-handling-time) 1)
    (= (total-library-time) 0)
  )
  (:goal (and
    (on-shelf book001 shelf1 slot1)
    (next-to-fill shelf1 shelf-end)
  ))
  (:metric minimize (total-library-time))
)
