(define (problem tsp-4cities)
  (:domain tsp-numeric)

  (:objects
    agent1 - agent
    c1 c2 c3 c4 - city
    ; c1 c2 - city
  )

  (:init
    ; 초기 위치: c1
    (at agent1 c1)
    (visited c1)

    ; 초기 total-cost = 0
    (= (total-cost) 0)

    ; fully connected 거리 정보 (예시: symmetric TSP)
    (= (distance c1 c2) 10)
    (= (distance c2 c1) 10)

    (= (distance c1 c3) 15)
    (= (distance c3 c1) 15)

    (= (distance c1 c4) 20)
    (= (distance c4 c1) 20)

    (= (distance c2 c3) 35)
    (= (distance c3 c2) 35)

    (= (distance c2 c4) 25)
    (= (distance c4 c2) 25)

    (= (distance c3 c4) 30)
    (= (distance c4 c3) 30)
  )

  ; 목표: 모든 도시를 최소 한 번 이상 방문
  (:goal
    (and
      (visited c1)
      (visited c2)
      (visited c3)
      (visited c4)
    )
  )

  ; 비용 최소화 (누적 total-cost)
  (:metric minimize (total-cost))
)
