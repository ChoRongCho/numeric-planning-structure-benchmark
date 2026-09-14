(define (problem bw-9-rand-3table)
  (:domain blocksworld)

  (:objects
    b1 b2 b3 b4 b5 b6 b7 b8 b9
    l-table m-table r-table
  )

  (:init
    ; "유사 타입"
    (block b1) (block b2) (block b3) (block b4) (block b5)
    (block b6) (block b7) (block b8) (block b9)
    (table l-table) (table m-table) (table r-table)

    (handempty)

    ; ----- 무작위 초기 스택 구성 -----
    ; Stack L: b2 on b5 (base=b5 on l-table)
    (on b2 b5)
    (on-table b5 l-table)
    (clear b2)

    ; Stack M: b9 on b7 on b3 (base=b3 on m-table)
    (on b9 b7)
    (on b7 b3)
    (on-table b3 m-table)
    (clear b9)

    ; Stack R: b6 on b4 on b8 on b1 (base=b1 on r-table)
    (on b6 b4)
    (on b4 b8)
    (on b8 b1)
    (on-table b1 r-table)
    (clear b6)

    ; 점유된 테이블은 clear 아님, 빈 자리는 (clear ?table)로 표시
    ; 현재는 l/m/r 모두 점유되어 있으므로 테이블 clear는 없음
  )

  (:goal
    (and
      ; 목표: (1-2-3 on l-table), (4-5-6 on m-table), (7-8-9 on r-table)
      (on b1 b2) (on b2 b3) (on-table b3 l-table) (clear b1)
      (on b4 b5) (on b5 b6) (on-table b6 m-table) (clear b4)
      (on b7 b8) (on b8 b9) (on-table b9 r-table) (clear b7)
      (handempty)
      ; (clear r-table)
      ; (clear m-table)
    )
  )
)
