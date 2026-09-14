(define (domain logistics-n0)
  ;; Stage N0: symbolic predicates and action ordering only.
  (:requirements :strips)

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
  )

  (:action load-truck
    :parameters (?driver ?package ?truck ?place)
    :precondition (and
      (driver ?driver) (package ?package) (truck ?truck) (place ?place)
      (at ?driver ?place) (at ?truck ?place) (at ?package ?place)
    )
    :effect (and
      (not (at ?package ?place))
      (loaded ?package ?truck)
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
    )
  )

  (:action drive-highway
    :parameters (?driver ?truck ?from ?to)
    :precondition (and
      (driver ?driver) (truck ?truck) (place ?from) (place ?to)
      (at ?truck ?from) (in ?driver ?truck) (highway ?from ?to)
    )
    :effect (and
      (not (at ?truck ?from))
      (at ?truck ?to)
    )
  )

  (:action drive-local-road
    :parameters (?driver ?truck ?from ?to)
    :precondition (and
      (driver ?driver) (truck ?truck) (place ?from) (place ?to)
      (at ?truck ?from) (in ?driver ?truck) (local-road ?from ?to)
    )
    :effect (and
      (not (at ?truck ?from))
      (at ?truck ?to)
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
    )
  )

  (:action walk-with-package
    :parameters (?driver ?package ?from ?to)
    :precondition (and
      (driver ?driver) (package ?package) (place ?from) (place ?to)
      (at ?driver ?from) (at ?package ?from) (walkable ?from ?to)
    )
    :effect (and
      (not (at ?driver ?from))
      (not (at ?package ?from))
      (at ?driver ?to)
      (at ?package ?to)
    )
  )
)

