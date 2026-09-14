(define (domain library-books)
  (:requirements :strips :typing :fluents)

  (:types
    robot book cart room shelf step - object
    position - object
    slot end-marker - position
  )

  (:predicates
    (connected ?from ?to - room)
    (at-robot ?robot - robot ?room - room)
    (book-at ?book - book ?room - room)
    (cart-at ?cart - cart ?room - room)
    (shelf-at ?shelf - shelf ?room - room)
    (step-at ?step - step ?room - room)
    (staging-area ?room - room)

    (hand-free ?robot - robot)
    (carrying-book ?robot - robot ?book - book)
    (without-cart ?robot - robot)
    (cart-attached ?robot - robot ?cart - cart)
    (on-cart ?book - book ?cart - cart)

    (grounded ?robot - robot)
    (step-ready ?step - step)
    (using-step ?robot - robot ?step - step)

    (on-shelf ?book - book ?shelf - shelf ?slot - slot)
    (assigned ?book - book ?shelf - shelf ?slot - slot)
    (successor ?slot - slot ?next - position ?shelf - shelf)
    (next-to-fill ?shelf - shelf ?position - position)
  )

  (:functions
    ;; Static physical properties.
    (book-weight ?book - book)
    (book-thickness ?book - book)
    (cart-capacity ?cart - cart)
    (shelf-capacity ?shelf - shelf)
    (shelf-height ?shelf - shelf)
    (step-boost ?step - step)

    ;; Reversible occupancy/configuration state; nothing is consumed.
    (cart-load ?cart - cart)
    (shelf-used-space ?shelf - shelf)
    (current-reach ?robot - robot)

    ;; Static action durations and the accumulated optimization objective.
    (move-alone-time)
    (move-cart-time)
    (cart-handling-time)
    (book-handling-time)
    (shelf-handling-time)
    (step-handling-time)
    (total-library-time)
  )

  (:action move-alone
    :parameters (?robot - robot ?from ?to - room)
    :precondition (and
      (at-robot ?robot ?from)
      (connected ?from ?to)
      (without-cart ?robot)
      (hand-free ?robot)
      (grounded ?robot)
    )
    :effect (and
      (not (at-robot ?robot ?from))
      (at-robot ?robot ?to)
      (increase (total-library-time) (move-alone-time))
    )
  )

  (:action move-with-cart
    :parameters (?robot - robot ?cart - cart ?from ?to - room)
    :precondition (and
      (at-robot ?robot ?from)
      (connected ?from ?to)
      (cart-attached ?robot ?cart)
      (hand-free ?robot)
      (grounded ?robot)
    )
    :effect (and
      (not (at-robot ?robot ?from))
      (at-robot ?robot ?to)
      (increase (total-library-time) (move-cart-time))
    )
  )

  (:action attach-cart
    :parameters (?robot - robot ?cart - cart ?room - room)
    :precondition (and
      (at-robot ?robot ?room)
      (cart-at ?cart ?room)
      (without-cart ?robot)
      (hand-free ?robot)
      (grounded ?robot)
    )
    :effect (and
      (not (cart-at ?cart ?room))
      (not (without-cart ?robot))
      (cart-attached ?robot ?cart)
      (increase (total-library-time) (cart-handling-time))
    )
  )

  (:action detach-cart
    :parameters (?robot - robot ?cart - cart ?room - room)
    :precondition (and
      (at-robot ?robot ?room)
      (cart-attached ?robot ?cart)
      (hand-free ?robot)
      (grounded ?robot)
      (= (cart-load ?cart) 0)
    )
    :effect (and
      (not (cart-attached ?robot ?cart))
      (cart-at ?cart ?room)
      (without-cart ?robot)
      (increase (total-library-time) (cart-handling-time))
    )
  )

  (:action pick-book-from-room
    :parameters (?robot - robot ?book - book ?room - room)
    :precondition (and
      (at-robot ?robot ?room)
      (book-at ?book ?room)
      (hand-free ?robot)
    )
    :effect (and
      (not (book-at ?book ?room))
      (not (hand-free ?robot))
      (carrying-book ?robot ?book)
      (increase (total-library-time) (book-handling-time))
    )
  )

  (:action put-book-in-staging
    :parameters (?robot - robot ?book - book ?room - room)
    :precondition (and
      (at-robot ?robot ?room)
      (staging-area ?room)
      (carrying-book ?robot ?book)
    )
    :effect (and
      (not (carrying-book ?robot ?book))
      (hand-free ?robot)
      (book-at ?book ?room)
      (increase (total-library-time) (book-handling-time))
    )
  )

  (:action put-book-on-cart
    :parameters (?robot - robot ?book - book ?cart - cart)
    :precondition (and
      (cart-attached ?robot ?cart)
      (carrying-book ?robot ?book)
      (<= (+ (cart-load ?cart) (book-weight ?book))
          (cart-capacity ?cart))
    )
    :effect (and
      (not (carrying-book ?robot ?book))
      (hand-free ?robot)
      (on-cart ?book ?cart)
      (increase (cart-load ?cart) (book-weight ?book))
      (increase (total-library-time) (book-handling-time))
    )
  )

  (:action take-book-from-cart
    :parameters (?robot - robot ?book - book ?cart - cart)
    :precondition (and
      (cart-attached ?robot ?cart)
      (on-cart ?book ?cart)
      (hand-free ?robot)
    )
    :effect (and
      (not (on-cart ?book ?cart))
      (not (hand-free ?robot))
      (carrying-book ?robot ?book)
      (decrease (cart-load ?cart) (book-weight ?book))
      (increase (total-library-time) (book-handling-time))
    )
  )

  ;; Only the next slot in the shelf sequence may be filled.
  (:action place-book-on-shelf
    :parameters (
      ?robot - robot
      ?book - book
      ?shelf - shelf
      ?slot - slot
      ?next - position
      ?room - room
    )
    :precondition (and
      (at-robot ?robot ?room)
      (shelf-at ?shelf ?room)
      (carrying-book ?robot ?book)
      (assigned ?book ?shelf ?slot)
      (next-to-fill ?shelf ?slot)
      (successor ?slot ?next ?shelf)
      (>= (current-reach ?robot) (shelf-height ?shelf))
      (<= (+ (shelf-used-space ?shelf) (book-thickness ?book))
          (shelf-capacity ?shelf))
    )
    :effect (and
      (not (carrying-book ?robot ?book))
      (hand-free ?robot)
      (on-shelf ?book ?shelf ?slot)
      (not (next-to-fill ?shelf ?slot))
      (next-to-fill ?shelf ?next)
      (increase (shelf-used-space ?shelf) (book-thickness ?book))
      (increase (total-library-time) (shelf-handling-time))
    )
  )

  ;; Only the rightmost/last inserted book can be removed. Removing it rewinds
  ;; next-to-fill, which makes temporary removal and later restoration explicit.
  (:action remove-book-from-shelf
    :parameters (
      ?robot - robot
      ?book - book
      ?shelf - shelf
      ?slot - slot
      ?next - position
      ?room - room
    )
    :precondition (and
      (at-robot ?robot ?room)
      (shelf-at ?shelf ?room)
      (hand-free ?robot)
      (on-shelf ?book ?shelf ?slot)
      (next-to-fill ?shelf ?next)
      (successor ?slot ?next ?shelf)
      (>= (current-reach ?robot) (shelf-height ?shelf))
    )
    :effect (and
      (not (hand-free ?robot))
      (carrying-book ?robot ?book)
      (not (on-shelf ?book ?shelf ?slot))
      (not (next-to-fill ?shelf ?next))
      (next-to-fill ?shelf ?slot)
      (decrease (shelf-used-space ?shelf) (book-thickness ?book))
      (increase (total-library-time) (shelf-handling-time))
    )
  )

  (:action deploy-step
    :parameters (?robot - robot ?step - step ?room - room)
    :precondition (and
      (at-robot ?robot ?room)
      (step-at ?step ?room)
      (step-ready ?step)
      (hand-free ?robot)
      (grounded ?robot)
    )
    :effect (and
      (not (step-ready ?step))
      (not (grounded ?robot))
      (using-step ?robot ?step)
      (increase (current-reach ?robot) (step-boost ?step))
      (increase (total-library-time) (step-handling-time))
    )
  )

  (:action retract-step
    :parameters (?robot - robot ?step - step ?room - room)
    :precondition (and
      (at-robot ?robot ?room)
      (step-at ?step ?room)
      (using-step ?robot ?step)
      (hand-free ?robot)
    )
    :effect (and
      (not (using-step ?robot ?step))
      (step-ready ?step)
      (grounded ?robot)
      (decrease (current-reach ?robot) (step-boost ?step))
      (increase (total-library-time) (step-handling-time))
    )
  )
)
