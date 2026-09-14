(define (domain numeric-robot-assembly)
  (:requirements :strips :typing :fluents)

  (:types robot part product tool)

  (:predicates
    (part-available ?part - part)
    (holding-part ?robot - robot ?part - part)
    (handempty ?robot - robot)
    (tool-slot-empty ?robot - robot)
    (tool-available ?tool - tool)
    (tool-mounted ?robot - robot ?tool - tool)
    (part-of ?part - part ?product - product)
    (first-part ?part - part ?product - product)
    (predecessor ?previous ?part - part ?product - product)
    (placed ?part - part ?product - product)
    (unfinished ?part - part)
    (fastened ?part - part ?product - product)
    (compatible ?tool - tool ?part - part)
  )

  (:functions
    ;; Static physical properties and dynamic fastening progress.
    (part-weight ?part - part)
    (robot-payload ?robot - robot)
    (required-work ?part - part)
    (completed-work ?part - part)
    (tool-work-step ?tool - tool)

    ;; Static execution times and accumulated objective.
    (pick-time ?part - part)
    (place-time ?part - part)
    (tool-change-time ?tool - tool)
    (tool-operation-time ?tool - tool)
    (inspection-time)
    (total-assembly-time)
  )

  (:action pick-part
    :parameters (?robot - robot ?part - part)
    :precondition (and
      (part-available ?part)
      (handempty ?robot)
      (tool-slot-empty ?robot)
      (<= (part-weight ?part) (robot-payload ?robot))
    )
    :effect (and
      (not (part-available ?part))
      (not (handempty ?robot))
      (holding-part ?robot ?part)
      (increase (total-assembly-time) (pick-time ?part))
    )
  )

  (:action place-first-part
    :parameters (?robot - robot ?part - part ?product - product)
    :precondition (and
      (holding-part ?robot ?part)
      (part-of ?part ?product)
      (first-part ?part ?product)
    )
    :effect (and
      (not (holding-part ?robot ?part))
      (handempty ?robot)
      (placed ?part ?product)
      (increase (total-assembly-time) (place-time ?part))
    )
  )

  (:action place-after-predecessor
    :parameters
      (?robot - robot ?part ?previous - part ?product - product)
    :precondition (and
      (holding-part ?robot ?part)
      (part-of ?part ?product)
      (predecessor ?previous ?part ?product)
      (fastened ?previous ?product)
    )
    :effect (and
      (not (holding-part ?robot ?part))
      (handempty ?robot)
      (placed ?part ?product)
      (increase (total-assembly-time) (place-time ?part))
    )
  )

  (:action mount-tool
    :parameters (?robot - robot ?tool - tool)
    :precondition (and
      (handempty ?robot)
      (tool-slot-empty ?robot)
      (tool-available ?tool)
    )
    :effect (and
      (not (tool-slot-empty ?robot))
      (not (tool-available ?tool))
      (tool-mounted ?robot ?tool)
      (increase (total-assembly-time) (tool-change-time ?tool))
    )
  )

  (:action unmount-tool
    :parameters (?robot - robot ?tool - tool)
    :precondition (and
      (handempty ?robot)
      (tool-mounted ?robot ?tool)
    )
    :effect (and
      (not (tool-mounted ?robot ?tool))
      (tool-slot-empty ?robot)
      (tool-available ?tool)
      (increase (total-assembly-time) (tool-change-time ?tool))
    )
  )

  (:action perform-fastening-step
    :parameters
      (?robot - robot ?tool - tool ?part - part ?product - product)
    :precondition (and
      (handempty ?robot)
      (tool-mounted ?robot ?tool)
      (compatible ?tool ?part)
      (placed ?part ?product)
      (part-of ?part ?product)
      (unfinished ?part)
      (<= (+ (completed-work ?part) (tool-work-step ?tool))
          (required-work ?part))
    )
    :effect (and
      (increase (completed-work ?part) (tool-work-step ?tool))
      (increase (total-assembly-time) (tool-operation-time ?tool))
    )
  )

  (:action inspect-and-finish
    :parameters (?part - part ?product - product)
    :precondition (and
      (placed ?part ?product)
      (part-of ?part ?product)
      (unfinished ?part)
      (= (completed-work ?part) (required-work ?part))
    )
    :effect (and
      (not (unfinished ?part))
      (fastened ?part ?product)
      (increase (total-assembly-time) (inspection-time))
    )
  )
)
