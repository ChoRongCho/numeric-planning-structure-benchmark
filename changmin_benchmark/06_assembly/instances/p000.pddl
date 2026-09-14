(define (problem numeric-assembly-p000)
  (:domain numeric-robot-assembly)
  (:objects
    robot1 - robot
    part01 - part
    product1 - product
    precision-tool - tool
  )
  (:init
    (handempty robot1)
    (tool-slot-empty robot1)
    (tool-available precision-tool)
    (part-available part01)
    (unfinished part01)
    (part-of part01 product1)
    (first-part part01 product1)
    (compatible precision-tool part01)
    (= (robot-payload robot1) 10)
    (= (part-weight part01) 1)
    (= (required-work part01) 1)
    (= (completed-work part01) 0)
    (= (tool-work-step precision-tool) 1)
    (= (pick-time part01) 1)
    (= (place-time part01) 1)
    (= (tool-change-time precision-tool) 1)
    (= (tool-operation-time precision-tool) 1)
    (= (inspection-time) 1)
    (= (total-assembly-time) 0)
  )
  (:goal (and
    (fastened part01 product1)
    (handempty robot1)
    (tool-slot-empty robot1)
    (tool-available precision-tool)
  ))
  (:metric minimize (total-assembly-time))
)
