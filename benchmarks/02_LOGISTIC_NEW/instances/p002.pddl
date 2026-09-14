(define (problem amazon)
  (:domain logistic-new)

  ;; 객체 선언: 이 도메인은 :typing을 켰지만 타입을 쓰지 않았으므로
  ;; unary predicate로 분류합니다(= 아래 init에서 (driver ...), (truck ...), (place ...) 등으로 구분).
  (:objects
    changmin                                 ; driver
    Cadilac K5 Sonata                                ; truck
    pack1 pack2 pack3 ; pack4 pack5             ; packages
    home node1 node2 ; node3 node4 node5
    node6 node7 hub1 hub2 work               ; places
  )

  (:init
    ;; 분류(unary predicates)
    (driver changmin)
    (truck Cadilac)
    (truck K5)
    (truck Sonata)

    (package pack1) (package pack2) (package pack3) ;(package pack4) (package pack5)
    ; (package pack6) (package pack7) (package pack8) (package pack9) (package pack10)
    ; (package pack11)

    (place home) (place node1) (place node2) ;(place node3) (place node4) (place node5) 
    (place node6) (place node7) (place hub1) (place hub2) (place work)

    ;; 초기 위치
    (at changmin home)
    (at Cadilac node1)
    (at K5 node1)
    (at Sonata node1)

    ;; 패키지 초기 배치(예시로 흩뿌려 둠: 필요하면 바꿔도 됨)
    (at pack1 node1)
    (at pack2 node7)
    (at pack3 node1)
    ; (at pack4 node1)
    ; (at pack5 node1)
    ; (at pack6 hub1)
    ; (at pack7 hub2)
    ; (at pack8 node6)
    ; (at pack9 node7)
    ; (at pack10 work)
    ; (at pack11 node1)

    ;; 도로(road) — 이 도메인은 양방향을 자동으로 만들지 않으므로,
    ;; 언급된 연결을 모두 양방향으로 명시합니다.

    ;; home - node1
    (road home node1) (road node1 home)

    ;; node1 - node2
    (road node1 node2) (road node2 node1)

    ;; node2 - node4, hub1
    ; (road node2 node4) (road node4 node2)
    (road node2 hub1)  (road hub1 node2)

    ;; node3 - home, node2, node4, node5
    ; (road node3 home) (road home node3)
    ; (road node3 node2) (road node2 node3)
    ; ; (road node3 node4) (road node4 node3)
    ; ; (road node3 node5) (road node5 node3)

    ; ;; node4 - hub1
    ; (road node4 hub1) (road hub1 node4)

    ; ;; node5 - hub1
    ; (road node5 hub1) (road hub1 node5)

    ;; hub2 - node6 - node7 - work (양방향)
    (road hub2 node6) (road node6 hub2)
    (road hub2 node7) (road node7 hub2)
    (road node6 node7) (road node7 node6)
    (road node7 work)  (road work node7)

    ;; 고속도로(highway) — hub1 <-> hub2
    (highway hub1 hub2)
    (highway hub2 hub1)
  )

  ;; 목표: 모든 패키지를 home으로
  (:goal
    (and
      (at pack1 home)
      (at pack2 home)
      (at pack3 home)
      ; (at pack4 home)
      ; (at pack5 home)
      ; (at pack6 home)
      ; (at pack7 home)
      ; (at pack8 home)
      ; (at pack9 home)
      ; (at pack10 home)
      ; (at pack11 home)
    )
  )
)
