(define (domain railways-simple)

  (:requirements
    :strips
    :typing
    :derived-predicates
    :negative-preconditions
  )

  (:types
    train
    station
  )

  (:predicates
    ;; basic state
    (at ?t - train ?s - station)
    (has-driver ?t - train)
    (has-guard ?t - train)

    ;; derived
    (train-usable ?t - train)
  )

  ;; -----------------------------
  ;; Derived predicate
  ;; A train is usable iff it has both a driver and a guard
  ;; -----------------------------
  (:derived (train-usable ?t)
    (and
      (has-driver ?t)
      (has-guard ?t))
  )

  ;; -----------------------------
  ;; Assign driver
  ;; -----------------------------
  (:action assign-driver
    :parameters (?t - train)
    :precondition (not (has-driver ?t))
    :effect (has-driver ?t)
  )

  ;; -----------------------------
  ;; Assign guard
  ;; -----------------------------
  (:action assign-guard
    :parameters (?t - train)
    :precondition (not (has-guard ?t))
    :effect (has-guard ?t)
  )

  ;; -----------------------------
  ;; Move train (only if usable)
  ;; -----------------------------
  (:action move-train
    :parameters (?t - train ?from - station ?to - station)
    :precondition
      (and
        (at ?t ?from)
        (train-usable ?t)
      )
    :effect
      (and
        (not (at ?t ?from))
        (at ?t ?to)
      )
  )
)
