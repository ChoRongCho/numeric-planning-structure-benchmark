(define (problem eight-puzzle-prob1)
  (:domain eight-puzzle)

  (:objects
    t1 t2 t3 t4 t5 t6 t7 t8
    p1 p2 p3 p4 p5 p6 p7 p8 p9
  )

  (:init
    ;; 현재 상태
    (at t1 p1)
    (at t2 p2)
    (at t3 p3)
    (at t7 p4)
    (empty p5)
    (at t4 p6)
    (at t8 p7)
    (at t6 p8)
    (at t5 p9)
    

    ;; 세로 인접관계
    (north-of p1 p4)
    (north-of p2 p5)
    (north-of p3 p6)
    (north-of p4 p7)
    (north-of p5 p8)
    (north-of p6 p9)

    (south-of p4 p1)
    (south-of p5 p2)
    (south-of p6 p3)
    (south-of p7 p4)
    (south-of p8 p5)
    (south-of p9 p6)

    ;; 가로 인접관계
    (east-of p2 p1)
    (east-of p3 p2)
    (east-of p5 p4)
    (east-of p6 p5)
    (east-of p8 p7)
    (east-of p9 p8)

    (west-of p1 p2)
    (west-of p2 p3)
    (west-of p4 p5)
    (west-of p5 p6)
    (west-of p7 p8)
    (west-of p8 p9)
  )

  (:goal
    (and
      (at t1 p1)
      (at t2 p2)
      (at t3 p3)
      (at t4 p4)
      (at t5 p5)
      (at t6 p6)
      (at t7 p7)
      (at t8 p8)
      (empty p9)
    )
  )
)