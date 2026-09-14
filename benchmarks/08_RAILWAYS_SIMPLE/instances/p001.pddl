(define (problem railways-p1)
  (:domain railways-simple)

  (:objects
    t1 t2 t3 - train
    s1 s2 s3 - station
  )

  (:init
    (at t1 s1)
    (at t2 s1)
    (at t3 s1)
    ;; 처음엔 승무원이 없어서 train-usable(t1)는 derived로 false
  )

  (:goal
  (and
    (at t1 s2)
    (at t2 s3)
    (at t3 s2)
  ))
)
