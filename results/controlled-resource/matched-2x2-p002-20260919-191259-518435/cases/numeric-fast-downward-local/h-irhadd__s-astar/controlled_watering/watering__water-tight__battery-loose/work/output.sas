begin_version
4
end_version
begin_metric
< 32
end_metric
22
begin_variable
var0
-1
6
Atom at-robot(robot1, base)
Atom at-robot(robot1, zone1)
Atom at-robot(robot1, zone2)
Atom at-robot(robot1, zone3)
Atom at-robot(robot1, zone4)
Atom at-robot(robot1, zone5)
end_variable
begin_variable
var1
-1
7
Atom container-at(watering-can1, base)
Atom container-at(watering-can1, zone1)
Atom container-at(watering-can1, zone2)
Atom container-at(watering-can1, zone3)
Atom container-at(watering-can1, zone4)
Atom container-at(watering-can1, zone5)
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
18
2
Atom new-axiom@0()
NegatedAtom new-axiom@0()
end_variable
begin_variable
var4
18
2
Atom new-axiom@1()
NegatedAtom new-axiom@1()
end_variable
begin_variable
var5
17
3
>= 4 19
< 4 19
<none of those>
end_variable
begin_variable
var6
17
3
< 12 19
>= 12 19
<none of those>
end_variable
begin_variable
var7
17
3
>= 23 19
< 23 19
<none of those>
end_variable
begin_variable
var8
17
3
>= 22 19
< 22 19
<none of those>
end_variable
begin_variable
var9
17
3
>= 21 19
< 21 19
<none of those>
end_variable
begin_variable
var10
17
3
>= 28 19
< 28 19
<none of those>
end_variable
begin_variable
var11
17
3
< 0 19
>= 0 19
<none of those>
end_variable
begin_variable
var12
17
3
< 1 19
>= 1 19
<none of those>
end_variable
begin_variable
var13
17
3
< 2 19
>= 2 19
<none of those>
end_variable
begin_variable
var14
17
3
>= 16 19
< 16 19
<none of those>
end_variable
begin_variable
var15
17
3
< 6 19
>= 6 19
<none of those>
end_variable
begin_variable
var16
17
3
< 24 19
>= 24 19
<none of those>
end_variable
begin_variable
var17
17
3
>= 5 19
< 5 19
<none of those>
end_variable
begin_variable
var18
17
3
>= 6 19
< 6 19
<none of those>
end_variable
begin_variable
var19
17
3
>= 2 19
< 2 19
<none of those>
end_variable
begin_variable
var20
17
3
>= 0 19
< 0 19
<none of those>
end_variable
begin_variable
var21
17
3
>= 1 19
< 1 19
<none of those>
end_variable
38
begin_numeric_variables
D 15 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant2, plant3)
D 12 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant3, plant2)
D 11 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant4, plant4)
C -1 PNE derived!2.0()
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE pick-energy()(robot1)
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
D 14 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant1, plant4)
C -1 PNE derived!4.0()
D 16 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant1, plant3)
D 13 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant4, plant3)
C -1 PNE derived!11.0()
D 9 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant2, plant1)
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
C -1 PNE derived!9.0()
C -1 PNE derived!3.0()
C -1 PNE derived!177.0()
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone2, zone3)
C -1 PNE derived!7.0()
C -1 PNE derived!6.0()
C -1 PNE derived!0.0()
D 10 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant3, plant4)
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, zone4)
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, base)
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, base, zone1)
D 7 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
C -1 PNE derived!5.0()
C -1 PNE derived!15.0()
C -1 PNE derived!8.0()
D 8 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
C -1 PNE derived!1.0()
R -1 PNE battery-level(robot1)
I -1 PNE total-cost()
R -1 PNE total-watering-time()
R -1 PNE water-level(watering-can1)
R -1 PNE watered-amount(plant1)
R -1 PNE watered-amount(plant2)
R -1 PNE watered-amount(plant3)
R -1 PNE watered-amount(plant4)
end_numeric_variables
3
begin_mutex_group
6
0 0
0 1
0 2
0 3
0 4
0 5
end_mutex_group
begin_mutex_group
7
1 0
1 1
1 2
1 3
1 4
1 5
1 6
end_mutex_group
begin_mutex_group
2
1 6
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
end_state
begin_numeric_state
0.0
0.0
0.0
2.0
0.0
0.0
0.0
4.0
0.0
0.0
11.0
0.0
0.0
9.0
3.0
177.0
0.0
7.0
6.0
0.0
0.0
0.0
0.0
0.0
0.0
5.0
15.0
8.0
0.0
1.0
177.0
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
35
begin_operator
charge-battery robot1 base
2
0 0
6 0
0
3
0 30 = 15
0 31 + 29
0 32 + 26
1.0
end_operator
begin_operator
charge-battery robot1 zone3
2
0 3
6 0
0
3
0 30 = 15
0 31 + 29
0 32 + 26
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 base
2
0 0
5 0
2
0 1 6 0
0 2 -1 0
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone1
2
0 1
5 0
2
0 1 6 1
0 2 -1 0
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone2
2
0 2
5 0
2
0 1 6 2
0 2 -1 0
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone3
2
0 3
5 0
2
0 1 6 3
0 2 -1 0
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone4
2
0 4
5 0
2
0 1 6 4
0 2 -1 0
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone5
2
0 5
5 0
2
0 1 6 5
0 2 -1 0
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
fill-container robot1 watering-can1 zone2
4
0 2
1 6
16 0
17 0
0
4
0 30 - 3
0 31 + 29
0 32 + 18
0 33 = 13
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 30 - 25
0 31 + 29
0 32 + 17
1.0
end_operator
begin_operator
move robot1 base zone3
1
8 0
1
0 0 0 3
3
0 30 - 14
0 31 + 29
0 32 + 7
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 30 - 25
0 31 + 29
0 32 + 17
1.0
end_operator
begin_operator
move robot1 zone1 zone2
1
9 0
1
0 0 1 2
3
0 30 - 18
0 31 + 29
0 32 + 27
1.0
end_operator
begin_operator
move robot1 zone1 zone3
1
7 0
1
0 0 1 3
3
0 30 - 25
0 31 + 29
0 32 + 18
1.0
end_operator
begin_operator
move robot1 zone1 zone4
1
8 0
1
0 0 1 4
3
0 30 - 14
0 31 + 29
0 32 + 18
1.0
end_operator
begin_operator
move robot1 zone2 zone1
1
9 0
1
0 0 2 1
3
0 30 - 18
0 31 + 29
0 32 + 27
1.0
end_operator
begin_operator
move robot1 zone2 zone3
1
14 0
1
0 0 2 3
3
0 30 - 13
0 31 + 29
0 32 + 10
1.0
end_operator
begin_operator
move robot1 zone2 zone5
1
14 0
1
0 0 2 5
3
0 30 - 13
0 31 + 29
0 32 + 10
1.0
end_operator
begin_operator
move robot1 zone3 base
1
8 0
1
0 0 3 0
3
0 30 - 14
0 31 + 29
0 32 + 7
1.0
end_operator
begin_operator
move robot1 zone3 zone1
1
7 0
1
0 0 3 1
3
0 30 - 25
0 31 + 29
0 32 + 18
1.0
end_operator
begin_operator
move robot1 zone3 zone2
1
14 0
1
0 0 3 2
3
0 30 - 13
0 31 + 29
0 32 + 10
1.0
end_operator
begin_operator
move robot1 zone3 zone4
1
9 0
1
0 0 3 4
3
0 30 - 18
0 31 + 29
0 32 + 13
1.0
end_operator
begin_operator
move robot1 zone4 zone1
1
8 0
1
0 0 4 1
3
0 30 - 14
0 31 + 29
0 32 + 18
1.0
end_operator
begin_operator
move robot1 zone4 zone3
1
9 0
1
0 0 4 3
3
0 30 - 18
0 31 + 29
0 32 + 13
1.0
end_operator
begin_operator
move robot1 zone5 zone2
1
14 0
1
0 0 5 2
3
0 30 - 13
0 31 + 29
0 32 + 10
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 base
2
0 0
5 0
2
0 1 0 6
0 2 0 1
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone1
2
0 1
5 0
2
0 1 1 6
0 2 0 1
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone2
2
0 2
5 0
2
0 1 2 6
0 2 0 1
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone3
2
0 3
5 0
2
0 1 3 6
0 2 0 1
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone4
2
0 4
5 0
2
0 1 4 6
0 2 0 1
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone5
2
0 5
5 0
2
0 1 5 6
0 2 0 1
3
0 30 - 29
0 31 + 29
0 32 + 29
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant1 zone3
5
0 3
1 6
5 0
10 0
15 0
0
5
0 30 - 29
0 31 + 29
0 32 + 3
0 33 - 29
0 34 + 29
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant2 zone1
5
0 1
1 6
5 0
10 0
11 0
0
5
0 30 - 29
0 31 + 29
0 32 + 3
0 33 - 29
0 35 + 29
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant3 zone1
5
0 1
1 6
5 0
10 0
12 0
0
5
0 30 - 29
0 31 + 29
0 32 + 3
0 33 - 29
0 36 + 29
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant4 zone1
5
0 1
1 6
5 0
10 0
13 0
0
5
0 30 - 29
0 31 + 29
0 32 + 3
0 33 - 29
0 37 + 29
1.0
end_operator
2
begin_rule
0
3 1 0
end_rule
begin_rule
7
0 0
1 0
2 0
18 0
19 0
20 0
21 0
4 1 0
end_rule
17
begin_comparison_axioms
5 >= 4 19
6 < 12 19
7 >= 23 19
8 >= 22 19
9 >= 21 19
10 >= 28 19
11 < 0 19
12 < 1 19
13 < 2 19
14 >= 16 19
15 < 6 19
16 < 24 19
17 >= 5 19
18 >= 6 19
19 >= 2 19
20 >= 0 19
21 >= 1 19
end_comparison_axioms
17
begin_numeric_axioms
0 - 35 25
1 - 36 25
2 - 37 7
4 - 30 29
5 - 30 3
6 - 34 7
8 - 34 25
9 - 37 25
11 - 35 7
12 - 30 15
16 - 30 13
20 - 36 7
21 - 30 18
22 - 30 14
23 - 30 25
24 - 33 13
28 - 33 29
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
