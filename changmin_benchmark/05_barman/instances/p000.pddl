(define (problem numeric-barman-p000)
  (:domain numeric-barman)
  (:objects
    left right - hand
    level0 level1 - level
    ingredient1 - ingredient
    cocktail1 - cocktail
    dispenser1 - dispenser
    shot1 - shot
    shaker1 - shaker
  )
  (:init
    (handempty left)
    (handempty right)
    (next level0 level1)
    (ontable shot1)
    (empty shot1)
    (clean shot1)
    (dispenses dispenser1 ingredient1)
    (= (container-capacity shot1) 50)
    (= (liquid-volume shot1) 0)
    (= (dispense-amount dispenser1) 50)
    (= (dispenser-stock dispenser1) 50)
    (ontable shaker1)
    (empty shaker1)
    (clean shaker1)
    (shaker-empty-level shaker1 level0)
    (shaker-level shaker1 level0)
    (= (container-capacity shaker1) 100)
    (= (liquid-volume shaker1) 0)
    (cocktail-part1 cocktail1 ingredient1)
    (cocktail-part2 cocktail1 ingredient1)
    (= (grasp-time) 1)
    (= (leave-time) 1)
    (= (fill-time) 1)
    (= (refill-time) 1)
    (= (pour-time) 1)
    (= (empty-time) 1)
    (= (clean-shot-time) 1)
    (= (clean-shaker-time) 1)
    (= (shake-time) 1)
    (= (total-barman-time) 0)
  )
  (:goal (and
    (contains shot1 ingredient1)
    (ontable shot1)
    (handempty left)
    (handempty right)
  ))
  (:metric minimize (total-barman-time))
)
