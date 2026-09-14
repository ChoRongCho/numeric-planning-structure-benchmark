;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; SeedSet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (define (domain SeedSet)
  (:requirements :strips :typing :action-costs)

  (:predicates
    (C00022)
    (C00024)
    (C00031)
    (C00033)
    (C00036)
    (C00068)
    (C00074)
    (C00084)
    (C00103)
    (C00111)
    (C00118)
    (C00186)
    (C00197)
    (C00221)
    (C00236)
    (C00267)
    (C00469)
    (C00631)
    (C00668)
    (C01159)
    (C01172)
    (C01451)
    (C05125)
    (C05345)
    (C05378)
    (C06186)
    (C06187)
    (C06188)
    (C15972)
    (C15973)
    (C16255)
    (C00026)
    (C00042)
    (C00091)
    (C00122)
    (C00149)
    (C00158)
    (C00311)
    (C00417)
    (C05379)
    (C05381)
    (C16254)
    (C00117)
    (C00119)
    (C00121)
    (C00198)
    (C00199)
    (C00204)
    (C00231)
    (C00257)
    (C00258)
    (C00279)
    (C00345)
    (C00577)
    (C00620)
    (C00672)
    (C00673)
    (C01151)
    (C01218)
    (C01236)
    (C01801)
    (C03752)
    (C04442)
    (C05382)
    (C06473)
    (C00029)
    (C00085)
    (C00167)
    (C00181)
    (C00191)
    (C00259)
    (C00266)
    (C00309)
    (C00310)
    (C00312)
    (C00333)
    (C00379)
    (C00470)
    (C00474)
    (C00476)
    (C00502)
    (C00508)
    (C00514)
    (C00532)
    (C00558)
    (C00618)
    (C00714)
    (C00789)
    (C00800)
    (C00817)
    (C00905)
    (C01068)
    (C01101)
    (C01508)
    (C01904)
    (C02266)
    (C02273)
    (C03033)
    (C03291)
    (C03826)
    (C04053)
    (C04349)
    (C04575)
    (C05385)
    (C05411)
    (C05412)
    (C06019)
    (C06118)
    (C06441)
    (C14899)
    (C00095)
    (C00096)
    (C00159)
    (C00247)
    (C00275)
    (C00325)
    (C00392)
    (C00424)
    (C00464)
    (C00507)
    (C00636)
    (C00644)
    (C00665)
    (C00794)
    (C00861)
    (C00937)
    (C00976)
    (C01019)
    (C01094)
    (C01096)
    (C01099)
    (C01131)
    (C01222)
    (C01355)
    (C01680)
    (C01721)
    (C01768)
    (C01934)
    (C02431)
    (C02492)
    (C02888)
    (C02977)
    (C02985)
    (C02991)
    (C03117)
    (C03267)
    (C03979)
    (C05392)
    (C06159)
    (C06192)
    (C11516)
    (C11544)
    (C00052)
    (C00089)
    (C00116)
    (C00124)
    (C00137)
    (C00243)
    (C00446)
    (C00492)
    (C00795)
    (C00880)
    (C01097)
    (C01113)
    (C01132)
    (C01216)
    (C01235)
    (C01286)
    (C01613)
    (C01697)
    (C02262)
    (C03383)
    (C03785)
    (C05396)
    (C05399)
    (C05400)
    (C05401)
    (C05402)
    (C05404)
    (C05796)
    (C06311)
    (C06376)
    (C06377)
    (C00072)
    (C00433)
    (C00545)
    (C00679)
    (C00684)
    (C00818)
    (C00879)
    (C01040)
    (C01041)
    (C01114)
    (C01115)
    (C01146)
    (C01620)
    (C01825)
    (C02280)
    (C02670)
    (C03064)
    (C03289)
    (C03921)
    (C05406)
    (C05422)
    (C15923)
    (C15924)
    (C15925)
    (C15926)
    (C15930)
    (C16186)
    (C00083)
    (C00229)
    (C00249)
    (C00712)
    (C01203)
    (C01209)
    (C01530)
    (C01571)
    (C02679)
    (C03939)
    (C04088)
    (C04246)
    (C04419)
    (C04618)
    (C04619)
    (C04620)
    (C04633)
    (C04688)
    (C05223)
    (C05744)
    (C05745)
    (C05746)
    (C05747)
    (C05748)
    (C05749)
    (C05750)
    (C05751)
    (C05752)
    (C05753)
    (C05754)
    (C05755)
    (C05756)
    (C05757)
    (C05758)
    (C05759)
    (C05760)
    (C05761)
    (C05762)
    (C05763)
    (C05764)
    (C06250)
    (C06423)
    (C06424)
    (C08362)
    (C16219)
    (C16220)
    (C16221)
    (C16520)
    (C00136)
    (C00154)
    (C01832)
    (C01944)
    (C02593)
    (C03221)
    (C05258)
    (C05259)
    (C05260)
    (C05261)
    (C05262)
    (C05263)
    (C05264)
    (C05265)
    (C05266)
    (C05267)
    (C05268)
    (C05269)
    (C05270)
    (C05271)
    (C05272)
    (C05273)
    (C05274)
    (C05275)
    (C05276)
    (C00010)
    (C00071)
    (C00162)
    (C00173)
    (C00226)
    (C00332)
    (C00340)
    (C00435)
    (C00489)
    (C00517)
    (C00527)
    (C00638)
    (C00823)
    (C00877)
    (C01144)
    (C01371)
    (C02990)
    (C03547)
    (C03561)
    (C05102)
    (C05279)
    (C05280)
    )

   (:functions (total-cost) - number)

   (:action insert_C00022
           :parameters ()
           :precondition (and)
           :effect
           (and (C00022)
	           (increase (total-cost) 10)))

   (:action insert_C00024
           :parameters ()
           :precondition (and)
           :effect
           (and (C00024)
	           (increase (total-cost) 10)))

   (:action insert_C00031
           :parameters ()
           :precondition (and)
           :effect
           (and (C00031)
	           (increase (total-cost) 10)))

   (:action insert_C00033
           :parameters ()
           :precondition (and)
           :effect
           (and (C00033)
	           (increase (total-cost) 10)))

   (:action insert_C00036
           :parameters ()
           :precondition (and)
           :effect
           (and (C00036)
	           (increase (total-cost) 10)))

   (:action insert_C00068
           :parameters ()
           :precondition (and)
           :effect
           (and (C00068)
	           (increase (total-cost) 10)))

   (:action insert_C00074
           :parameters ()
           :precondition (and)
           :effect
           (and (C00074)
	           (increase (total-cost) 10)))

   (:action insert_C00084
           :parameters ()
           :precondition (and)
           :effect
           (and (C00084)
	           (increase (total-cost) 10)))

   (:action insert_C00103
           :parameters ()
           :precondition (and)
           :effect
           (and (C00103)
	           (increase (total-cost) 10)))

   (:action insert_C00111
           :parameters ()
           :precondition (and)
           :effect
           (and (C00111)
	           (increase (total-cost) 10)))

   (:action insert_C00118
           :parameters ()
           :precondition (and)
           :effect
           (and (C00118)
	           (increase (total-cost) 10)))

   (:action insert_C00197
           :parameters ()
           :precondition (and)
           :effect
           (and (C00197)
	           (increase (total-cost) 10)))

   (:action insert_C00236
           :parameters ()
           :precondition (and)
           :effect
           (and (C00236)
	           (increase (total-cost) 10)))

   (:action insert_C00267
           :parameters ()
           :precondition (and)
           :effect
           (and (C00267)
	           (increase (total-cost) 10)))

   (:action insert_C00469
           :parameters ()
           :precondition (and)
           :effect
           (and (C00469)
	           (increase (total-cost) 10)))

   (:action insert_C00631
           :parameters ()
           :precondition (and)
           :effect
           (and (C00631)
	           (increase (total-cost) 10)))

   (:action insert_C00668
           :parameters ()
           :precondition (and)
           :effect
           (and (C00668)
	           (increase (total-cost) 10)))

   (:action insert_C01159
           :parameters ()
           :precondition (and)
           :effect
           (and (C01159)
	           (increase (total-cost) 10)))

   (:action insert_C01172
           :parameters ()
           :precondition (and)
           :effect
           (and (C01172)
	           (increase (total-cost) 10)))

   (:action insert_C05125
           :parameters ()
           :precondition (and)
           :effect
           (and (C05125)
	           (increase (total-cost) 10)))

   (:action insert_C05345
           :parameters ()
           :precondition (and)
           :effect
           (and (C05345)
	           (increase (total-cost) 10)))

   (:action insert_C05378
           :parameters ()
           :precondition (and)
           :effect
           (and (C05378)
	           (increase (total-cost) 10)))

   (:action insert_C15972
           :parameters ()
           :precondition (and)
           :effect
           (and (C15972)
	           (increase (total-cost) 10)))

   (:action insert_C15973
           :parameters ()
           :precondition (and)
           :effect
           (and (C15973)
	           (increase (total-cost) 10)))

   (:action insert_C16255
           :parameters ()
           :precondition (and)
           :effect
           (and (C16255)
	           (increase (total-cost) 10)))

   (:action insert_C00026
           :parameters ()
           :precondition (and)
           :effect
           (and (C00026)
	           (increase (total-cost) 10)))

   (:action insert_C00042
           :parameters ()
           :precondition (and)
           :effect
           (and (C00042)
	           (increase (total-cost) 10)))

   (:action insert_C00091
           :parameters ()
           :precondition (and)
           :effect
           (and (C00091)
	           (increase (total-cost) 10)))

   (:action insert_C00122
           :parameters ()
           :precondition (and)
           :effect
           (and (C00122)
	           (increase (total-cost) 10)))

   (:action insert_C00149
           :parameters ()
           :precondition (and)
           :effect
           (and (C00149)
	           (increase (total-cost) 10)))

   (:action insert_C00158
           :parameters ()
           :precondition (and)
           :effect
           (and (C00158)
	           (increase (total-cost) 10)))

   (:action insert_C00311
           :parameters ()
           :precondition (and)
           :effect
           (and (C00311)
	           (increase (total-cost) 10)))

   (:action insert_C00417
           :parameters ()
           :precondition (and)
           :effect
           (and (C00417)
	           (increase (total-cost) 10)))

   (:action insert_C05379
           :parameters ()
           :precondition (and)
           :effect
           (and (C05379)
	           (increase (total-cost) 10)))

   (:action insert_C05381
           :parameters ()
           :precondition (and)
           :effect
           (and (C05381)
	           (increase (total-cost) 10)))

   (:action insert_C16254
           :parameters ()
           :precondition (and)
           :effect
           (and (C16254)
	           (increase (total-cost) 10)))

   (:action insert_C00117
           :parameters ()
           :precondition (and)
           :effect
           (and (C00117)
	           (increase (total-cost) 10)))

   (:action insert_C00119
           :parameters ()
           :precondition (and)
           :effect
           (and (C00119)
	           (increase (total-cost) 10)))

   (:action insert_C00199
           :parameters ()
           :precondition (and)
           :effect
           (and (C00199)
	           (increase (total-cost) 10)))

   (:action insert_C00204
           :parameters ()
           :precondition (and)
           :effect
           (and (C00204)
	           (increase (total-cost) 10)))

   (:action insert_C00231
           :parameters ()
           :precondition (and)
           :effect
           (and (C00231)
	           (increase (total-cost) 10)))

   (:action insert_C00279
           :parameters ()
           :precondition (and)
           :effect
           (and (C00279)
	           (increase (total-cost) 10)))

   (:action insert_C00345
           :parameters ()
           :precondition (and)
           :effect
           (and (C00345)
	           (increase (total-cost) 10)))

   (:action insert_C00577
           :parameters ()
           :precondition (and)
           :effect
           (and (C00577)
	           (increase (total-cost) 10)))

   (:action insert_C01236
           :parameters ()
           :precondition (and)
           :effect
           (and (C01236)
	           (increase (total-cost) 10)))

   (:action insert_C04442
           :parameters ()
           :precondition (and)
           :effect
           (and (C04442)
	           (increase (total-cost) 10)))

   (:action insert_C05382
           :parameters ()
           :precondition (and)
           :effect
           (and (C05382)
	           (increase (total-cost) 10)))

   (:action insert_C06473
           :parameters ()
           :precondition (and)
           :effect
           (and (C06473)
	           (increase (total-cost) 10)))

   (:action insert_C00029
           :parameters ()
           :precondition (and)
           :effect
           (and (C00029)
	           (increase (total-cost) 10)))

   (:action insert_C00167
           :parameters ()
           :precondition (and)
           :effect
           (and (C00167)
	           (increase (total-cost) 10)))

   (:action insert_C00310
           :parameters ()
           :precondition (and)
           :effect
           (and (C00310)
	           (increase (total-cost) 10)))

   (:action insert_C00514
           :parameters ()
           :precondition (and)
           :effect
           (and (C00514)
	           (increase (total-cost) 10)))

   (:action insert_C00905
           :parameters ()
           :precondition (and)
           :effect
           (and (C00905)
	           (increase (total-cost) 10)))

   (:action insert_C00159
           :parameters ()
           :precondition (and)
           :effect
           (and (C00159)
	           (increase (total-cost) 10)))

   (:action insert_C00275
           :parameters ()
           :precondition (and)
           :effect
           (and (C00275)
	           (increase (total-cost) 10)))

   (:action insert_C00644
           :parameters ()
           :precondition (and)
           :effect
           (and (C00644)
	           (increase (total-cost) 10)))

   (:action insert_C00794
           :parameters ()
           :precondition (and)
           :effect
           (and (C00794)
	           (increase (total-cost) 10)))

   (:action insert_C01094
           :parameters ()
           :precondition (and)
           :effect
           (and (C01094)
	           (increase (total-cost) 10)))

   (:action insert_C01096
           :parameters ()
           :precondition (and)
           :effect
           (and (C01096)
	           (increase (total-cost) 10)))

   (:action insert_C01934
           :parameters ()
           :precondition (and)
           :effect
           (and (C01934)
	           (increase (total-cost) 10)))

   (:action insert_C02888
           :parameters ()
           :precondition (and)
           :effect
           (and (C02888)
	           (increase (total-cost) 10)))

   (:action insert_C03979
           :parameters ()
           :precondition (and)
           :effect
           (and (C03979)
	           (increase (total-cost) 10)))

   (:action insert_C00052
           :parameters ()
           :precondition (and)
           :effect
           (and (C00052)
	           (increase (total-cost) 10)))

   (:action insert_C00089
           :parameters ()
           :precondition (and)
           :effect
           (and (C00089)
	           (increase (total-cost) 10)))

   (:action insert_C00116
           :parameters ()
           :precondition (and)
           :effect
           (and (C00116)
	           (increase (total-cost) 10)))

   (:action insert_C00124
           :parameters ()
           :precondition (and)
           :effect
           (and (C00124)
	           (increase (total-cost) 10)))

   (:action insert_C00137
           :parameters ()
           :precondition (and)
           :effect
           (and (C00137)
	           (increase (total-cost) 10)))

   (:action insert_C00492
           :parameters ()
           :precondition (and)
           :effect
           (and (C00492)
	           (increase (total-cost) 10)))

   (:action insert_C01097
           :parameters ()
           :precondition (and)
           :effect
           (and (C01097)
	           (increase (total-cost) 10)))

   (:action insert_C01216
           :parameters ()
           :precondition (and)
           :effect
           (and (C01216)
	           (increase (total-cost) 10)))

   (:action insert_C01235
           :parameters ()
           :precondition (and)
           :effect
           (and (C01235)
	           (increase (total-cost) 10)))

   (:action insert_C01286
           :parameters ()
           :precondition (and)
           :effect
           (and (C01286)
	           (increase (total-cost) 10)))

   (:action insert_C03785
           :parameters ()
           :precondition (and)
           :effect
           (and (C03785)
	           (increase (total-cost) 10)))

   (:action insert_C05399
           :parameters ()
           :precondition (and)
           :effect
           (and (C05399)
	           (increase (total-cost) 10)))

   (:action insert_C05400
           :parameters ()
           :precondition (and)
           :effect
           (and (C05400)
	           (increase (total-cost) 10)))

   (:action insert_C05401
           :parameters ()
           :precondition (and)
           :effect
           (and (C05401)
	           (increase (total-cost) 10)))

   (:action insert_C05402
           :parameters ()
           :precondition (and)
           :effect
           (and (C05402)
	           (increase (total-cost) 10)))

   (:action insert_C05404
           :parameters ()
           :precondition (and)
           :effect
           (and (C05404)
	           (increase (total-cost) 10)))

   (:action insert_C00433
           :parameters ()
           :precondition (and)
           :effect
           (and (C00433)
	           (increase (total-cost) 10)))

   (:action insert_C00679
           :parameters ()
           :precondition (and)
           :effect
           (and (C00679)
	           (increase (total-cost) 10)))

   (:action insert_C00818
           :parameters ()
           :precondition (and)
           :effect
           (and (C00818)
	           (increase (total-cost) 10)))

   (:action insert_C00879
           :parameters ()
           :precondition (and)
           :effect
           (and (C00879)
	           (increase (total-cost) 10)))

   (:action insert_C01115
           :parameters ()
           :precondition (and)
           :effect
           (and (C01115)
	           (increase (total-cost) 10)))

   (:action insert_C02670
           :parameters ()
           :precondition (and)
           :effect
           (and (C02670)
	           (increase (total-cost) 10)))

   (:action insert_C00083
           :parameters ()
           :precondition (and)
           :effect
           (and (C00083)
	           (increase (total-cost) 10)))

   (:action insert_C00229
           :parameters ()
           :precondition (and)
           :effect
           (and (C00229)
	           (increase (total-cost) 10)))

   (:action insert_C01209
           :parameters ()
           :precondition (and)
           :effect
           (and (C01209)
	           (increase (total-cost) 10)))

   (:action insert_C04246
           :parameters ()
           :precondition (and)
           :effect
           (and (C04246)
	           (increase (total-cost) 10)))

   (:action insert_C04419
           :parameters ()
           :precondition (and)
           :effect
           (and (C04419)
	           (increase (total-cost) 10)))

   (:action insert_C04618
           :parameters ()
           :precondition (and)
           :effect
           (and (C04618)
	           (increase (total-cost) 10)))

   (:action insert_C04619
           :parameters ()
           :precondition (and)
           :effect
           (and (C04619)
	           (increase (total-cost) 10)))

   (:action insert_C04620
           :parameters ()
           :precondition (and)
           :effect
           (and (C04620)
	           (increase (total-cost) 10)))

   (:action insert_C04633
           :parameters ()
           :precondition (and)
           :effect
           (and (C04633)
	           (increase (total-cost) 10)))

   (:action insert_C04688
           :parameters ()
           :precondition (and)
           :effect
           (and (C04688)
	           (increase (total-cost) 10)))

   (:action insert_C05223
           :parameters ()
           :precondition (and)
           :effect
           (and (C05223)
	           (increase (total-cost) 10)))

   (:action insert_C05744
           :parameters ()
           :precondition (and)
           :effect
           (and (C05744)
	           (increase (total-cost) 10)))

   (:action insert_C05745
           :parameters ()
           :precondition (and)
           :effect
           (and (C05745)
	           (increase (total-cost) 10)))

   (:action insert_C05746
           :parameters ()
           :precondition (and)
           :effect
           (and (C05746)
	           (increase (total-cost) 10)))

   (:action insert_C05747
           :parameters ()
           :precondition (and)
           :effect
           (and (C05747)
	           (increase (total-cost) 10)))

   (:action insert_C05748
           :parameters ()
           :precondition (and)
           :effect
           (and (C05748)
	           (increase (total-cost) 10)))

   (:action insert_C05749
           :parameters ()
           :precondition (and)
           :effect
           (and (C05749)
	           (increase (total-cost) 10)))

   (:action insert_C05750
           :parameters ()
           :precondition (and)
           :effect
           (and (C05750)
	           (increase (total-cost) 10)))

   (:action insert_C05751
           :parameters ()
           :precondition (and)
           :effect
           (and (C05751)
	           (increase (total-cost) 10)))

   (:action insert_C05752
           :parameters ()
           :precondition (and)
           :effect
           (and (C05752)
	           (increase (total-cost) 10)))

   (:action insert_C05753
           :parameters ()
           :precondition (and)
           :effect
           (and (C05753)
	           (increase (total-cost) 10)))

   (:action insert_C05754
           :parameters ()
           :precondition (and)
           :effect
           (and (C05754)
	           (increase (total-cost) 10)))

   (:action insert_C05755
           :parameters ()
           :precondition (and)
           :effect
           (and (C05755)
	           (increase (total-cost) 10)))

   (:action insert_C05756
           :parameters ()
           :precondition (and)
           :effect
           (and (C05756)
	           (increase (total-cost) 10)))

   (:action insert_C05757
           :parameters ()
           :precondition (and)
           :effect
           (and (C05757)
	           (increase (total-cost) 10)))

   (:action insert_C05758
           :parameters ()
           :precondition (and)
           :effect
           (and (C05758)
	           (increase (total-cost) 10)))

   (:action insert_C05759
           :parameters ()
           :precondition (and)
           :effect
           (and (C05759)
	           (increase (total-cost) 10)))

   (:action insert_C05760
           :parameters ()
           :precondition (and)
           :effect
           (and (C05760)
	           (increase (total-cost) 10)))

   (:action insert_C05761
           :parameters ()
           :precondition (and)
           :effect
           (and (C05761)
	           (increase (total-cost) 10)))

   (:action insert_C05762
           :parameters ()
           :precondition (and)
           :effect
           (and (C05762)
	           (increase (total-cost) 10)))

   (:action insert_C05763
           :parameters ()
           :precondition (and)
           :effect
           (and (C05763)
	           (increase (total-cost) 10)))

   (:action insert_C05764
           :parameters ()
           :precondition (and)
           :effect
           (and (C05764)
	           (increase (total-cost) 10)))

   (:action insert_C06250
           :parameters ()
           :precondition (and)
           :effect
           (and (C06250)
	           (increase (total-cost) 10)))

   (:action insert_C16219
           :parameters ()
           :precondition (and)
           :effect
           (and (C16219)
	           (increase (total-cost) 10)))

   (:action insert_C16220
           :parameters ()
           :precondition (and)
           :effect
           (and (C16220)
	           (increase (total-cost) 10)))

   (:action insert_C16221
           :parameters ()
           :precondition (and)
           :effect
           (and (C16221)
	           (increase (total-cost) 10)))

   (:action insert_C00136
           :parameters ()
           :precondition (and)
           :effect
           (and (C00136)
	           (increase (total-cost) 10)))

   (:action insert_C01832
           :parameters ()
           :precondition (and)
           :effect
           (and (C01832)
	           (increase (total-cost) 10)))

   (:action insert_C01944
           :parameters ()
           :precondition (and)
           :effect
           (and (C01944)
	           (increase (total-cost) 10)))

   (:action insert_C02593
           :parameters ()
           :precondition (and)
           :effect
           (and (C02593)
	           (increase (total-cost) 10)))

   (:action insert_C03221
           :parameters ()
           :precondition (and)
           :effect
           (and (C03221)
	           (increase (total-cost) 10)))

   (:action insert_C05258
           :parameters ()
           :precondition (and)
           :effect
           (and (C05258)
	           (increase (total-cost) 10)))

   (:action insert_C05259
           :parameters ()
           :precondition (and)
           :effect
           (and (C05259)
	           (increase (total-cost) 10)))

   (:action insert_C05260
           :parameters ()
           :precondition (and)
           :effect
           (and (C05260)
	           (increase (total-cost) 10)))

   (:action insert_C05261
           :parameters ()
           :precondition (and)
           :effect
           (and (C05261)
	           (increase (total-cost) 10)))

   (:action insert_C05262
           :parameters ()
           :precondition (and)
           :effect
           (and (C05262)
	           (increase (total-cost) 10)))

   (:action insert_C05263
           :parameters ()
           :precondition (and)
           :effect
           (and (C05263)
	           (increase (total-cost) 10)))

   (:action insert_C05264
           :parameters ()
           :precondition (and)
           :effect
           (and (C05264)
	           (increase (total-cost) 10)))

   (:action insert_C05265
           :parameters ()
           :precondition (and)
           :effect
           (and (C05265)
	           (increase (total-cost) 10)))

   (:action insert_C05266
           :parameters ()
           :precondition (and)
           :effect
           (and (C05266)
	           (increase (total-cost) 10)))

   (:action insert_C05267
           :parameters ()
           :precondition (and)
           :effect
           (and (C05267)
	           (increase (total-cost) 10)))

   (:action insert_C05268
           :parameters ()
           :precondition (and)
           :effect
           (and (C05268)
	           (increase (total-cost) 10)))

   (:action insert_C05269
           :parameters ()
           :precondition (and)
           :effect
           (and (C05269)
	           (increase (total-cost) 10)))

   (:action insert_C05270
           :parameters ()
           :precondition (and)
           :effect
           (and (C05270)
	           (increase (total-cost) 10)))

   (:action insert_C05271
           :parameters ()
           :precondition (and)
           :effect
           (and (C05271)
	           (increase (total-cost) 10)))

   (:action insert_C05272
           :parameters ()
           :precondition (and)
           :effect
           (and (C05272)
	           (increase (total-cost) 10)))

   (:action insert_C05273
           :parameters ()
           :precondition (and)
           :effect
           (and (C05273)
	           (increase (total-cost) 10)))

   (:action insert_C05274
           :parameters ()
           :precondition (and)
           :effect
           (and (C05274)
	           (increase (total-cost) 10)))

   (:action insert_C05275
           :parameters ()
           :precondition (and)
           :effect
           (and (C05275)
	           (increase (total-cost) 10)))

   (:action insert_C05276
           :parameters ()
           :precondition (and)
           :effect
           (and (C05276)
	           (increase (total-cost) 10)))

   (:action insert_C00010
           :parameters ()
           :precondition (and)
           :effect
           (and (C00010)
	           (increase (total-cost) 10)))

   (:action insert_C00071
           :parameters ()
           :precondition (and)
           :effect
           (and (C00071)
	           (increase (total-cost) 10)))

   (:action insert_C00173
           :parameters ()
           :precondition (and)
           :effect
           (and (C00173)
	           (increase (total-cost) 10)))

   (:action insert_C00226
           :parameters ()
           :precondition (and)
           :effect
           (and (C00226)
	           (increase (total-cost) 10)))

   (:action insert_C00332
           :parameters ()
           :precondition (and)
           :effect
           (and (C00332)
	           (increase (total-cost) 10)))

   (:action insert_C00638
           :parameters ()
           :precondition (and)
           :effect
           (and (C00638)
	           (increase (total-cost) 10)))

   (:action insert_C00877
           :parameters ()
           :precondition (and)
           :effect
           (and (C00877)
	           (increase (total-cost) 10)))

   (:action insert_C01144
           :parameters ()
           :precondition (and)
           :effect
           (and (C01144)
	           (increase (total-cost) 10)))

   (:action insert_C03561
           :parameters ()
           :precondition (and)
           :effect
           (and (C03561)
	           (increase (total-cost) 10)))

   (:action insert_C05279
           :parameters ()
           :precondition (and)
           :effect
           (and (C05279)
	           (increase (total-cost) 10)))

   (:action insert_C05280
           :parameters ()
           :precondition (and)
           :effect
           (and (C05280)
	           (increase (total-cost) 10)))

    (:action reaction_R00014left
           :parameters ()
         :precondition 
           (and
             (C00022)
             (C00068)
                    )
         :effect
           (and
             (C05125)
	         (increase (total-cost) 1)))

    (:action reaction_R00200left
           :parameters ()
         :precondition 
           (and
             (C00074)
                    )
         :effect
           (and
             (C00022)
	         (increase (total-cost) 1)))

    (:action reaction_R00235left
           :parameters ()
         :precondition 
           (and
             (C00024)
                    )
         :effect
           (and
             (C00033)
	         (increase (total-cost) 1)))

    (:action reaction_R00341left
           :parameters ()
         :precondition 
           (and
             (C00036)
                    )
         :effect
           (and
             (C00074)
	         (increase (total-cost) 1)))

    (:action reaction_R00658left
           :parameters ()
         :precondition 
           (and
             (C00631)
                    )
         :effect
           (and
             (C00074)
	         (increase (total-cost) 1)))

    (:action reaction_R00658right
           :parameters ()
         :precondition 
           (and
             (C00074)
                    )
         :effect
           (and
             (C00631)
	         (increase (total-cost) 1)))

    (:action reaction_R00710left
           :parameters ()
         :precondition 
           (and
             (C00084)
                    )
         :effect
           (and
             (C00033)
	         (increase (total-cost) 1)))

    (:action reaction_R00710right
           :parameters ()
         :precondition 
           (and
             (C00033)
                    )
         :effect
           (and
             (C00084)
	         (increase (total-cost) 1)))

    (:action reaction_R00754left
           :parameters ()
         :precondition 
           (and
             (C00469)
                    )
         :effect
           (and
             (C00084)
	         (increase (total-cost) 1)))

    (:action reaction_R00754right
           :parameters ()
         :precondition 
           (and
             (C00084)
                    )
         :effect
           (and
             (C00469)
	         (increase (total-cost) 1)))

    (:action reaction_R01015left
           :parameters ()
         :precondition 
           (and
             (C00118)
                    )
         :effect
           (and
             (C00111)
	         (increase (total-cost) 1)))

    (:action reaction_R01015right
           :parameters ()
         :precondition 
           (and
             (C00111)
                    )
         :effect
           (and
             (C00118)
	         (increase (total-cost) 1)))

    (:action reaction_R01061left
           :parameters ()
         :precondition 
           (and
             (C00118)
                    )
         :effect
           (and
             (C00236)
	         (increase (total-cost) 1)))

    (:action reaction_R01061right
           :parameters ()
         :precondition 
           (and
             (C00236)
                    )
         :effect
           (and
             (C00118)
	         (increase (total-cost) 1)))

    (:action reaction_R01070left
           :parameters ()
         :precondition 
           (and
             (C05378)
                    )
         :effect
           (and
             (C00111)
             (C00118)
	         (increase (total-cost) 1)))

    (:action reaction_R01070right
           :parameters ()
         :precondition 
           (and
             (C00111)
             (C00118)
                    )
         :effect
           (and
             (C05378)
	         (increase (total-cost) 1)))

    (:action reaction_R01512left
           :parameters ()
         :precondition 
           (and
             (C00197)
                    )
         :effect
           (and
             (C00236)
	         (increase (total-cost) 1)))

    (:action reaction_R01512right
           :parameters ()
         :precondition 
           (and
             (C00236)
                    )
         :effect
           (and
             (C00197)
	         (increase (total-cost) 1)))

    (:action reaction_R01518left
           :parameters ()
         :precondition 
           (and
             (C00631)
                    )
         :effect
           (and
             (C00197)
	         (increase (total-cost) 1)))

    (:action reaction_R01518right
           :parameters ()
         :precondition 
           (and
             (C00197)
                    )
         :effect
           (and
             (C00631)
	         (increase (total-cost) 1)))

    (:action reaction_R01600left
           :parameters ()
         :precondition 
           (and
             (C00221)
                    )
         :effect
           (and
             (C01172)
	         (increase (total-cost) 1)))

    (:action reaction_R01662left
           :parameters ()
         :precondition 
           (and
             (C00236)
                    )
         :effect
           (and
             (C01159)
	         (increase (total-cost) 1)))

    (:action reaction_R01662right
           :parameters ()
         :precondition 
           (and
             (C01159)
                    )
         :effect
           (and
             (C00236)
	         (increase (total-cost) 1)))

    (:action reaction_R01786left
           :parameters ()
         :precondition 
           (and
             (C00267)
                    )
         :effect
           (and
             (C00668)
	         (increase (total-cost) 1)))

    (:action reaction_R02569left
           :parameters ()
         :precondition 
           (and
             (C15973)
             (C00024)
                    )
         :effect
           (and
             (C16255)
	         (increase (total-cost) 1)))

    (:action reaction_R02569right
           :parameters ()
         :precondition 
           (and
             (C16255)
                    )
         :effect
           (and
             (C15973)
             (C00024)
	         (increase (total-cost) 1)))

    (:action reaction_R02739left
           :parameters ()
         :precondition 
           (and
             (C00668)
                    )
         :effect
           (and
             (C01172)
	         (increase (total-cost) 1)))

    (:action reaction_R02739right
           :parameters ()
         :precondition 
           (and
             (C01172)
                    )
         :effect
           (and
             (C00668)
	         (increase (total-cost) 1)))

    (:action reaction_R02740left
           :parameters ()
         :precondition 
           (and
             (C00668)
                    )
         :effect
           (and
             (C05345)
	         (increase (total-cost) 1)))

    (:action reaction_R02740right
           :parameters ()
         :precondition 
           (and
             (C05345)
                    )
         :effect
           (and
             (C00668)
	         (increase (total-cost) 1)))

    (:action reaction_R03270left
           :parameters ()
         :precondition 
           (and
             (C05125)
             (C15972)
                    )
         :effect
           (and
             (C16255)
             (C00068)
	         (increase (total-cost) 1)))

    (:action reaction_R03321left
           :parameters ()
         :precondition 
           (and
             (C01172)
                    )
         :effect
           (and
             (C05345)
	         (increase (total-cost) 1)))

    (:action reaction_R03321right
           :parameters ()
         :precondition 
           (and
             (C05345)
                    )
         :effect
           (and
             (C01172)
	         (increase (total-cost) 1)))

    (:action reaction_R04779left
           :parameters ()
         :precondition 
           (and
             (C05345)
                    )
         :effect
           (and
             (C05378)
	         (increase (total-cost) 1)))

    (:action reaction_R04780left
           :parameters ()
         :precondition 
           (and
             (C05378)
                    )
         :effect
           (and
             (C05345)
	         (increase (total-cost) 1)))

    (:action reaction_R07618left
           :parameters ()
         :precondition 
           (and
             (C15973)
                    )
         :effect
           (and
             (C15972)
	         (increase (total-cost) 1)))

    (:action reaction_R07618right
           :parameters ()
         :precondition 
           (and
             (C15972)
                    )
         :effect
           (and
             (C15973)
	         (increase (total-cost) 1)))

    

    (:action reaction_R00268left
           :parameters ()
         :precondition 
           (and
             (C05379)
                    )
         :effect
           (and
             (C00026)
	         (increase (total-cost) 1)))

    (:action reaction_R00268right
           :parameters ()
         :precondition 
           (and
             (C00026)
                    )
         :effect
           (and
             (C05379)
	         (increase (total-cost) 1)))

    

    (:action reaction_R00342left
           :parameters ()
         :precondition 
           (and
             (C00149)
                    )
         :effect
           (and
             (C00036)
	         (increase (total-cost) 1)))

    (:action reaction_R00342right
           :parameters ()
         :precondition 
           (and
             (C00036)
                    )
         :effect
           (and
             (C00149)
	         (increase (total-cost) 1)))

    (:action reaction_R00351left
           :parameters ()
         :precondition 
           (and
             (C00036)
             (C00024)
                    )
         :effect
           (and
             (C00158)
	         (increase (total-cost) 1)))

    (:action reaction_R00351right
           :parameters ()
         :precondition 
           (and
             (C00158)
                    )
         :effect
           (and
             (C00036)
             (C00024)
	         (increase (total-cost) 1)))

    (:action reaction_R00405left
           :parameters ()
         :precondition 
           (and
             (C00042)
                    )
         :effect
           (and
             (C00091)
	         (increase (total-cost) 1)))

    (:action reaction_R00405right
           :parameters ()
         :precondition 
           (and
             (C00091)
                    )
         :effect
           (and
             (C00042)
	         (increase (total-cost) 1)))

    (:action reaction_R00412left
           :parameters ()
         :precondition 
           (and
             (C00042)
                    )
         :effect
           (and
             (C00122)
	         (increase (total-cost) 1)))

    (:action reaction_R00412right
           :parameters ()
         :precondition 
           (and
             (C00122)
                    )
         :effect
           (and
             (C00042)
	         (increase (total-cost) 1)))

    (:action reaction_R00621left
           :parameters ()
         :precondition 
           (and
             (C00068)
             (C00026)
                    )
         :effect
           (and
             (C05381)
	         (increase (total-cost) 1)))

    (:action reaction_R01082left
           :parameters ()
         :precondition 
           (and
             (C00149)
                    )
         :effect
           (and
             (C00122)
	         (increase (total-cost) 1)))

    (:action reaction_R01082right
           :parameters ()
         :precondition 
           (and
             (C00122)
                    )
         :effect
           (and
             (C00149)
	         (increase (total-cost) 1)))

    (:action reaction_R01325left
           :parameters ()
         :precondition 
           (and
             (C00158)
                    )
         :effect
           (and
             (C00417)
	         (increase (total-cost) 1)))

    (:action reaction_R01325right
           :parameters ()
         :precondition 
           (and
             (C00417)
                    )
         :effect
           (and
             (C00158)
	         (increase (total-cost) 1)))

    (:action reaction_R01899left
           :parameters ()
         :precondition 
           (and
             (C00311)
                    )
         :effect
           (and
             (C05379)
	         (increase (total-cost) 1)))

    (:action reaction_R01899right
           :parameters ()
         :precondition 
           (and
             (C05379)
                    )
         :effect
           (and
             (C00311)
	         (increase (total-cost) 1)))

    (:action reaction_R01900left
           :parameters ()
         :precondition 
           (and
             (C00417)
                    )
         :effect
           (and
             (C00311)
	         (increase (total-cost) 1)))

    (:action reaction_R01900right
           :parameters ()
         :precondition 
           (and
             (C00311)
                    )
         :effect
           (and
             (C00417)
	         (increase (total-cost) 1)))

    

    

    (:action reaction_R02570left
           :parameters ()
         :precondition 
           (and
             (C15973)
             (C00091)
                    )
         :effect
           (and
             (C16254)
	         (increase (total-cost) 1)))

    (:action reaction_R02570right
           :parameters ()
         :precondition 
           (and
             (C16254)
                    )
         :effect
           (and
             (C15973)
             (C00091)
	         (increase (total-cost) 1)))

    

    (:action reaction_R03316left
           :parameters ()
         :precondition 
           (and
             (C15972)
             (C05381)
                    )
         :effect
           (and
             (C16254)
             (C00068)
	         (increase (total-cost) 1)))

    

    

    (:action reaction_R01049left
           :parameters ()
         :precondition 
           (and
             (C00117)
                    )
         :effect
           (and
             (C00119)
	         (increase (total-cost) 1)))

    (:action reaction_R01049right
           :parameters ()
         :precondition 
           (and
             (C00119)
                    )
         :effect
           (and
             (C00117)
	         (increase (total-cost) 1)))

    (:action reaction_R01056left
           :parameters ()
         :precondition 
           (and
             (C00117)
                    )
         :effect
           (and
             (C00199)
	         (increase (total-cost) 1)))

    (:action reaction_R01056right
           :parameters ()
         :precondition 
           (and
             (C00199)
                    )
         :effect
           (and
             (C00117)
	         (increase (total-cost) 1)))

    (:action reaction_R01070left-variant-2
           :parameters ()
         :precondition 
           (and
             (C05378)
                    )
         :effect
           (and
             (C00118)
	         (increase (total-cost) 1)))

    (:action reaction_R01070right-variant-2
           :parameters ()
         :precondition 
           (and
             (C00118)
                    )
         :effect
           (and
             (C05378)
	         (increase (total-cost) 1)))

    (:action reaction_R01529left
           :parameters ()
         :precondition 
           (and
             (C00199)
                    )
         :effect
           (and
             (C00231)
	         (increase (total-cost) 1)))

    (:action reaction_R01529right
           :parameters ()
         :precondition 
           (and
             (C00231)
                    )
         :effect
           (and
             (C00199)
	         (increase (total-cost) 1)))

    (:action reaction_R01541left
           :parameters ()
         :precondition 
           (and
             (C00204)
                    )
         :effect
           (and
             (C04442)
	         (increase (total-cost) 1)))

    (:action reaction_R01641left
           :parameters ()
         :precondition 
           (and
             (C05382)
             (C00118)
                    )
         :effect
           (and
             (C00231)
             (C00117)
	         (increase (total-cost) 1)))

    (:action reaction_R01641right
           :parameters ()
         :precondition 
           (and
             (C00231)
             (C00117)
                    )
         :effect
           (and
             (C05382)
             (C00118)
	         (increase (total-cost) 1)))

    (:action reaction_R01737left
           :parameters ()
         :precondition 
           (and
             (C00257)
                    )
         :effect
           (and
             (C00345)
	         (increase (total-cost) 1)))

    (:action reaction_R01741left
           :parameters ()
         :precondition 
           (and
             (C00257)
                    )
         :effect
           (and
             (C06473)
	         (increase (total-cost) 1)))

    (:action reaction_R01827left
           :parameters ()
         :precondition 
           (and
             (C05382)
             (C00118)
                    )
         :effect
           (and
             (C00279)
             (C05345)
	         (increase (total-cost) 1)))

    (:action reaction_R01827right
           :parameters ()
         :precondition 
           (and
             (C00279)
             (C05345)
                    )
         :effect
           (and
             (C05382)
             (C00118)
	         (increase (total-cost) 1)))

    (:action reaction_R01830left
           :parameters ()
         :precondition 
           (and
             (C05345)
             (C00118)
                    )
         :effect
           (and
             (C00279)
             (C00231)
	         (increase (total-cost) 1)))

    (:action reaction_R01830right
           :parameters ()
         :precondition 
           (and
             (C00279)
             (C00231)
                    )
         :effect
           (and
             (C05345)
             (C00118)
	         (increase (total-cost) 1)))

    (:action reaction_R02035left
           :parameters ()
         :precondition 
           (and
             (C01236)
                    )
         :effect
           (and
             (C00345)
	         (increase (total-cost) 1)))

    (:action reaction_R02035right
           :parameters ()
         :precondition 
           (and
             (C00345)
                    )
         :effect
           (and
             (C01236)
	         (increase (total-cost) 1)))

    (:action reaction_R02036left
           :parameters ()
         :precondition 
           (and
             (C00345)
                    )
         :effect
           (and
             (C04442)
	         (increase (total-cost) 1)))

    (:action reaction_R02736left
           :parameters ()
         :precondition 
           (and
             (C01172)
                    )
         :effect
           (and
             (C01236)
	         (increase (total-cost) 1)))

    

    

    

    

    

    

    (:action reaction_R05605left
           :parameters ()
         :precondition 
           (and
             (C04442)
                    )
         :effect
           (and
             (C00022)
             (C00118)
	         (increase (total-cost) 1)))

    (:action reaction_R05605right
           :parameters ()
         :precondition 
           (and
             (C00022)
             (C00118)
                    )
         :effect
           (and
             (C04442)
	         (increase (total-cost) 1)))

    (:action reaction_R06836left
           :parameters ()
         :precondition 
           (and
             (C01151)
                    )
         :effect
           (and
             (C00119)
	         (increase (total-cost) 1)))

    (:action reaction_R00286left
           :parameters ()
         :precondition 
           (and
             (C00029)
                    )
         :effect
           (and
             (C00167)
	         (increase (total-cost) 1)))

    (:action reaction_R00286right
           :parameters ()
         :precondition 
           (and
             (C00167)
                    )
         :effect
           (and
             (C00029)
	         (increase (total-cost) 1)))

    (:action reaction_R00289left
           :parameters ()
         :precondition 
           (and
             (C00103)
                    )
         :effect
           (and
             (C00029)
	         (increase (total-cost) 1)))

    

    

    

    (:action reaction_R01541right
           :parameters ()
         :precondition 
           (and
             (C04442)
                    )
         :effect
           (and
             (C00204)
	         (increase (total-cost) 1)))

    (:action reaction_R01639left
           :parameters ()
         :precondition 
           (and
             (C00310)
                    )
         :effect
           (and
             (C00231)
	         (increase (total-cost) 1)))

    (:action reaction_R01639right
           :parameters ()
         :precondition 
           (and
             (C00231)
                    )
         :effect
           (and
             (C00310)
	         (increase (total-cost) 1)))

    (:action reaction_R02454left
           :parameters ()
         :precondition 
           (and
             (C00514)
                    )
         :effect
           (and
             (C00905)
	         (increase (total-cost) 1)))

    (:action reaction_R02454right
           :parameters ()
         :precondition 
           (and
             (C00905)
                    )
         :effect
           (and
             (C00514)
	         (increase (total-cost) 1)))

    (:action reaction_R05605left-variant-2
           :parameters ()
         :precondition 
           (and
             (C04442)
                    )
         :effect
           (and
             (C00118)
	         (increase (total-cost) 1)))

    (:action reaction_R05605right-variant-2
           :parameters ()
         :precondition 
           (and
             (C00118)
                    )
         :effect
           (and
             (C04442)
	         (increase (total-cost) 1)))

    (:action reaction_R00867left
           :parameters ()
         :precondition 
           (and
             (C00095)
                    )
         :effect
           (and
             (C05345)
	         (increase (total-cost) 1)))

    

    

    

    

    (:action reaction_R02071left
           :parameters ()
         :precondition 
           (and
             (C01094)
                    )
         :effect
           (and
             (C05378)
	         (increase (total-cost) 1)))

    (:action reaction_R02071right
           :parameters ()
         :precondition 
           (and
             (C05378)
                    )
         :effect
           (and
             (C01094)
	         (increase (total-cost) 1)))

    (:action reaction_R02568left
           :parameters ()
         :precondition 
           (and
             (C01094)
                    )
         :effect
           (and
             (C00577)
             (C00111)
	         (increase (total-cost) 1)))

    (:action reaction_R02568right
           :parameters ()
         :precondition 
           (and
             (C00577)
             (C00111)
                    )
         :effect
           (and
             (C01094)
	         (increase (total-cost) 1)))

    (:action reaction_R02630left
           :parameters ()
         :precondition 
           (and
             (C00159)
                    )
         :effect
           (and
             (C00275)
	         (increase (total-cost) 1)))

    (:action reaction_R02704left
           :parameters ()
         :precondition 
           (and
             (C00392)
                    )
         :effect
           (and
             (C00644)
	         (increase (total-cost) 1)))

    (:action reaction_R03232left
           :parameters ()
         :precondition 
           (and
             (C00095)
                    )
         :effect
           (and
             (C01094)
	         (increase (total-cost) 1)))

    (:action reaction_R03774left
           :parameters ()
         :precondition 
           (and
             (C01934)
                    )
         :effect
           (and
             (C03979)
	         (increase (total-cost) 1)))

    (:action reaction_R03774right
           :parameters ()
         :precondition 
           (and
             (C03979)
                    )
         :effect
           (and
             (C01934)
	         (increase (total-cost) 1)))

    (:action reaction_R04076left
           :parameters ()
         :precondition 
           (and
             (C00247)
                    )
         :effect
           (and
             (C02888)
	         (increase (total-cost) 1)))

    

    

    (:action reaction_R05820left
           :parameters ()
         :precondition 
           (and
             (C00794)
                    )
         :effect
           (and
             (C01096)
	         (increase (total-cost) 1)))

    

    (:action reaction_R00289right
           :parameters ()
         :precondition 
           (and
             (C00029)
                    )
         :effect
           (and
             (C00103)
	         (increase (total-cost) 1)))

    (:action reaction_R00291left
           :parameters ()
         :precondition 
           (and
             (C00029)
                    )
         :effect
           (and
             (C00052)
	         (increase (total-cost) 1)))

    (:action reaction_R00291right
           :parameters ()
         :precondition 
           (and
             (C00052)
                    )
         :effect
           (and
             (C00029)
	         (increase (total-cost) 1)))

    (:action reaction_R01064left
           :parameters ()
         :precondition 
           (and
             (C01286)
                    )
         :effect
           (and
             (C00118)
	         (increase (total-cost) 1)))

    (:action reaction_R01101left
           :parameters ()
         :precondition 
           (and
             (C05402)
                    )
         :effect
           (and
             (C00124)
             (C00031)
	         (increase (total-cost) 1)))

    (:action reaction_R01103left
           :parameters ()
         :precondition 
           (and
             (C00492)
                    )
         :effect
           (and
             (C00089)
	         (increase (total-cost) 1)))

    (:action reaction_R01104left
           :parameters ()
         :precondition 
           (and
             (C05401)
                    )
         :effect
           (and
             (C00124)
             (C00116)
	         (increase (total-cost) 1)))

    (:action reaction_R01104right
           :parameters ()
         :precondition 
           (and
             (C00124)
             (C00116)
                    )
         :effect
           (and
             (C05401)
	         (increase (total-cost) 1)))

    (:action reaction_R01194left
           :parameters ()
         :precondition 
           (and
             (C01235)
                    )
         :effect
           (and
             (C00137)
             (C00124)
	         (increase (total-cost) 1)))

    (:action reaction_R01194right
           :parameters ()
         :precondition 
           (and
             (C00137)
             (C00124)
                    )
         :effect
           (and
             (C01235)
	         (increase (total-cost) 1)))

    (:action reaction_R01329left
           :parameters ()
         :precondition 
           (and
             (C05400)
                    )
         :effect
           (and
             (C00159)
             (C00124)
	         (increase (total-cost) 1)))

    (:action reaction_R01329right
           :parameters ()
         :precondition 
           (and
             (C00159)
             (C00124)
                    )
         :effect
           (and
             (C05400)
	         (increase (total-cost) 1)))

    

    (:action reaction_R01786right
           :parameters ()
         :precondition 
           (and
             (C00668)
                    )
         :effect
           (and
             (C00267)
	         (increase (total-cost) 1)))

    (:action reaction_R02410left
           :parameters ()
         :precondition 
           (and
             (C00492)
                    )
         :effect
           (and
             (C05402)
	         (increase (total-cost) 1)))

    (:action reaction_R02926left
           :parameters ()
         :precondition 
           (and
             (C05399)
                    )
         :effect
           (and
             (C00794)
             (C00124)
	         (increase (total-cost) 1)))

    (:action reaction_R02926right
           :parameters ()
         :precondition 
           (and
             (C00794)
             (C00124)
                    )
         :effect
           (and
             (C05399)
	         (increase (total-cost) 1)))

    (:action reaction_R03033left
           :parameters ()
         :precondition 
           (and
             (C00880)
                    )
         :effect
           (and
             (C01216)
	         (increase (total-cost) 1)))

    (:action reaction_R03236left
           :parameters ()
         :precondition 
           (and
             (C01097)
                    )
         :effect
           (and
             (C03785)
	         (increase (total-cost) 1)))

    (:action reaction_R03236right
           :parameters ()
         :precondition 
           (and
             (C03785)
                    )
         :effect
           (and
             (C01097)
	         (increase (total-cost) 1)))

    (:action reaction_R03237left
           :parameters ()
         :precondition 
           (and
             (C01097)
                    )
         :effect
           (and
             (C03785)
	         (increase (total-cost) 1)))

    (:action reaction_R03237right
           :parameters ()
         :precondition 
           (and
             (C03785)
                    )
         :effect
           (and
             (C01097)
	         (increase (total-cost) 1)))

    (:action reaction_R03238left
           :parameters ()
         :precondition 
           (and
             (C01097)
                    )
         :effect
           (and
             (C03785)
	         (increase (total-cost) 1)))

    (:action reaction_R03238right
           :parameters ()
         :precondition 
           (and
             (C03785)
                    )
         :effect
           (and
             (C01097)
	         (increase (total-cost) 1)))

    (:action reaction_R03239left
           :parameters ()
         :precondition 
           (and
             (C01097)
                    )
         :effect
           (and
             (C03785)
	         (increase (total-cost) 1)))

    (:action reaction_R03239right
           :parameters ()
         :precondition 
           (and
             (C03785)
                    )
         :effect
           (and
             (C01097)
	         (increase (total-cost) 1)))

    (:action reaction_R03387left
           :parameters ()
         :precondition 
           (and
             (C01216)
                    )
         :effect
           (and
             (C01286)
	         (increase (total-cost) 1)))

    (:action reaction_R03634left
           :parameters ()
         :precondition 
           (and
             (C01613)
                    )
         :effect
           (and
             (C00124)
             (C00492)
	         (increase (total-cost) 1)))

    (:action reaction_R03635left
           :parameters ()
         :precondition 
           (and
             (C01613)
                    )
         :effect
           (and
             (C05404)
	         (increase (total-cost) 1)))

    (:action reaction_R05549left
           :parameters ()
         :precondition 
           (and
             (C05404)
                    )
         :effect
           (and
             (C00124)
             (C05402)
	         (increase (total-cost) 1)))

    

    (:action reaction_R02279left
           :parameters ()
         :precondition 
           (and
             (C00679)
                    )
         :effect
           (and
             (C00433)
	         (increase (total-cost) 1)))

    (:action reaction_R02279right
           :parameters ()
         :precondition 
           (and
             (C00433)
                    )
         :effect
           (and
             (C00679)
	         (increase (total-cost) 1)))

    (:action reaction_R02957left
           :parameters ()
         :precondition 
           (and
             (C02670)
                    )
         :effect
           (and
             (C00818)
	         (increase (total-cost) 1)))

    (:action reaction_R02957right
           :parameters ()
         :precondition 
           (and
             (C00818)
                    )
         :effect
           (and
             (C02670)
	         (increase (total-cost) 1)))

    (:action reaction_R05608left
           :parameters ()
         :precondition 
           (and
             (C00879)
                    )
         :effect
           (and
             (C00679)
	         (increase (total-cost) 1)))

    (:action reaction_R05608right
           :parameters ()
         :precondition 
           (and
             (C00679)
                    )
         :effect
           (and
             (C00879)
	         (increase (total-cost) 1)))

    (:action reaction_R07675left
           :parameters ()
         :precondition 
           (and
             (C01825)
                    )
         :effect
           (and
             (C01115)
	         (increase (total-cost) 1)))

    (:action reaction_R01626left
           :parameters ()
         :precondition 
           (and
             (C00083)
                    )
         :effect
           (and
             (C01209)
	         (increase (total-cost) 1)))

    (:action reaction_R01626right
           :parameters ()
         :precondition 
           (and
             (C01209)
                    )
         :effect
           (and
             (C00083)
	         (increase (total-cost) 1)))

    (:action reaction_R04355left
           :parameters ()
         :precondition 
           (and
             (C01209)
             (C03939)
                    )
         :effect
           (and
             (C05744)
	         (increase (total-cost) 1)))

    (:action reaction_R04385left
           :parameters ()
         :precondition 
           (and
             (C06250)
                    )
         :effect
           (and
             (C04419)
	         (increase (total-cost) 1)))

    (:action reaction_R04386left
           :parameters ()
         :precondition 
           (and
             (C04419)
             (C00024)
                    )
         :effect
           (and
             (C06250)
             (C00083)
	         (increase (total-cost) 1)))

    (:action reaction_R04386right
           :parameters ()
         :precondition 
           (and
             (C06250)
             (C00083)
                    )
         :effect
           (and
             (C04419)
             (C00024)
	         (increase (total-cost) 1)))

    (:action reaction_R04429left
           :parameters ()
         :precondition 
           (and
             (C04246)
                    )
         :effect
           (and
             (C05745)
	         (increase (total-cost) 1)))

    (:action reaction_R04429right
           :parameters ()
         :precondition 
           (and
             (C05745)
                    )
         :effect
           (and
             (C04246)
	         (increase (total-cost) 1)))

    (:action reaction_R04533left
           :parameters ()
         :precondition 
           (and
             (C04618)
                    )
         :effect
           (and
             (C05744)
	         (increase (total-cost) 1)))

    (:action reaction_R04533right
           :parameters ()
         :precondition 
           (and
             (C05744)
                    )
         :effect
           (and
             (C04618)
	         (increase (total-cost) 1)))

    (:action reaction_R04534left
           :parameters ()
         :precondition 
           (and
             (C05753)
                    )
         :effect
           (and
             (C04619)
	         (increase (total-cost) 1)))

    (:action reaction_R04534right
           :parameters ()
         :precondition 
           (and
             (C04619)
                    )
         :effect
           (and
             (C05753)
	         (increase (total-cost) 1)))

    (:action reaction_R04535left
           :parameters ()
         :precondition 
           (and
             (C04619)
                    )
         :effect
           (and
             (C05754)
	         (increase (total-cost) 1)))

    (:action reaction_R04535right
           :parameters ()
         :precondition 
           (and
             (C05754)
                    )
         :effect
           (and
             (C04619)
	         (increase (total-cost) 1)))

    (:action reaction_R04536left
           :parameters ()
         :precondition 
           (and
             (C05750)
                    )
         :effect
           (and
             (C04620)
	         (increase (total-cost) 1)))

    (:action reaction_R04536right
           :parameters ()
         :precondition 
           (and
             (C04620)
                    )
         :effect
           (and
             (C05750)
	         (increase (total-cost) 1)))

    (:action reaction_R04543left
           :parameters ()
         :precondition 
           (and
             (C05762)
                    )
         :effect
           (and
             (C04633)
	         (increase (total-cost) 1)))

    (:action reaction_R04543right
           :parameters ()
         :precondition 
           (and
             (C04633)
                    )
         :effect
           (and
             (C05762)
	         (increase (total-cost) 1)))

    (:action reaction_R04566left
           :parameters ()
         :precondition 
           (and
             (C05759)
                    )
         :effect
           (and
             (C04688)
	         (increase (total-cost) 1)))

    (:action reaction_R04566right
           :parameters ()
         :precondition 
           (and
             (C04688)
                    )
         :effect
           (and
             (C05759)
	         (increase (total-cost) 1)))

    (:action reaction_R04724left
           :parameters ()
         :precondition 
           (and
             (C05758)
                    )
         :effect
           (and
             (C05223)
	         (increase (total-cost) 1)))

    (:action reaction_R04724right
           :parameters ()
         :precondition 
           (and
             (C05223)
                    )
         :effect
           (and
             (C05758)
	         (increase (total-cost) 1)))

    (:action reaction_R04726left
           :parameters ()
         :precondition 
           (and
             (C01209)
             (C05223)
                    )
         :effect
           (and
             (C05759)
	         (increase (total-cost) 1)))

    (:action reaction_R04952left
           :parameters ()
         :precondition 
           (and
             (C01209)
             (C05745)
                    )
         :effect
           (and
             (C05746)
	         (increase (total-cost) 1)))

    (:action reaction_R04953left
           :parameters ()
         :precondition 
           (and
             (C05746)
                    )
         :effect
           (and
             (C05747)
	         (increase (total-cost) 1)))

    (:action reaction_R04953right
           :parameters ()
         :precondition 
           (and
             (C05747)
                    )
         :effect
           (and
             (C05746)
	         (increase (total-cost) 1)))

    (:action reaction_R04955left
           :parameters ()
         :precondition 
           (and
             (C05748)
                    )
         :effect
           (and
             (C05749)
	         (increase (total-cost) 1)))

    (:action reaction_R04955right
           :parameters ()
         :precondition 
           (and
             (C05749)
                    )
         :effect
           (and
             (C05748)
	         (increase (total-cost) 1)))

    (:action reaction_R04957left
           :parameters ()
         :precondition 
           (and
             (C01209)
             (C05749)
                    )
         :effect
           (and
             (C05750)
	         (increase (total-cost) 1)))

    (:action reaction_R04958left
           :parameters ()
         :precondition 
           (and
             (C05751)
                    )
         :effect
           (and
             (C05752)
	         (increase (total-cost) 1)))

    (:action reaction_R04958right
           :parameters ()
         :precondition 
           (and
             (C05752)
                    )
         :effect
           (and
             (C05751)
	         (increase (total-cost) 1)))

    (:action reaction_R04960left
           :parameters ()
         :precondition 
           (and
             (C01209)
             (C05752)
                    )
         :effect
           (and
             (C05753)
	         (increase (total-cost) 1)))

    (:action reaction_R04961left
           :parameters ()
         :precondition 
           (and
             (C05754)
                    )
         :effect
           (and
             (C05755)
	         (increase (total-cost) 1)))

    (:action reaction_R04961right
           :parameters ()
         :precondition 
           (and
             (C05755)
                    )
         :effect
           (and
             (C05754)
	         (increase (total-cost) 1)))

    (:action reaction_R04963left
           :parameters ()
         :precondition 
           (and
             (C01209)
             (C05755)
                    )
         :effect
           (and
             (C05756)
	         (increase (total-cost) 1)))

    (:action reaction_R04964left
           :parameters ()
         :precondition 
           (and
             (C05756)
                    )
         :effect
           (and
             (C05757)
	         (increase (total-cost) 1)))

    (:action reaction_R04964right
           :parameters ()
         :precondition 
           (and
             (C05757)
                    )
         :effect
           (and
             (C05756)
	         (increase (total-cost) 1)))

    (:action reaction_R04965left
           :parameters ()
         :precondition 
           (and
             (C05757)
                    )
         :effect
           (and
             (C05758)
	         (increase (total-cost) 1)))

    (:action reaction_R04965right
           :parameters ()
         :precondition 
           (and
             (C05758)
                    )
         :effect
           (and
             (C05757)
	         (increase (total-cost) 1)))

    (:action reaction_R04966left
           :parameters ()
         :precondition 
           (and
             (C05760)
                    )
         :effect
           (and
             (C05761)
	         (increase (total-cost) 1)))

    (:action reaction_R04966right
           :parameters ()
         :precondition 
           (and
             (C05761)
                    )
         :effect
           (and
             (C05760)
	         (increase (total-cost) 1)))

    (:action reaction_R04968left
           :parameters ()
         :precondition 
           (and
             (C01209)
             (C05761)
                    )
         :effect
           (and
             (C05762)
	         (increase (total-cost) 1)))

    (:action reaction_R04969left
           :parameters ()
         :precondition 
           (and
             (C05763)
                    )
         :effect
           (and
             (C05764)
	         (increase (total-cost) 1)))

    (:action reaction_R04969right
           :parameters ()
         :precondition 
           (and
             (C05764)
                    )
         :effect
           (and
             (C05763)
	         (increase (total-cost) 1)))

    (:action reaction_R07762left
           :parameters ()
         :precondition 
           (and
             (C01209)
             (C05764)
                    )
         :effect
           (and
             (C16219)
	         (increase (total-cost) 1)))

    (:action reaction_R07762right
           :parameters ()
         :precondition 
           (and
             (C16219)
                    )
         :effect
           (and
             (C01209)
             (C05764)
	         (increase (total-cost) 1)))

    (:action reaction_R07763left
           :parameters ()
         :precondition 
           (and
             (C16219)
                    )
         :effect
           (and
             (C16220)
	         (increase (total-cost) 1)))

    (:action reaction_R07763right
           :parameters ()
         :precondition 
           (and
             (C16220)
                    )
         :effect
           (and
             (C16219)
	         (increase (total-cost) 1)))

    (:action reaction_R07764left
           :parameters ()
         :precondition 
           (and
             (C16220)
                    )
         :effect
           (and
             (C16221)
	         (increase (total-cost) 1)))

    (:action reaction_R07764right
           :parameters ()
         :precondition 
           (and
             (C16221)
                    )
         :effect
           (and
             (C16220)
	         (increase (total-cost) 1)))

    (:action reaction_R04170left
           :parameters ()
         :precondition 
           (and
             (C05262)
                    )
         :effect
           (and
             (C03221)
	         (increase (total-cost) 1)))

    (:action reaction_R04170right
           :parameters ()
         :precondition 
           (and
             (C03221)
                    )
         :effect
           (and
             (C05262)
	         (increase (total-cost) 1)))

    (:action reaction_R04737left
           :parameters ()
         :precondition 
           (and
             (C05259)
                    )
         :effect
           (and
             (C05258)
	         (increase (total-cost) 1)))

    (:action reaction_R04737right
           :parameters ()
         :precondition 
           (and
             (C05258)
                    )
         :effect
           (and
             (C05259)
	         (increase (total-cost) 1)))

    (:action reaction_R04738left
           :parameters ()
         :precondition 
           (and
             (C05258)
                    )
         :effect
           (and
             (C05272)
	         (increase (total-cost) 1)))

    (:action reaction_R04738right
           :parameters ()
         :precondition 
           (and
             (C05272)
                    )
         :effect
           (and
             (C05258)
	         (increase (total-cost) 1)))

    (:action reaction_R04739left
           :parameters ()
         :precondition 
           (and
             (C05261)
                    )
         :effect
           (and
             (C05260)
	         (increase (total-cost) 1)))

    (:action reaction_R04739right
           :parameters ()
         :precondition 
           (and
             (C05260)
                    )
         :effect
           (and
             (C05261)
	         (increase (total-cost) 1)))

    (:action reaction_R04740left
           :parameters ()
         :precondition 
           (and
             (C05260)
                    )
         :effect
           (and
             (C05273)
	         (increase (total-cost) 1)))

    (:action reaction_R04740right
           :parameters ()
         :precondition 
           (and
             (C05273)
                    )
         :effect
           (and
             (C05260)
	         (increase (total-cost) 1)))

    (:action reaction_R04741left
           :parameters ()
         :precondition 
           (and
             (C05263)
                    )
         :effect
           (and
             (C05262)
	         (increase (total-cost) 1)))

    (:action reaction_R04741right
           :parameters ()
         :precondition 
           (and
             (C05262)
                    )
         :effect
           (and
             (C05263)
	         (increase (total-cost) 1)))

    (:action reaction_R04743left
           :parameters ()
         :precondition 
           (and
             (C05265)
                    )
         :effect
           (and
             (C05264)
	         (increase (total-cost) 1)))

    (:action reaction_R04743right
           :parameters ()
         :precondition 
           (and
             (C05264)
                    )
         :effect
           (and
             (C05265)
	         (increase (total-cost) 1)))

    (:action reaction_R04744left
           :parameters ()
         :precondition 
           (and
             (C05264)
                    )
         :effect
           (and
             (C05275)
	         (increase (total-cost) 1)))

    (:action reaction_R04744right
           :parameters ()
         :precondition 
           (and
             (C05275)
                    )
         :effect
           (and
             (C05264)
	         (increase (total-cost) 1)))

    (:action reaction_R04745left
           :parameters ()
         :precondition 
           (and
             (C05267)
                    )
         :effect
           (and
             (C05266)
	         (increase (total-cost) 1)))

    (:action reaction_R04745right
           :parameters ()
         :precondition 
           (and
             (C05266)
                    )
         :effect
           (and
             (C05267)
	         (increase (total-cost) 1)))

    (:action reaction_R04746left
           :parameters ()
         :precondition 
           (and
             (C05266)
                    )
         :effect
           (and
             (C05276)
	         (increase (total-cost) 1)))

    (:action reaction_R04746right
           :parameters ()
         :precondition 
           (and
             (C05276)
                    )
         :effect
           (and
             (C05266)
	         (increase (total-cost) 1)))

    (:action reaction_R04748left
           :parameters ()
         :precondition 
           (and
             (C05269)
                    )
         :effect
           (and
             (C05268)
	         (increase (total-cost) 1)))

    (:action reaction_R04748right
           :parameters ()
         :precondition 
           (and
             (C05268)
                    )
         :effect
           (and
             (C05269)
	         (increase (total-cost) 1)))

    (:action reaction_R04749left
           :parameters ()
         :precondition 
           (and
             (C05268)
                    )
         :effect
           (and
             (C05271)
	         (increase (total-cost) 1)))

    (:action reaction_R04749right
           :parameters ()
         :precondition 
           (and
             (C05271)
                    )
         :effect
           (and
             (C05268)
	         (increase (total-cost) 1)))

    (:action reaction_R00238left
           :parameters ()
         :precondition 
           (and
             (C00024)
                    )
         :effect
           (and
             (C00332)
	         (increase (total-cost) 1)))

    (:action reaction_R00238right
           :parameters ()
         :precondition 
           (and
             (C00332)
                    )
         :effect
           (and
             (C00024)
	         (increase (total-cost) 1)))

    (:action reaction_R00623left
           :parameters ()
         :precondition 
           (and
             (C00226)
                    )
         :effect
           (and
             (C00071)
	         (increase (total-cost) 1)))

    (:action reaction_R00623right
           :parameters ()
         :precondition 
           (and
             (C00071)
                    )
         :effect
           (and
             (C00226)
	         (increase (total-cost) 1)))

    (:action reaction_R00631left
           :parameters ()
         :precondition 
           (and
             (C00162)
                    )
         :effect
           (and
             (C00071)
	         (increase (total-cost) 1)))

    (:action reaction_R01175left
           :parameters ()
         :precondition 
           (and
             (C00136)
                    )
         :effect
           (and
             (C00877)
	         (increase (total-cost) 1)))

    (:action reaction_R01177left
           :parameters ()
         :precondition 
           (and
             (C00136)
             (C00024)
                    )
         :effect
           (and
             (C05269)
             (C00010)
	         (increase (total-cost) 1)))

    (:action reaction_R01177right
           :parameters ()
         :precondition 
           (and
             (C05269)
             (C00010)
                    )
         :effect
           (and
             (C00136)
             (C00024)
	         (increase (total-cost) 1)))

    (:action reaction_R01279left
           :parameters ()
         :precondition 
           (and
             (C00154)
                    )
         :effect
           (and
             (C05272)
	         (increase (total-cost) 1)))

    (:action reaction_R01406left
           :parameters ()
         :precondition 
           (and
             (C00638)
             (C00229)
                    )
         :effect
           (and
             (C00173)
	         (increase (total-cost) 1)))

    (:action reaction_R01406right
           :parameters ()
         :precondition 
           (and
             (C00173)
                    )
         :effect
           (and
             (C00638)
             (C00229)
	         (increase (total-cost) 1)))

    (:action reaction_R01975left
           :parameters ()
         :precondition 
           (and
             (C01144)
                    )
         :effect
           (and
             (C00332)
	         (increase (total-cost) 1)))

    (:action reaction_R01975right
           :parameters ()
         :precondition 
           (and
             (C00332)
                    )
         :effect
           (and
             (C01144)
	         (increase (total-cost) 1)))

    (:action reaction_R02487left
           :parameters ()
         :precondition 
           (and
             (C00527)
                    )
         :effect
           (and
             (C00877)
	         (increase (total-cost) 1)))

    (:action reaction_R03026left
           :parameters ()
         :precondition 
           (and
             (C01144)
                    )
         :effect
           (and
             (C00877)
	         (increase (total-cost) 1)))

    (:action reaction_R03026right
           :parameters ()
         :precondition 
           (and
             (C00877)
                    )
         :effect
           (and
             (C01144)
	         (increase (total-cost) 1)))

    (:action reaction_R03276left
           :parameters ()
         :precondition 
           (and
             (C01144)
                    )
         :effect
           (and
             (C03561)
	         (increase (total-cost) 1)))

    (:action reaction_R03276right
           :parameters ()
         :precondition 
           (and
             (C03561)
                    )
         :effect
           (and
             (C01144)
	         (increase (total-cost) 1)))

    (:action reaction_R03777left
           :parameters ()
         :precondition 
           (and
             (C01944)
                    )
         :effect
           (and
             (C05276)
	         (increase (total-cost) 1)))

    (:action reaction_R03778left
           :parameters ()
         :precondition 
           (and
             (C00024)
             (C01944)
                    )
         :effect
           (and
             (C05265)
             (C00010)
	         (increase (total-cost) 1)))

    (:action reaction_R03778right
           :parameters ()
         :precondition 
           (and
             (C05265)
             (C00010)
                    )
         :effect
           (and
             (C00024)
             (C01944)
	         (increase (total-cost) 1)))

    (:action reaction_R03857left
           :parameters ()
         :precondition 
           (and
             (C01832)
                    )
         :effect
           (and
             (C03221)
	         (increase (total-cost) 1)))

    (:action reaction_R03858left
           :parameters ()
         :precondition 
           (and
             (C01832)
             (C00024)
                    )
         :effect
           (and
             (C00010)
             (C05261)
	         (increase (total-cost) 1)))

    (:action reaction_R03858right
           :parameters ()
         :precondition 
           (and
             (C00010)
             (C05261)
                    )
         :effect
           (and
             (C01832)
             (C00024)
	         (increase (total-cost) 1)))

    (:action reaction_R03990left
           :parameters ()
         :precondition 
           (and
             (C02593)
                    )
         :effect
           (and
             (C05273)
	         (increase (total-cost) 1)))

    (:action reaction_R03991left
           :parameters ()
         :precondition 
           (and
             (C02593)
             (C00024)
                    )
         :effect
           (and
             (C05259)
             (C00010)
	         (increase (total-cost) 1)))

    (:action reaction_R03991right
           :parameters ()
         :precondition 
           (and
             (C05259)
             (C00010)
                    )
         :effect
           (and
             (C02593)
             (C00024)
	         (increase (total-cost) 1)))

    

    

    (:action reaction_R04737left-variant-2
           :parameters ()
         :precondition 
           (and
             (C05258)
                    )
         :effect
           (and
             (C05259)
	         (increase (total-cost) 1)))

    (:action reaction_R04737right-variant-2
           :parameters ()
         :precondition 
           (and
             (C05259)
                    )
         :effect
           (and
             (C05258)
	         (increase (total-cost) 1)))

    

    

    (:action reaction_R04739left-variant-2
           :parameters ()
         :precondition 
           (and
             (C05260)
                    )
         :effect
           (and
             (C05261)
	         (increase (total-cost) 1)))

    (:action reaction_R04739right-variant-2
           :parameters ()
         :precondition 
           (and
             (C05261)
                    )
         :effect
           (and
             (C05260)
	         (increase (total-cost) 1)))

    

    

    (:action reaction_R04741left-variant-2
           :parameters ()
         :precondition 
           (and
             (C05262)
                    )
         :effect
           (and
             (C05263)
	         (increase (total-cost) 1)))

    (:action reaction_R04741right-variant-2
           :parameters ()
         :precondition 
           (and
             (C05263)
                    )
         :effect
           (and
             (C05262)
	         (increase (total-cost) 1)))

    (:action reaction_R04742left
           :parameters ()
         :precondition 
           (and
             (C00024)
             (C05274)
                    )
         :effect
           (and
             (C00010)
             (C05263)
	         (increase (total-cost) 1)))

    (:action reaction_R04742right
           :parameters ()
         :precondition 
           (and
             (C00010)
             (C05263)
                    )
         :effect
           (and
             (C00024)
             (C05274)
	         (increase (total-cost) 1)))

    (:action reaction_R04743left-variant-2
           :parameters ()
         :precondition 
           (and
             (C05264)
                    )
         :effect
           (and
             (C05265)
	         (increase (total-cost) 1)))

    (:action reaction_R04743right-variant-2
           :parameters ()
         :precondition 
           (and
             (C05265)
                    )
         :effect
           (and
             (C05264)
	         (increase (total-cost) 1)))

    

    

    (:action reaction_R04745left-variant-2
           :parameters ()
         :precondition 
           (and
             (C05266)
                    )
         :effect
           (and
             (C05267)
	         (increase (total-cost) 1)))

    (:action reaction_R04745right-variant-2
           :parameters ()
         :precondition 
           (and
             (C05267)
                    )
         :effect
           (and
             (C05266)
	         (increase (total-cost) 1)))

    

    

    (:action reaction_R04747left
           :parameters ()
         :precondition 
           (and
             (C05270)
             (C00024)
                    )
         :effect
           (and
             (C05267)
             (C00010)
	         (increase (total-cost) 1)))

    (:action reaction_R04747right
           :parameters ()
         :precondition 
           (and
             (C05267)
             (C00010)
                    )
         :effect
           (and
             (C05270)
             (C00024)
	         (increase (total-cost) 1)))

    (:action reaction_R04748left-variant-2
           :parameters ()
         :precondition 
           (and
             (C05268)
                    )
         :effect
           (and
             (C05269)
	         (increase (total-cost) 1)))

    (:action reaction_R04748right-variant-2
           :parameters ()
         :precondition 
           (and
             (C05269)
                    )
         :effect
           (and
             (C05268)
	         (increase (total-cost) 1)))

    

    

    (:action reaction_R04754left
           :parameters ()
         :precondition 
           (and
             (C05274)
                    )
         :effect
           (and
             (C05275)
	         (increase (total-cost) 1)))

    (:action reaction_R04756left
           :parameters ()
         :precondition 
           (and
             (C05280)
                    )
         :effect
           (and
             (C05279)
	         (increase (total-cost) 1)))

    (:action reaction_R04756right
           :parameters ()
         :precondition 
           (and
             (C05279)
                    )
         :effect
           (and
             (C05280)
	         (increase (total-cost) 1)))


)
