(define (problem railways-p3)
  (:domain railways-simple)

  (:objects
    t1 t2 t3 - train
    s1 s2 s3 - station
  )

  (:init
    (at t1 s1)
    (at t2 s1)
    (at t3 s1)

  )

  (:goal
    (and
      (at t1 s2)
      (at t2 s3)
      (at t3 s2)
    )
  )
)
