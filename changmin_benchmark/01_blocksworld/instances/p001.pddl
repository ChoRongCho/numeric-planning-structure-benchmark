(define (problem blocksworld-p001)
  (:domain blocksworld)

  (:objects
    b1 b2 b3
    table1 table2 table3
  )

  (:init
    (block b1)
    (block b2)
    (block b3)
    (table table1)
    (table table2)
    (table table3)
    (handempty)
    (clear table1)
    (clear table2)
    (on-table b1 table3)
    (on b2 b1)
    (on b3 b2)
    (clear b3)
    (= (total-cost) 0)
  )

  (:goal (and
    (handempty)
    (clear table1)
    (clear table2)
    (on-table b1 table3)
    (on b3 b1)
    (on b2 b3)
    (clear b2)
  ))

  (:metric minimize (total-cost))
)
