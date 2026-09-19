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
>= 33 18
< 33 18
<none of those>
end_variable
begin_variable
var6
25
3
< 11 18
>= 11 18
<none of those>
end_variable
begin_variable
var7
25
3
>= 25 18
< 25 18
<none of those>
end_variable
begin_variable
var8
25
3
>= 14 18
< 14 18
<none of those>
end_variable
begin_variable
var9
25
3
>= 31 18
< 31 18
<none of those>
end_variable
begin_variable
var10
25
3
< 10 18
>= 10 18
<none of those>
end_variable
begin_variable
var11
25
3
>= 21 18
< 21 18
<none of those>
end_variable
begin_variable
var12
25
3
>= 16 18
< 16 18
<none of those>
end_variable
begin_variable
var13
25
3
< 0 18
>= 0 18
<none of those>
end_variable
begin_variable
var14
25
3
>= 30 18
< 30 18
<none of those>
end_variable
begin_variable
var15
25
3
< 23 18
>= 23 18
<none of those>
end_variable
begin_variable
var16
25
3
< 9 18
>= 9 18
<none of those>
end_variable
begin_variable
var17
25
3
< 28 18
>= 28 18
<none of those>
end_variable
begin_variable
var18
25
3
>= 36 18
< 36 18
<none of those>
end_variable
begin_variable
var19
25
3
< 4 18
>= 4 18
<none of those>
end_variable
begin_variable
var20
25
3
>= 23 18
< 23 18
<none of those>
end_variable
begin_variable
var21
25
3
>= 9 18
< 9 18
<none of those>
end_variable
begin_variable
var22
25
3
>= 0 18
< 0 18
<none of those>
end_variable
begin_variable
var23
25
3
>= 4 18
< 4 18
<none of those>
end_variable
begin_variable
var24
25
3
>= 10 18
< 10 18
<none of those>
end_variable
46
begin_numeric_variables
D 11 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant2, plant4)
D 15 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant2, plant3)
D 21 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant1, plant2)
D 14 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant4, plant1)
D 18 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant5, plant5)
D 16 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant2, plant1)
D 22 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant3, plant5)
D 19 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant1, plant3)
D 23 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant4, plant3)
D 20 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant3, plant3)
D 17 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant4, plant2)
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
C -1 PNE derived!9.0()
D 13 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant5, plant2)
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone2)
C -1 PNE derived!6.0()
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone6)
D 12 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant3, plant4)
C -1 PNE derived!0.0()
D 24 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant5, plant3)
C -1 PNE derived!5.0()
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone4, zone1)
C -1 PNE derived!15.0()
D 10 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant5)
C -1 PNE derived!12.0()
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, base, zone1)
C -1 PNE derived!10.0()
C -1 PNE derived!222.0()
D 8 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
C -1 PNE derived!8.0()
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone6, zone3)
D 9 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
C -1 PNE derived!1.0()
D 7 PNE derived!difference_PNE battery-level(?robot)_PNE watering-unit-energy()(robot1)
C -1 PNE derived!2.0()
C -1 PNE derived!7.0()
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
0.0
9.0
0.0
0.0
6.0
0.0
0.0
0.0
0.0
5.0
0.0
15.0
0.0
12.0
0.0
10.0
222.0
0.0
8.0
0.0
0.0
1.0
0.0
2.0
7.0
0.0
222.0
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
0 37 = 27
0 38 + 32
0 39 + 22
1.0
end_operator
begin_operator
charge-battery robot1 zone2
2
0 2
6 0
0
3
0 37 = 27
0 38 + 32
0 39 + 22
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 34
0 38 + 32
0 39 + 15
0 40 = 29
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 37 - 35
0 38 + 32
0 39 + 29
1.0
end_operator
begin_operator
move robot1 base zone4
1
8 0
1
0 0 0 4
3
0 37 - 15
0 38 + 32
0 39 + 12
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 37 - 35
0 38 + 32
0 39 + 29
1.0
end_operator
begin_operator
move robot1 zone1 zone3
1
7 0
1
0 0 1 3
3
0 37 - 35
0 38 + 32
0 39 + 29
1.0
end_operator
begin_operator
move robot1 zone1 zone4
1
11 0
1
0 0 1 4
3
0 37 - 29
0 38 + 32
0 39 + 12
1.0
end_operator
begin_operator
move robot1 zone2 zone3
1
12 0
1
0 0 2 3
3
0 37 - 12
0 38 + 32
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
0 37 - 15
0 38 + 32
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
0 37 - 35
0 38 + 32
0 39 + 29
1.0
end_operator
begin_operator
move robot1 zone3 zone2
1
12 0
1
0 0 3 2
3
0 37 - 12
0 38 + 32
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
0 37 - 12
0 38 + 32
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
0 37 - 20
0 38 + 32
0 39 + 12
1.0
end_operator
begin_operator
move robot1 zone4 base
1
8 0
1
0 0 4 0
3
0 37 - 15
0 38 + 32
0 39 + 12
1.0
end_operator
begin_operator
move robot1 zone4 zone1
1
11 0
1
0 0 4 1
3
0 37 - 29
0 38 + 32
0 39 + 12
1.0
end_operator
begin_operator
move robot1 zone4 zone3
1
12 0
1
0 0 4 3
3
0 37 - 12
0 38 + 32
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
0 37 - 15
0 38 + 32
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
0 37 - 12
0 38 + 32
0 39 + 24
1.0
end_operator
begin_operator
move robot1 zone6 zone3
1
14 0
1
0 0 6 3
3
0 37 - 20
0 38 + 32
0 39 + 12
1.0
end_operator
begin_operator
move robot1 zone6 zone5
1
12 0
1
0 0 6 5
3
0 37 - 12
0 38 + 32
0 39 + 24
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 32
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
0 37 - 32
0 38 + 32
0 39 + 34
0 40 - 32
0 41 + 32
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
0 37 - 32
0 38 + 32
0 39 + 34
0 40 - 32
0 42 + 32
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
0 37 - 32
0 38 + 32
0 39 + 34
0 40 - 32
0 43 + 32
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
0 37 - 32
0 38 + 32
0 39 + 34
0 40 - 32
0 44 + 32
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
0 37 - 32
0 38 + 32
0 39 + 34
0 40 - 32
0 45 + 32
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
5 >= 33 18
6 < 11 18
7 >= 25 18
8 >= 14 18
9 >= 31 18
10 < 10 18
11 >= 21 18
12 >= 16 18
13 < 0 18
14 >= 30 18
15 < 23 18
16 < 9 18
17 < 28 18
18 >= 36 18
19 < 4 18
20 >= 23 18
21 >= 9 18
22 >= 0 18
23 >= 4 18
24 >= 10 18
end_comparison_axioms
25
begin_numeric_axioms
0 - 42 20
1 - 42 15
2 - 41 20
3 - 44 34
4 - 45 34
5 - 42 34
6 - 43 34
7 - 41 15
8 - 44 15
9 - 43 15
10 - 44 20
11 - 37 27
13 - 45 20
14 - 37 15
16 - 37 12
17 - 43 20
19 - 45 15
21 - 37 29
23 - 41 34
25 - 37 35
28 - 40 29
30 - 37 20
31 - 40 32
33 - 37 32
36 - 37 34
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
