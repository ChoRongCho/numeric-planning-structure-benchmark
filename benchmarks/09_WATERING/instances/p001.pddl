(define (problem p0) (:domain watering)
(:objects 
    Changmin
    plant1 plant2 plant3 plant4
    basket1
    room1 room2 room3 room4 station1 tap1
)

(:init
  (agent Changmin)
  (free Changmin)
  (container basket1)
  (room room1) (room room2) (room room3) (room room4) (room station1) (room tap1)
  (station station1) (tap tap1)


  (= (battery-cap Changmin) 100)
  (= (current-battery Changmin) 100)

  ; metrics

  (= (max-carry basket1) 20)
  (= (carrying Changmin basket1) 0)
  (= (poured plant1) 0)
  (= (poured plant2) 0)
  (= (poured plant3) 0)
  (= (poured plant4) 0)

  (plant plant1) (plant plant2) (plant plant3) (plant plant4)

  ; ===== 초기 상태 =====
  (free Changmin)
  (at Changmin room1)
  (at basket1 room2)

  ; location of plants
  (at plant1 room3) (at plant2 room2) (at plant3 room1) (at plant4 room3)

  ; 이동 가능 연결 (양방향 체인)
  (connected room1 room2) (connected room2 room1)
  (connected room1 room3) (connected room3 room1)
  (connected room2 room3) (connected room3 room2)
  (connected room2 room4) (connected room4 room2)
  (connected room4 station1) (connected station1 room4)
  (connected room3 station1) (connected station1 room3)
  (connected station1 tap1) (connected tap1 station1)

  (= (distance room1 room2) 20) (= (distance room2 room1) 20)
  (= (distance room1 room3) 20) (= (distance room3 room1) 20)
  (= (distance room2 room3) 10) (= (distance room3 room2) 10)
  (= (distance room2 room4) 20) (= (distance room4 room2) 20)
  (= (distance room4 station1) 10) (= (distance station1 room4) 10)
  (= (distance room3 station1) 10) (= (distance station1 room3) 10)
  (= (distance station1 tap1) 5) (= (distance tap1 station1) 5)
)

(:goal (and
  (at Changmin room1)
  (free Changmin)
  (= (poured plant1) 10)
  (= (poured plant2) 10)
  (= (poured plant3) 10)
  (= (poured plant4) 10)
))

(:metric minimize (total-cost))
)
