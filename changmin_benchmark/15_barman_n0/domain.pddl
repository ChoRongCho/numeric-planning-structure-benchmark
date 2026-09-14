(define (domain barman-n0)
  ;; Stage N0: symbolic hands, cleaning, recipe, and shaker-level ordering only.
  (:requirements :strips :typing)

  (:types
    hand level beverage dispenser container - object
    ingredient cocktail - beverage
    shot shaker - container
  )

  (:predicates
    (ontable ?container - container)
    (holding ?hand - hand ?container - container)
    (handempty ?hand - hand)
    (empty ?container - container)
    (contains ?container - container ?beverage - beverage)
    (clean ?container - container)
    (used ?container - container ?beverage - beverage)
    (dispenses ?dispenser - dispenser ?ingredient - ingredient)
    (shaker-empty-level ?shaker - shaker ?level - level)
    (shaker-level ?shaker - shaker ?level - level)
    (next ?level1 ?level2 - level)
    (unshaked ?shaker - shaker)
    (shaked ?shaker - shaker)
    (cocktail-part1 ?cocktail - cocktail ?ingredient - ingredient)
    (cocktail-part2 ?cocktail - cocktail ?ingredient - ingredient)
  )

  (:action grasp
    :parameters (?hand - hand ?container - container)
    :precondition (and (ontable ?container) (handempty ?hand))
    :effect (and
      (not (ontable ?container))
      (not (handempty ?hand))
      (holding ?hand ?container)
    )
  )

  (:action leave
    :parameters (?hand - hand ?container - container)
    :precondition (holding ?hand ?container)
    :effect (and
      (not (holding ?hand ?container))
      (handempty ?hand)
      (ontable ?container)
    )
  )

  (:action fill-shot
    :parameters
      (?shot - shot ?ingredient - ingredient ?hand1 ?hand2 - hand
       ?dispenser - dispenser)
    :precondition (and
      (holding ?hand1 ?shot)
      (handempty ?hand2)
      (dispenses ?dispenser ?ingredient)
      (empty ?shot)
      (clean ?shot)
    )
    :effect (and
      (not (empty ?shot))
      (contains ?shot ?ingredient)
      (not (clean ?shot))
      (used ?shot ?ingredient)
    )
  )

  (:action refill-shot
    :parameters
      (?shot - shot ?ingredient - ingredient ?hand1 ?hand2 - hand
       ?dispenser - dispenser)
    :precondition (and
      (holding ?hand1 ?shot)
      (handempty ?hand2)
      (dispenses ?dispenser ?ingredient)
      (empty ?shot)
      (used ?shot ?ingredient)
    )
    :effect (and
      (not (empty ?shot))
      (contains ?shot ?ingredient)
    )
  )

  (:action empty-shot
    :parameters (?hand - hand ?shot - shot ?beverage - beverage)
    :precondition (and (holding ?hand ?shot) (contains ?shot ?beverage))
    :effect (and
      (not (contains ?shot ?beverage))
      (empty ?shot)
    )
  )

  (:action clean-shot
    :parameters
      (?shot - shot ?beverage - beverage ?hand1 ?hand2 - hand)
    :precondition (and
      (holding ?hand1 ?shot)
      (handempty ?hand2)
      (empty ?shot)
      (used ?shot ?beverage)
    )
    :effect (and
      (not (used ?shot ?beverage))
      (clean ?shot)
    )
  )

  (:action pour-shot-to-clean-shaker
    :parameters
      (?shot - shot ?ingredient - ingredient ?shaker - shaker
       ?hand - hand ?level ?next-level - level)
    :precondition (and
      (holding ?hand ?shot)
      (contains ?shot ?ingredient)
      (empty ?shaker)
      (clean ?shaker)
      (shaker-level ?shaker ?level)
      (next ?level ?next-level)
    )
    :effect (and
      (not (contains ?shot ?ingredient))
      (empty ?shot)
      (contains ?shaker ?ingredient)
      (not (empty ?shaker))
      (not (clean ?shaker))
      (unshaked ?shaker)
      (not (shaker-level ?shaker ?level))
      (shaker-level ?shaker ?next-level)
    )
  )

  (:action pour-shot-to-used-shaker
    :parameters
      (?shot - shot ?ingredient - ingredient ?shaker - shaker
       ?hand - hand ?level ?next-level - level)
    :precondition (and
      (holding ?hand ?shot)
      (contains ?shot ?ingredient)
      (unshaked ?shaker)
      (shaker-level ?shaker ?level)
      (next ?level ?next-level)
    )
    :effect (and
      (not (contains ?shot ?ingredient))
      (contains ?shaker ?ingredient)
      (empty ?shot)
      (not (shaker-level ?shaker ?level))
      (shaker-level ?shaker ?next-level)
    )
  )

  (:action shake
    :parameters
      (?cocktail - cocktail ?ingredient1 ?ingredient2 - ingredient
       ?shaker - shaker ?hand1 ?hand2 - hand)
    :precondition (and
      (holding ?hand1 ?shaker)
      (handempty ?hand2)
      (contains ?shaker ?ingredient1)
      (contains ?shaker ?ingredient2)
      (cocktail-part1 ?cocktail ?ingredient1)
      (cocktail-part2 ?cocktail ?ingredient2)
      (unshaked ?shaker)
    )
    :effect (and
      (not (unshaked ?shaker))
      (not (contains ?shaker ?ingredient1))
      (not (contains ?shaker ?ingredient2))
      (shaked ?shaker)
      (contains ?shaker ?cocktail)
    )
  )

  (:action pour-shaker-to-shot
    :parameters
      (?cocktail - cocktail ?shot - shot ?hand - hand ?shaker - shaker
       ?level ?previous-level - level)
    :precondition (and
      (holding ?hand ?shaker)
      (shaked ?shaker)
      (empty ?shot)
      (clean ?shot)
      (contains ?shaker ?cocktail)
      (shaker-level ?shaker ?level)
      (next ?previous-level ?level)
    )
    :effect (and
      (not (clean ?shot))
      (not (empty ?shot))
      (contains ?shot ?cocktail)
      (not (shaker-level ?shaker ?level))
      (shaker-level ?shaker ?previous-level)
    )
  )

  (:action empty-shaker
    :parameters
      (?hand - hand ?shaker - shaker ?cocktail - cocktail
       ?level ?empty-level - level)
    :precondition (and
      (holding ?hand ?shaker)
      (contains ?shaker ?cocktail)
      (shaked ?shaker)
      (shaker-level ?shaker ?level)
      (shaker-empty-level ?shaker ?empty-level)
    )
    :effect (and
      (not (shaked ?shaker))
      (not (shaker-level ?shaker ?level))
      (shaker-level ?shaker ?empty-level)
      (not (contains ?shaker ?cocktail))
      (empty ?shaker)
    )
  )

  (:action clean-shaker
    :parameters (?hand1 ?hand2 - hand ?shaker - shaker)
    :precondition (and
      (holding ?hand1 ?shaker)
      (handempty ?hand2)
      (empty ?shaker)
    )
    :effect (and
      (clean ?shaker)
    )
  )
)

