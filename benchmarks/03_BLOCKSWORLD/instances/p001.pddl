(define (problem bw-rand-50)
  (:domain blocksworld)

  (:objects
    b1 b2 b3
    l-table m-table r-table
  )

  (:init
    (block b1) (block b2) (block b3)
    (table l-table) (table m-table) (table r-table)

    (handempty)
    (on b1 b2)
    (on b2 b3)
    (on-table b3 l-table)
    (clear b1)
    (clear m-table)
    (clear r-table)
    (= (total-cost) 0)
  )

  (:goal
    (and
      (on b3 b2)
      (on b2 b1)
      (on-table b1 l-table)
      (clear b3)
    )
  )

  (:metric minimize (total-cost))
)
