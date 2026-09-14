(define (problem blocksworld-p003)
  (:domain blocksworld)

  (:objects
    b1 b2 b3 b4 b5 b6 b7
    table1 table2 table3
  )

  (:init
    (block b1)
    (block b2)
    (block b3)
    (block b4)
    (block b5)
    (block b6)
    (block b7)
    (table table1)
    (table table2)
    (table table3)
    (handempty)
    (on-table b2 table1)
    (on b5 b2)
    (clear b5)
    (on-table b4 table2)
    (on b1 b4)
    (on b6 b1)
    (clear b6)
    (on-table b7 table3)
    (on b3 b7)
    (clear b3)
    (= (total-cost) 0)
  )

  (:goal (and
    (handempty)
    (clear table1)
    (on-table b5 table2)
    (on b2 b5)
    (on b3 b2)
    (on b4 b3)
    (on b6 b4)
    (clear b6)
    (on-table b7 table3)
    (on b1 b7)
    (clear b1)
  ))

  (:metric minimize (total-cost))
)
