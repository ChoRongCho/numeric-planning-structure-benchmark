(define (domain barman-n7)
  ;; Stage N7: full N1-N6 schema; tight resource slack is configured in problem instances.
  (:requirements :strips :typing :fluents)

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
    (restock-enabled ?dispenser - dispenser)
  )

  (:functions
    (container-capacity ?container - container)
    (liquid-volume ?container - container)
    (dispense-amount ?dispenser - dispenser)
    (dispenser-stock ?dispenser - dispenser)
    (stock-capacity ?dispenser - dispenser)
    (restock-amount ?dispenser - dispenser)
    (restock-time ?dispenser - dispenser)
    (service-budget)
    (dispense-cost ?dispenser - dispenser)
    (restock-cost ?dispenser - dispenser)
    (batch-setup-cost ?shaker - shaker)
    (total-cost)
    (grasp-time)
    (leave-time)
    (fill-time)
    (refill-time)
    (pour-time)
    (empty-time)
    (clean-shot-time)
    (clean-shaker-time)
    (shake-time)
    (total-barman-time)
  )

  (:action grasp
    :parameters (?hand - hand ?container - container)
    :precondition (and (ontable ?container) (handempty ?hand))
    :effect (and
      (not (ontable ?container))
      (not (handempty ?hand))
      (holding ?hand ?container)
      (increase (total-barman-time) (grasp-time))
    )
  )

  (:action leave
    :parameters (?hand - hand ?container - container)
    :precondition (holding ?hand ?container)
    :effect (and
      (not (holding ?hand ?container))
      (handempty ?hand)
      (ontable ?container)
      (increase (total-barman-time) (leave-time))
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
      (>= (container-capacity ?shot) (dispense-amount ?dispenser))
      (>= (dispenser-stock ?dispenser) (dispense-amount ?dispenser))
      (>= (service-budget) (dispense-cost ?dispenser))
    )
    :effect (and
      (not (empty ?shot))
      (contains ?shot ?ingredient)
      (not (clean ?shot))
      (used ?shot ?ingredient)
      (assign (liquid-volume ?shot) (dispense-amount ?dispenser))
      (decrease (dispenser-stock ?dispenser) (dispense-amount ?dispenser))
      (decrease (service-budget) (dispense-cost ?dispenser))
      (increase (total-cost) (dispense-cost ?dispenser))
      (increase (total-barman-time) (fill-time))
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
      (>= (container-capacity ?shot) (dispense-amount ?dispenser))
      (>= (dispenser-stock ?dispenser) (dispense-amount ?dispenser))
      (>= (service-budget) (dispense-cost ?dispenser))
    )
    :effect (and
      (not (empty ?shot))
      (contains ?shot ?ingredient)
      (assign (liquid-volume ?shot) (dispense-amount ?dispenser))
      (decrease (dispenser-stock ?dispenser) (dispense-amount ?dispenser))
      (decrease (service-budget) (dispense-cost ?dispenser))
      (increase (total-cost) (dispense-cost ?dispenser))
      (increase (total-barman-time) (refill-time))
    )
  )

  ;; The transferred amount is the current capacity gap. N6 instances can
  ;; choose a dispense amount smaller than shot capacity, forcing this action.
  (:action top-up-shot
    :parameters
      (?shot - shot ?ingredient - ingredient ?hand1 ?hand2 - hand
       ?dispenser - dispenser)
    :precondition (and
      (holding ?hand1 ?shot)
      (handempty ?hand2)
      (dispenses ?dispenser ?ingredient)
      (contains ?shot ?ingredient)
      (used ?shot ?ingredient)
      (< (liquid-volume ?shot) (container-capacity ?shot))
      (>= (dispenser-stock ?dispenser)
          (- (container-capacity ?shot) (liquid-volume ?shot)))
      (>= (service-budget)
          (- (container-capacity ?shot) (liquid-volume ?shot)))
    )
    :effect (and
      (decrease (dispenser-stock ?dispenser)
        (- (container-capacity ?shot) (liquid-volume ?shot)))
      (decrease (service-budget)
        (- (container-capacity ?shot) (liquid-volume ?shot)))
      (increase (total-cost)
        (- (container-capacity ?shot) (liquid-volume ?shot)))
      (increase (total-barman-time)
        (- (container-capacity ?shot) (liquid-volume ?shot)))
      (assign (liquid-volume ?shot) (container-capacity ?shot))
    )
  )

  (:action empty-shot
    :parameters (?hand - hand ?shot - shot ?beverage - beverage)
    :precondition (and (holding ?hand ?shot) (contains ?shot ?beverage))
    :effect (and
      (not (contains ?shot ?beverage))
      (empty ?shot)
      (assign (liquid-volume ?shot) 0)
      (increase (total-barman-time) (empty-time))
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
      (increase (total-barman-time) (clean-shot-time))
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
      (<= (+ (liquid-volume ?shaker) (liquid-volume ?shot))
          (container-capacity ?shaker))
      (= (liquid-volume ?shot) (container-capacity ?shot))
      (>= (service-budget) (batch-setup-cost ?shaker))
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
      (increase (liquid-volume ?shaker) (liquid-volume ?shot))
      (assign (liquid-volume ?shot) 0)
      (decrease (service-budget) (batch-setup-cost ?shaker))
      (increase (total-cost) (batch-setup-cost ?shaker))
      (increase (total-barman-time) (pour-time))
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
      (<= (+ (liquid-volume ?shaker) (liquid-volume ?shot))
          (container-capacity ?shaker))
      (= (liquid-volume ?shot) (container-capacity ?shot))
    )
    :effect (and
      (not (contains ?shot ?ingredient))
      (contains ?shaker ?ingredient)
      (empty ?shot)
      (not (shaker-level ?shaker ?level))
      (shaker-level ?shaker ?next-level)
      (increase (liquid-volume ?shaker) (liquid-volume ?shot))
      (assign (liquid-volume ?shot) 0)
      (increase (total-barman-time) (pour-time))
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
      (increase (total-barman-time) (shake-time))
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
      (>= (liquid-volume ?shaker) (container-capacity ?shot))
    )
    :effect (and
      (not (clean ?shot))
      (not (empty ?shot))
      (contains ?shot ?cocktail)
      (not (shaker-level ?shaker ?level))
      (shaker-level ?shaker ?previous-level)
      (assign (liquid-volume ?shot) (container-capacity ?shot))
      (decrease (liquid-volume ?shaker) (container-capacity ?shot))
      (increase (total-barman-time) (pour-time))
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
      (assign (liquid-volume ?shaker) 0)
      (increase (total-barman-time) (empty-time))
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
      (increase (total-barman-time) (clean-shaker-time))
    )
  )

  (:action restock-dispenser
    :parameters (?dispenser - dispenser)
    :precondition (and
      (restock-enabled ?dispenser)
      (<= (+ (dispenser-stock ?dispenser) (restock-amount ?dispenser))
          (stock-capacity ?dispenser))
      (>= (service-budget) (restock-cost ?dispenser))
    )
    :effect (and
      (increase (dispenser-stock ?dispenser) (restock-amount ?dispenser))
      (decrease (service-budget) (restock-cost ?dispenser))
      (increase (total-cost) (restock-cost ?dispenser))
      (increase (total-barman-time) (restock-time ?dispenser))
    )
  )
)

