(define (problem blocksworld-p002)
  (:domain blocksworld)

  (:objects
    b1 b2 b3 b4 b5
    table1 table2 table3
  )

  (:init
    (block b1)
    (block b2)
    (block b3)
    (block b4)
    (block b5)
    (table table1)
    (table table2)
    (table table3)
    (handempty)
    (on-table b5 table1)
    (on b1 b5)
    (clear b1)
    (on-table b2 table2)
    (on b4 b2)
    (on b3 b4)
    (clear b3)
    (clear table3)
    (= (total-cost) 0)
  )

  (:goal (and
    (handempty)
    (on-table b1 table1)
    (clear b1)
    (clear table2)
    (on-table b5 table3)
    (on b2 b5)
    (on b4 b2)
    (on b3 b4)
    (clear b3)
  ))

  (:metric minimize (total-cost))
)
