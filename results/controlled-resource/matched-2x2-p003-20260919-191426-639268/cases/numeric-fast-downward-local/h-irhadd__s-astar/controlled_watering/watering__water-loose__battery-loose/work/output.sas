begin_version
4
end_version
begin_metric
< 40
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
>= 13 25
< 13 25
<none of those>
end_variable
begin_variable
var6
25
3
< 27 25
>= 27 25
<none of those>
end_variable
begin_variable
var7
25
3
>= 30 25
< 30 25
<none of those>
end_variable
begin_variable
var8
25
3
>= 22 25
< 22 25
<none of those>
end_variable
begin_variable
var9
25
3
>= 36 25
< 36 25
<none of those>
end_variable
begin_variable
var10
25
3
< 9 25
>= 9 25
<none of those>
end_variable
begin_variable
var11
25
3
>= 28 25
< 28 25
<none of those>
end_variable
begin_variable
var12
25
3
>= 5 25
< 5 25
<none of those>
end_variable
begin_variable
var13
25
3
< 10 25
>= 10 25
<none of those>
end_variable
begin_variable
var14
25
3
>= 35 25
< 35 25
<none of those>
end_variable
begin_variable
var15
25
3
< 32 25
>= 32 25
<none of those>
end_variable
begin_variable
var16
25
3
>= 15 25
< 15 25
<none of those>
end_variable
begin_variable
var17
25
3
< 1 25
>= 1 25
<none of those>
end_variable
begin_variable
var18
25
3
< 20 25
>= 20 25
<none of those>
end_variable
begin_variable
var19
25
3
< 17 25
>= 17 25
<none of those>
end_variable
begin_variable
var20
25
3
>= 20 25
< 20 25
<none of those>
end_variable
begin_variable
var21
25
3
>= 9 25
< 9 25
<none of those>
end_variable
begin_variable
var22
25
3
>= 17 25
< 17 25
<none of those>
end_variable
begin_variable
var23
25
3
>= 10 25
< 10 25
<none of those>
end_variable
begin_variable
var24
25
3
>= 1 25
< 1 25
<none of those>
end_variable
47
begin_numeric_variables
D 16 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant2, plant5)
D 19 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant1)
D 20 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant2, plant3)
D 10 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant5, plant3)
D 13 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant3, plant2)
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone2, zone3)
C -1 PNE derived!20.0()
D 11 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant1, plant3)
D 12 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant3, plant5)
D 14 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant4, plant4)
D 23 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant2, plant2)
C -1 PNE derived!2.0()
D 17 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant4, plant1)
D 7 PNE derived!difference_PNE battery-level(?robot)_PNE drop-energy()(robot1)
D 22 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant1, plant2)
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
C -1 PNE derived!8.0()
D 18 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant5, plant5)
D 15 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant5, plant4)
D 24 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant4, plant3)
D 21 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant3, plant3)
C -1 PNE derived!1.0()
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone2)
C -1 PNE derived!7.0()
C -1 PNE derived!6.0()
C -1 PNE derived!0.0()
C -1 PNE derived!9.0()
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone1, zone4)
C -1 PNE derived!12.0()
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, base, zone1)
C -1 PNE derived!10.0()
D 8 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
C -1 PNE derived!5.0()
C -1 PNE derived!15.0()
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone6, zone3)
D 9 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
C -1 PNE derived!222.0()
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
20.0
0.0
0.0
0.0
0.0
2.0
0.0
0.0
0.0
0.0
8.0
0.0
0.0
0.0
0.0
1.0
0.0
7.0
6.0
0.0
9.0
0.0
0.0
12.0
0.0
10.0
0.0
5.0
15.0
0.0
0.0
222.0
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
0 38 = 37
0 39 + 21
0 40 + 34
1.0
end_operator
begin_operator
charge-battery robot1 zone2
2
0 2
6 0
0
3
0 38 = 37
0 39 + 21
0 40 + 34
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
1.0
end_operator
begin_operator
fill-container robot1 watering-can1 zone6
4
0 6
1 7
15 0
16 0
0
4
0 38 - 11
0 39 + 21
0 40 + 24
0 41 = 6
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 38 - 23
0 39 + 21
0 40 + 16
1.0
end_operator
begin_operator
move robot1 base zone4
1
8 0
1
0 0 0 4
3
0 38 - 24
0 39 + 21
0 40 + 26
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 38 - 23
0 39 + 21
0 40 + 16
1.0
end_operator
begin_operator
move robot1 zone1 zone3
1
7 0
1
0 0 1 3
3
0 38 - 23
0 39 + 21
0 40 + 16
1.0
end_operator
begin_operator
move robot1 zone1 zone4
1
11 0
1
0 0 1 4
3
0 38 - 16
0 39 + 21
0 40 + 26
1.0
end_operator
begin_operator
move robot1 zone2 zone3
1
12 0
1
0 0 2 3
3
0 38 - 26
0 39 + 21
0 40 + 31
1.0
end_operator
begin_operator
move robot1 zone2 zone5
1
8 0
1
0 0 2 5
3
0 38 - 24
0 39 + 21
0 40 + 31
1.0
end_operator
begin_operator
move robot1 zone3 zone1
1
7 0
1
0 0 3 1
3
0 38 - 23
0 39 + 21
0 40 + 16
1.0
end_operator
begin_operator
move robot1 zone3 zone2
1
12 0
1
0 0 3 2
3
0 38 - 26
0 39 + 21
0 40 + 31
1.0
end_operator
begin_operator
move robot1 zone3 zone4
1
12 0
1
0 0 3 4
3
0 38 - 26
0 39 + 21
0 40 + 31
1.0
end_operator
begin_operator
move robot1 zone3 zone6
1
14 0
1
0 0 3 6
3
0 38 - 33
0 39 + 21
0 40 + 26
1.0
end_operator
begin_operator
move robot1 zone4 base
1
8 0
1
0 0 4 0
3
0 38 - 24
0 39 + 21
0 40 + 26
1.0
end_operator
begin_operator
move robot1 zone4 zone1
1
11 0
1
0 0 4 1
3
0 38 - 16
0 39 + 21
0 40 + 26
1.0
end_operator
begin_operator
move robot1 zone4 zone3
1
12 0
1
0 0 4 3
3
0 38 - 26
0 39 + 21
0 40 + 31
1.0
end_operator
begin_operator
move robot1 zone5 zone2
1
8 0
1
0 0 5 2
3
0 38 - 24
0 39 + 21
0 40 + 31
1.0
end_operator
begin_operator
move robot1 zone5 zone6
1
12 0
1
0 0 5 6
3
0 38 - 26
0 39 + 21
0 40 + 29
1.0
end_operator
begin_operator
move robot1 zone6 zone3
1
14 0
1
0 0 6 3
3
0 38 - 33
0 39 + 21
0 40 + 26
1.0
end_operator
begin_operator
move robot1 zone6 zone5
1
12 0
1
0 0 6 5
3
0 38 - 26
0 39 + 21
0 40 + 29
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
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
0 38 - 21
0 39 + 21
0 40 + 21
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant1 zone2
5
0 2
1 7
5 0
9 0
17 0
0
5
0 38 - 21
0 39 + 21
0 40 + 11
0 41 - 21
0 42 + 21
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
0 38 - 21
0 39 + 21
0 40 + 11
0 41 - 21
0 43 + 21
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant3 zone2
5
0 2
1 7
5 0
9 0
18 0
0
5
0 38 - 21
0 39 + 21
0 40 + 11
0 41 - 21
0 44 + 21
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
0 38 - 21
0 39 + 21
0 40 + 11
0 41 - 21
0 45 + 21
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
0 38 - 21
0 39 + 21
0 40 + 11
0 41 - 21
0 46 + 21
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
5 >= 13 25
6 < 27 25
7 >= 30 25
8 >= 22 25
9 >= 36 25
10 < 9 25
11 >= 28 25
12 >= 5 25
13 < 10 25
14 >= 35 25
15 < 32 25
16 >= 15 25
17 < 1 25
18 < 20 25
19 < 17 25
20 >= 20 25
21 >= 9 25
22 >= 17 25
23 >= 10 25
24 >= 1 25
end_comparison_axioms
25
begin_numeric_axioms
0 - 43 11
1 - 42 11
2 - 43 24
3 - 46 24
4 - 44 33
5 - 38 26
7 - 42 24
8 - 44 11
9 - 45 33
10 - 43 33
12 - 45 11
13 - 38 21
14 - 42 33
15 - 38 11
17 - 46 11
18 - 46 33
19 - 45 24
20 - 44 24
22 - 38 24
27 - 38 37
28 - 38 16
30 - 38 23
32 - 41 6
35 - 38 33
36 - 41 21
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
