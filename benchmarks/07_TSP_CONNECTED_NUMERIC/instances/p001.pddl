(define (problem tsp-14nodes-2x7-grid)
  (:domain tsp-connected-numeric)

  (:objects
    agent1 - agent
    c1 c2 c3 c4 c5 c6 c7
    c8 c9 c10 c11 c12 c13 c14 - city
  )

  (:init
    ;; 초기 위치 및 방문 상태
    (at agent1 c1)
    (visited c1)
    (= (total-cost) 0)

    ;; =========================
    ;; 인접 관계 (connected)
    ;; =========================

    ;; 윗줄: c1 - c2 - c3 - c4 - c5 - c6 - c7
    (connected c1 c2) (connected c2 c1)
    (connected c2 c3) (connected c3 c2)
    (connected c3 c4) (connected c4 c3)
    (connected c4 c5) (connected c5 c4)
    (connected c5 c6) (connected c6 c5)
    (connected c6 c7) (connected c7 c6)

    ;; 아랫줄: c8 - c9 - c10 - c11 - c12 - c13 - c14
    (connected c8 c9)   (connected c9 c8)
    (connected c9 c10)  (connected c10 c9)
    (connected c10 c11) (connected c11 c10)
    (connected c11 c12) (connected c12 c11)
    (connected c12 c13) (connected c13 c12)
    (connected c13 c14) (connected c14 c13)

    ;; 세로 엣지: 4개 (첫, 두, 세, 마지막 컬럼)
    ;; column 1: c1 - c8
    (connected c1 c8) (connected c8 c1)
    ;; column 2: c2 - c9
    (connected c2 c9) (connected c9 c2)
    ;; column 3: c3 - c10
    (connected c3 c10) (connected c10 c3)
    ;; column 7: c7 - c14
    (connected c7 c14) (connected c14 c7)

    ;; =========================
    ;; 거리 (distance) – numeric cost
    ;; =========================

    ;; 윗줄 가로 cost: 10, 20, 30, 40, 50, 60
    (= (distance c1 c2) 10)  (= (distance c2 c1) 10)
    (= (distance c2 c3) 20)  (= (distance c3 c2) 20)
    (= (distance c3 c4) 30)  (= (distance c4 c3) 30)
    (= (distance c4 c5) 40)  (= (distance c5 c4) 40)
    (= (distance c5 c6) 50)  (= (distance c6 c5) 50)
    (= (distance c6 c7) 60)  (= (distance c7 c6) 60)

    ;; 아랫줄 가로 cost: 15, 25, 35, 45, 55, 65
    (= (distance c8 c9) 15)    (= (distance c9 c8) 15)
    (= (distance c9 c10) 25)   (= (distance c10 c9) 25)
    (= (distance c10 c11) 35)  (= (distance c11 c10) 35)
    (= (distance c11 c12) 45)  (= (distance c12 c11) 45)
    (= (distance c12 c13) 55)  (= (distance c13 c12) 55)
    (= (distance c13 c14) 65)  (= (distance c14 c13) 65)

    ;; 세로 cost: 첫, 둘, 셋, 마지막 컬럼 = 1, 2, 3, 7
    (= (distance c1 c8) 1)   (= (distance c8 c1) 1)
    (= (distance c2 c9) 2)   (= (distance c9 c2) 2)
    (= (distance c3 c10) 3)  (= (distance c10 c3) 3)
    (= (distance c7 c14) 7)  (= (distance c14 c7) 7)
  )

  ;; 목표: 모든 도시 방문
  (:goal
    (and
      (visited c1)
      (visited c2)
      (visited c3)
      (visited c4)
      (visited c5)
      (visited c6)
      (visited c7)
      (visited c8)
      (visited c9)
      (visited c10)
      (visited c11)
      (visited c12)
      (visited c13)
      (visited c14)
    )
  )

  ;; 누적 비용 최소화
  (:metric minimize (total-cost))
)
