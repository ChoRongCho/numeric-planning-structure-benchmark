begin_version
4
end_version
begin_metric
< 39
end_metric
25
begin_variable
var0
-1
7
Atom at-robot(robot1, base)
Atom at-robot(robot1, zone1)
Atom at-robot(robot1, zone2)
Atom at-robot(robot1, zone3)
Atom at-robot(robot1, zone4)
Atom at-robot(robot1, zone5)
Atom at-robot(robot1, zone6)
end_variable
begin_variable
var1
-1
8
Atom container-at(watering-can1, base)
Atom container-at(watering-can1, zone1)
Atom container-at(watering-can1, zone2)
Atom container-at(watering-can1, zone3)
Atom container-at(watering-can1, zone4)
Atom container-at(watering-can1, zone5)
Atom container-at(watering-can1, zone6)
Atom holding(robot1, watering-can1)
end_variable
begin_variable
var2
-1
2
Atom hand-free(robot1)
NegatedAtom hand-free(robot1)
end_variable
begin_variable
var3
26
2
Atom new-axiom@0()
NegatedAtom new-axiom@0()
end_variable
begin_variable
var4
26
2
Atom new-axiom@1()
NegatedAtom new-axiom@1()
end_variable
begin_variable
var5
25
3
>= 34 19
< 34 19
<none of those>
end_variable
begin_variable
var6
25
3
< 10 19
>= 10 19
<none of those>
end_variable
begin_variable
var7
25
3
>= 24 19
< 24 19
<none of those>
end_variable
begin_variable
var8
25
3
>= 14 19
< 14 19
<none of those>
end_variable
begin_variable
var9
25
3
>= 32 19
< 32 19
<none of those>
end_variable
begin_variable
var10
25
3
< 8 19
>= 8 19
<none of those>
end_variable
begin_variable
var11
25
3
>= 20 19
< 20 19
<none of those>
end_variable
begin_variable
var12
25
3
>= 17 19
< 17 19
<none of those>
end_variable
begin_variable
var13
25
3
< 22 19
>= 22 19
<none of those>
end_variable
begin_variable
var14
25
3
>= 31 19
< 31 19
<none of those>
end_variable
begin_variable
var15
25
3
< 21 19
>= 21 19
<none of those>
end_variable
begin_variable
var16
25
3
< 7 19
>= 7 19
<none of those>
end_variable
begin_variable
var17
25
3
< 27 19
>= 27 19
<none of those>
end_variable
begin_variable
var18
25
3
>= 36 19
< 36 19
<none of those>
end_variable
begin_variable
var19
25
3
< 0 19
>= 0 19
<none of those>
end_variable
begin_variable
var20
25
3
>= 22 19
< 22 19
<none of those>
end_variable
begin_variable
var21
25
3
>= 21 19
< 21 19
<none of those>
end_variable
begin_variable
var22
25
3
>= 8 19
< 8 19
<none of those>
end_variable
begin_variable
var23
25
3
>= 0 19
< 0 19
<none of those>
end_variable
begin_variable
var24
25
3
>= 7 19
< 7 19
<none of those>
end_variable
46
begin_numeric_variables
D 17 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant5, plant5)
D 15 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant2, plant5)
D 22 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant2, plant3)
D 23 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant3, plant5)
D 18 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant1, plant3)
D 24 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant4, plant3)
D 21 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant4, plant5)
D 20 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant3, plant3)
D 16 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant4, plant2)
D 10 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant2)
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
C -1 PNE derived!9.0()
D 13 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant5, plant4)
D 14 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant5, plant3)
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone2)
C -1 PNE derived!7.0()
C -1 PNE derived!6.0()
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone6)
D 12 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant3, plant4)
C -1 PNE derived!0.0()
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone1, zone4)
D 11 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant1, plant5)
D 19 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant2, plant4)
C -1 PNE derived!12.0()
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, base, zone1)
C -1 PNE derived!74.0()
C -1 PNE derived!10.0()
D 8 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
C -1 PNE derived!5.0()
C -1 PNE derived!15.0()
C -1 PNE derived!8.0()
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone6, zone3)
D 9 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
C -1 PNE derived!1.0()
D 7 PNE derived!difference_PNE battery-level(?robot)_PNE watering-unit-energy()(robot1)
C -1 PNE derived!2.0()
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
R -1 PNE battery-level(robot1)
I -1 PNE total-cost()
R -1 PNE total-watering-time()
R -1 PNE water-level(watering-can1)
R -1 PNE watered-amount(plant1)
R -1 PNE watered-amount(plant2)
R -1 PNE watered-amount(plant3)
R -1 PNE watered-amount(plant4)
R -1 PNE watered-amount(plant5)
end_numeric_variables
3
begin_mutex_group
7
0 0
0 1
0 2
0 3
0 4
0 5
0 6
end_mutex_group
begin_mutex_group
8
1 0
1 1
1 2
1 3
1 4
1 5
1 6
1 7
end_mutex_group
begin_mutex_group
2
1 7
2 0
end_mutex_group
begin_state
0
0
0
1
1
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
2
end_state
begin_numeric_state
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
9.0
0.0
0.0
0.0
7.0
6.0
0.0
0.0
0.0
0.0
0.0
0.0
12.0
0.0
74.0
10.0
0.0
5.0
15.0
8.0
0.0
0.0
1.0
0.0
2.0
0.0
74.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
0.0
end_numeric_state
begin_goal
1
4 0
end_goal
40
begin_operator
charge-battery robot1 base
2
0 0
6 0
0
3
0 37 = 25
0 38 + 33
0 39 + 29
1.0
end_operator
begin_operator
charge-battery robot1 zone2
2
0 2
6 0
0
3
0 37 = 25
0 38 + 33
0 39 + 29
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 base
2
0 0
5 0
2
0 1 7 0
0 2 -1 0
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone1
2
0 1
5 0
2
0 1 7 1
0 2 -1 0
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone2
2
0 2
5 0
2
0 1 7 2
0 2 -1 0
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone3
2
0 3
5 0
2
0 1 7 3
0 2 -1 0
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone4
2
0 4
5 0
2
0 1 7 4
0 2 -1 0
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone5
2
0 5
5 0
2
0 1 7 5
0 2 -1 0
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone6
2
0 6
5 0
2
0 1 7 6
0 2 -1 0
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
fill-container robot1 watering-can1 zone6
4
0 6
1 7
17 0
18 0
0
4
0 37 - 35
0 38 + 33
0 39 + 16
0 40 = 30
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 37 - 15
0 38 + 33
0 39 + 30
1.0
end_operator
begin_operator
move robot1 base zone4
1
8 0
1
0 0 0 4
3
0 37 - 16
0 38 + 33
0 39 + 11
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 37 - 15
0 38 + 33
0 39 + 30
1.0
end_operator
begin_operator
move robot1 zone1 zone3
1
7 0
1
0 0 1 3
3
0 37 - 15
0 38 + 33
0 39 + 30
1.0
end_operator
begin_operator
move robot1 zone1 zone4
1
11 0
1
0 0 1 4
3
0 37 - 30
0 38 + 33
0 39 + 11
1.0
end_operator
begin_operator
move robot1 zone2 zone3
1
12 0
1
0 0 2 3
3
0 37 - 11
0 38 + 33
0 39 + 26
1.0
end_operator
begin_operator
move robot1 zone2 zone5
1
8 0
1
0 0 2 5
3
0 37 - 16
0 38 + 33
0 39 + 26
1.0
end_operator
begin_operator
move robot1 zone3 zone1
1
7 0
1
0 0 3 1
3
0 37 - 15
0 38 + 33
0 39 + 30
1.0
end_operator
begin_operator
move robot1 zone3 zone2
1
12 0
1
0 0 3 2
3
0 37 - 11
0 38 + 33
0 39 + 26
1.0
end_operator
begin_operator
move robot1 zone3 zone4
1
12 0
1
0 0 3 4
3
0 37 - 11
0 38 + 33
0 39 + 26
1.0
end_operator
begin_operator
move robot1 zone3 zone6
1
14 0
1
0 0 3 6
3
0 37 - 28
0 38 + 33
0 39 + 11
1.0
end_operator
begin_operator
move robot1 zone4 base
1
8 0
1
0 0 4 0
3
0 37 - 16
0 38 + 33
0 39 + 11
1.0
end_operator
begin_operator
move robot1 zone4 zone1
1
11 0
1
0 0 4 1
3
0 37 - 30
0 38 + 33
0 39 + 11
1.0
end_operator
begin_operator
move robot1 zone4 zone3
1
12 0
1
0 0 4 3
3
0 37 - 11
0 38 + 33
0 39 + 26
1.0
end_operator
begin_operator
move robot1 zone5 zone2
1
8 0
1
0 0 5 2
3
0 37 - 16
0 38 + 33
0 39 + 26
1.0
end_operator
begin_operator
move robot1 zone5 zone6
1
12 0
1
0 0 5 6
3
0 37 - 11
0 38 + 33
0 39 + 23
1.0
end_operator
begin_operator
move robot1 zone6 zone3
1
14 0
1
0 0 6 3
3
0 37 - 28
0 38 + 33
0 39 + 11
1.0
end_operator
begin_operator
move robot1 zone6 zone5
1
12 0
1
0 0 6 5
3
0 37 - 11
0 38 + 33
0 39 + 23
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 base
2
0 0
5 0
2
0 1 0 7
0 2 0 1
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone1
2
0 1
5 0
2
0 1 1 7
0 2 0 1
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone2
2
0 2
5 0
2
0 1 2 7
0 2 0 1
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone3
2
0 3
5 0
2
0 1 3 7
0 2 0 1
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone4
2
0 4
5 0
2
0 1 4 7
0 2 0 1
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone5
2
0 5
5 0
2
0 1 5 7
0 2 0 1
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone6
2
0 6
5 0
2
0 1 6 7
0 2 0 1
3
0 37 - 33
0 38 + 33
0 39 + 33
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant1 zone2
5
0 2
1 7
5 0
9 0
15 0
0
5
0 37 - 33
0 38 + 33
0 39 + 35
0 40 - 33
0 41 + 33
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant2 zone3
5
0 3
1 7
5 0
9 0
13 0
0
5
0 37 - 33
0 38 + 33
0 39 + 35
0 40 - 33
0 42 + 33
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant3 zone2
5
0 2
1 7
5 0
9 0
16 0
0
5
0 37 - 33
0 38 + 33
0 39 + 35
0 40 - 33
0 43 + 33
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant4 zone4
5
0 4
1 7
5 0
9 0
10 0
0
5
0 37 - 33
0 38 + 33
0 39 + 35
0 40 - 33
0 44 + 33
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant5 zone6
5
0 6
1 7
5 0
9 0
19 0
0
5
0 37 - 33
0 38 + 33
0 39 + 35
0 40 - 33
0 45 + 33
1.0
end_operator
2
begin_rule
0
3 1 0
end_rule
begin_rule
8
0 0
1 0
2 0
20 0
21 0
22 0
23 0
24 0
4 1 0
end_rule
20
begin_comparison_axioms
5 >= 34 19
6 < 10 19
7 >= 24 19
8 >= 14 19
9 >= 32 19
10 < 8 19
11 >= 20 19
12 >= 17 19
13 < 22 19
14 >= 31 19
15 < 21 19
16 < 7 19
17 < 27 19
18 >= 36 19
19 < 0 19
20 >= 22 19
21 >= 21 19
22 >= 8 19
23 >= 0 19
24 >= 7 19
end_comparison_axioms
25
begin_numeric_axioms
0 - 45 35
1 - 42 35
2 - 42 16
3 - 43 35
4 - 41 16
5 - 44 16
6 - 44 35
7 - 43 16
8 - 44 28
9 - 41 28
10 - 37 25
12 - 45 28
13 - 45 16
14 - 37 16
17 - 37 11
18 - 43 28
20 - 37 30
21 - 41 35
22 - 42 28
24 - 37 15
27 - 40 30
31 - 37 28
32 - 40 33
34 - 37 33
36 - 37 35
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
