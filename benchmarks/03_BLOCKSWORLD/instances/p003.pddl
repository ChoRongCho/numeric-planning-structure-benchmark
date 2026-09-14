(define (problem bw-3-rand-3table)
  (:domain blocksworld)

  (:objects
    b1 b2 b3
    l-table m-table r-table
  )

  (:init
    ; "유사 타입"
    (block b1) (block b2) (block b3) 
    (table l-table) (table m-table) (table r-table)

    (handempty)

    ; ----- 무작위 초기 스택 구성 -----
    (on b2 b3)
    (on-table b3 l-table)
    (clear b2)

    (on-table b1 m-table)
    (clear b1)

    (clear r-table)

  )

  (:goal
    (and
      (on b3 b2) (on b2 b1) (on-table b1 l-table) (clear b3)
      (handempty)
    )
  )
)
