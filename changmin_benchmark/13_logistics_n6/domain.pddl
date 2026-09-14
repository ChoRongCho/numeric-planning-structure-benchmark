(define (domain logistics-n6)
  ;; Stage N6: N5 plus fill-to-capacity refuelling whose effect depends on current fuel.
  (:requirements :strips :fluents)

  (:predicates
    (package ?package)
    (truck ?truck)
    (driver ?driver)
    (place ?place)
    (at ?item ?place)
    (loaded ?package ?truck)
    (in ?driver ?truck)
    (highway ?from ?to)
    (local-road ?from ?to)
    (walkable ?from ?to)
    (fuel-station ?place)
  )

  (:functions
    (package-weight ?package)
    (truck-capacity ?truck)
    (truck-load ?truck)
    (manual-capacity ?driver)
    (fuel-level ?truck)
    (distance ?from ?to)
    (fuel-capacity ?truck)
    (refuel-amount ?truck)
    (budget)
    (toll-cost ?from ?to)
    (refuel-cost ?truck)
    (total-cost)
    (load-time)
    (unload-time)
    (board-time)
    (get-out-time)
    (highway-time ?from ?to)
    (local-road-time ?from ?to)
    (walk-time ?from ?to)
    (loaded-walk-time ?from ?to)
    (refuel-time ?truck)
    (total-delivery-time)
  )

  (:action load-truck
    :parameters (?driver ?package ?truck ?place)
    :precondition (and
      (driver ?driver) (package ?package) (truck ?truck) (place ?place)
      (at ?driver ?place) (at ?truck ?place) (at ?package ?place)
      (<= (+ (truck-load ?truck) (package-weight ?package))
          (truck-capacity ?truck))
    )
    :effect (and
      (not (at ?package ?place))
      (loaded ?package ?truck)
      (increase (truck-load ?truck) (package-weight ?package))
      (increase (total-delivery-time) (load-time))
    )
  )

  (:action unload-truck
    :parameters (?driver ?package ?truck ?place)
    :precondition (and
      (driver ?driver) (package ?package) (truck ?truck) (place ?place)
      (at ?driver ?place) (at ?truck ?place) (loaded ?package ?truck)
    )
    :effect (and
      (not (loaded ?package ?truck))
      (at ?package ?place)
      (decrease (truck-load ?truck) (package-weight ?package))
      (increase (total-delivery-time) (unload-time))
    )
  )

  (:action board-truck
    :parameters (?driver ?truck ?place)
    :precondition (and
      (driver ?driver) (truck ?truck) (place ?place)
      (at ?truck ?place) (at ?driver ?place)
    )
    :effect (and
      (not (at ?driver ?place))
      (in ?driver ?truck)
      (increase (total-delivery-time) (board-time))
    )
  )

  (:action get-out
    :parameters (?driver ?truck ?place)
    :precondition (and
      (driver ?driver) (truck ?truck) (place ?place)
      (at ?truck ?place) (in ?driver ?truck)
    )
    :effect (and
      (not (in ?driver ?truck))
      (at ?driver ?place)
      (increase (total-delivery-time) (get-out-time))
    )
  )

  (:action drive-highway
    :parameters (?driver ?truck ?from ?to)
    :precondition (and
      (driver ?driver) (truck ?truck) (place ?from) (place ?to)
      (at ?truck ?from) (in ?driver ?truck) (highway ?from ?to)
      (>= (fuel-level ?truck) (distance ?from ?to))
      (>= (budget) (toll-cost ?from ?to))
    )
    :effect (and
      (not (at ?truck ?from))
      (at ?truck ?to)
      (decrease (fuel-level ?truck) (distance ?from ?to))
      (decrease (budget) (toll-cost ?from ?to))
      (increase (total-cost) (toll-cost ?from ?to))
      (increase (total-delivery-time) (highway-time ?from ?to))
    )
  )

  (:action drive-local-road
    :parameters (?driver ?truck ?from ?to)
    :precondition (and
      (driver ?driver) (truck ?truck) (place ?from) (place ?to)
      (at ?truck ?from) (in ?driver ?truck) (local-road ?from ?to)
      (>= (fuel-level ?truck) (distance ?from ?to))
    )
    :effect (and
      (not (at ?truck ?from))
      (at ?truck ?to)
      (decrease (fuel-level ?truck) (distance ?from ?to))
      (increase (total-delivery-time) (local-road-time ?from ?to))
    )
  )

  (:action refuel-truck
    :parameters (?driver ?truck ?place)
    :precondition (and
      (driver ?driver) (truck ?truck) (place ?place)
      (fuel-station ?place) (at ?truck ?place) (in ?driver ?truck)
      (< (fuel-level ?truck) (fuel-capacity ?truck))
      (>= (budget) (- (fuel-capacity ?truck) (fuel-level ?truck)))
    )
    :effect (and
      (assign (fuel-level ?truck) (fuel-capacity ?truck))
      (decrease (budget) (- (fuel-capacity ?truck) (fuel-level ?truck)))
      (increase (total-cost) (- (fuel-capacity ?truck) (fuel-level ?truck)))
      (increase (total-delivery-time)
        (- (fuel-capacity ?truck) (fuel-level ?truck)))
    )
  )

  ;; Highway edges are walkable only when also declared as walkable.
  (:action walk-alone
    :parameters (?driver ?from ?to)
    :precondition (and
      (driver ?driver) (place ?from) (place ?to)
      (at ?driver ?from) (walkable ?from ?to)
    )
    :effect (and
      (not (at ?driver ?from))
      (at ?driver ?to)
      (increase (total-delivery-time) (walk-time ?from ?to))
    )
  )

  (:action walk-with-package
    :parameters (?driver ?package ?from ?to)
    :precondition (and
      (driver ?driver) (package ?package) (place ?from) (place ?to)
      (at ?driver ?from) (at ?package ?from) (walkable ?from ?to)
      (<= (package-weight ?package) (manual-capacity ?driver))
    )
    :effect (and
      (not (at ?driver ?from))
      (not (at ?package ?from))
      (at ?driver ?to)
      (at ?package ?to)
      (increase (total-delivery-time) (loaded-walk-time ?from ?to))
    )
  )
)

