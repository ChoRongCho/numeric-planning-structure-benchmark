(define (domain blocksworld)
  (:requirements :strips :typing :action-costs)

  (:predicates
    (block ?block)
    (table ?table)

    (on ?upper ?lower)          ; upper가 lower(=block) 위에 있음
    (on-table ?block ?table)    ; block이 특정 table 자리에 놓여 있음
    (clear ?x)                  ; x 위에 아무것도 없음 (x는 block 또는 table)
    (holding ?block)            ; 손에 block을 들고 있음
    (handempty)                 ; 손이 빔
  )

  (:functions (total-cost))

  ; 테이블에서 블록 집기
  (:action pickup
    :parameters (?block ?table)
    :precondition (and
      (block ?block)
      (table ?table)
      (on-table ?block ?table)
      (clear ?block)
      (handempty)
    )
    :effect (and
      (holding ?block)
      (clear ?table)
      (not (on-table ?block ?table))
      (not (handempty))
      (not (clear ?block))
      (increase (total-cost) 1)
    )
  )

  ; 블록을 테이블에 내려놓기 (빈 자리여야 함)
  (:action putdown
    :parameters (?block ?table)
    :precondition (and
      (block ?block)
      (table ?table)
      (holding ?block)
      (clear ?table)
    )
    :effect (and
      (on-table ?block ?table)
      (clear ?block)
      (handempty)
      (not (holding ?block))
      (not (clear ?table))
      (increase (total-cost) 1)
    )
  )

  ; 블록 위에서 블록 떼기
  (:action unstack
    :parameters (?upper ?lower)
    :precondition (and
      (block ?upper)
      (block ?lower)
      (on ?upper ?lower)
      (clear ?upper)
      (handempty)
    )
    :effect (and
      (holding ?upper)
      (clear ?lower)
      (not (on ?upper ?lower))
      (not (handempty))
      (not (clear ?upper))
      (increase (total-cost) 1)
    )
  )

  ; 블록을 블록 위에 올리기
  (:action stack
    :parameters (?upper ?lower)
    :precondition (and
      (block ?upper)
      (block ?lower)
      (holding ?upper)
      (clear ?lower)
    )
    :effect (and
      (on ?upper ?lower)
      (clear ?upper)
      (handempty)
      (not (holding ?upper))
      (not (clear ?lower))
      (increase (total-cost) 1)
    )
  )
)
