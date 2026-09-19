begin_version
4
end_version
begin_metric
< 29
end_metric
20
begin_variable
var0
-1
5
Atom at-robot(robot1, base)
Atom at-robot(robot1, zone1)
Atom at-robot(robot1, zone2)
Atom at-robot(robot1, zone3)
Atom at-robot(robot1, zone4)
end_variable
begin_variable
var1
-1
6
Atom container-at(watering-can1, base)
Atom container-at(watering-can1, zone1)
Atom container-at(watering-can1, zone2)
Atom container-at(watering-can1, zone3)
Atom container-at(watering-can1, zone4)
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
16
2
Atom new-axiom@0()
NegatedAtom new-axiom@0()
end_variable
begin_variable
var4
16
2
Atom new-axiom@1()
NegatedAtom new-axiom@1()
end_variable
begin_variable
var5
15
3
>= 6 17
< 6 17
<none of those>
end_variable
begin_variable
var6
15
3
< 26 17
>= 26 17
<none of those>
end_variable
begin_variable
var7
15
3
>= 3 17
< 3 17
<none of those>
end_variable
begin_variable
var8
15
3
>= 13 17
< 13 17
<none of those>
end_variable
begin_variable
var9
15
3
>= 21 17
< 21 17
<none of those>
end_variable
begin_variable
var10
15
3
< 1 17
>= 1 17
<none of those>
end_variable
begin_variable
var11
15
3
< 7 17
>= 7 17
<none of those>
end_variable
begin_variable
var12
15
3
< 20 17
>= 20 17
<none of those>
end_variable
begin_variable
var13
15
3
>= 19 17
< 19 17
<none of those>
end_variable
begin_variable
var14
15
3
>= 24 17
< 24 17
<none of those>
end_variable
begin_variable
var15
15
3
< 22 17
>= 22 17
<none of those>
end_variable
begin_variable
var16
15
3
>= 11 17
< 11 17
<none of those>
end_variable
begin_variable
var17
15
3
>= 1 17
< 1 17
<none of those>
end_variable
begin_variable
var18
15
3
>= 20 17
< 20 17
<none of those>
end_variable
begin_variable
var19
15
3
>= 7 17
< 7 17
<none of those>
end_variable
34
begin_numeric_variables
D 13 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant3, plant2)
D 14 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant3, plant1)
C -1 PNE derived!2.0()
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, base, zone1)
D 10 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant2, plant1)
C -1 PNE derived!12.0()
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE drop-energy()(robot1)
D 9 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant1, plant3)
C -1 PNE derived!7.0()
D 12 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant1, plant2)
C -1 PNE derived!3.0()
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
C -1 PNE derived!6.0()
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, base, zone3)
C -1 PNE derived!38.0()
C -1 PNE derived!8.0()
C -1 PNE derived!10.0()
C -1 PNE derived!0.0()
C -1 PNE derived!4.0()
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone4, zone1)
D 11 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant2, plant2)
D 8 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
D 7 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
C -1 PNE derived!15.0()
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone4, zone3)
C -1 PNE derived!1.0()
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
R -1 PNE battery-level(robot1)
I -1 PNE total-cost()
R -1 PNE total-watering-time()
R -1 PNE water-level(watering-can1)
R -1 PNE watered-amount(plant1)
R -1 PNE watered-amount(plant2)
R -1 PNE watered-amount(plant3)
end_numeric_variables
3
begin_mutex_group
5
0 0
0 1
0 2
0 3
0 4
end_mutex_group
begin_mutex_group
6
1 0
1 1
1 2
1 3
1 4
1 5
end_mutex_group
begin_mutex_group
2
1 5
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
end_state
begin_numeric_state
0.0
0.0
2.0
0.0
0.0
12.0
0.0
0.0
7.0
0.0
3.0
0.0
6.0
0.0
38.0
8.0
10.0
0.0
4.0
0.0
0.0
0.0
0.0
15.0
0.0
1.0
0.0
38.0
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
28
begin_operator
charge-battery robot1 base
2
0 0
6 0
0
3
0 27 = 14
0 28 + 25
0 29 + 23
1.0
end_operator
begin_operator
charge-battery robot1 zone1
2
0 1
6 0
0
3
0 27 = 14
0 28 + 25
0 29 + 23
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 base
2
0 0
5 0
2
0 1 5 0
0 2 -1 0
3
0 27 - 25
0 28 + 25
0 29 + 25
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone1
2
0 1
5 0
2
0 1 5 1
0 2 -1 0
3
0 27 - 25
0 28 + 25
0 29 + 25
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone2
2
0 2
5 0
2
0 1 5 2
0 2 -1 0
3
0 27 - 25
0 28 + 25
0 29 + 25
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone3
2
0 3
5 0
2
0 1 5 3
0 2 -1 0
3
0 27 - 25
0 28 + 25
0 29 + 25
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone4
2
0 4
5 0
2
0 1 5 4
0 2 -1 0
3
0 27 - 25
0 28 + 25
0 29 + 25
1.0
end_operator
begin_operator
fill-container robot1 watering-can1 zone2
4
0 2
1 5
15 0
16 0
0
4
0 27 - 2
0 28 + 25
0 29 + 12
0 30 = 15
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 27 - 15
0 28 + 25
0 29 + 16
1.0
end_operator
begin_operator
move robot1 base zone3
1
8 0
1
0 0 0 3
3
0 27 - 16
0 28 + 25
0 29 + 5
1.0
end_operator
begin_operator
move robot1 base zone4
1
7 0
1
0 0 0 4
3
0 27 - 15
0 28 + 25
0 29 + 5
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 27 - 15
0 28 + 25
0 29 + 16
1.0
end_operator
begin_operator
move robot1 zone1 zone4
1
13 0
1
0 0 1 4
3
0 27 - 10
0 28 + 25
0 29 + 18
1.0
end_operator
begin_operator
move robot1 zone2 zone4
1
13 0
1
0 0 2 4
3
0 27 - 10
0 28 + 25
0 29 + 12
1.0
end_operator
begin_operator
move robot1 zone3 base
1
8 0
1
0 0 3 0
3
0 27 - 16
0 28 + 25
0 29 + 5
1.0
end_operator
begin_operator
move robot1 zone3 zone4
1
14 0
1
0 0 3 4
3
0 27 - 18
0 28 + 25
0 29 + 8
1.0
end_operator
begin_operator
move robot1 zone4 base
1
7 0
1
0 0 4 0
3
0 27 - 15
0 28 + 25
0 29 + 5
1.0
end_operator
begin_operator
move robot1 zone4 zone1
1
13 0
1
0 0 4 1
3
0 27 - 10
0 28 + 25
0 29 + 18
1.0
end_operator
begin_operator
move robot1 zone4 zone2
1
13 0
1
0 0 4 2
3
0 27 - 10
0 28 + 25
0 29 + 12
1.0
end_operator
begin_operator
move robot1 zone4 zone3
1
14 0
1
0 0 4 3
3
0 27 - 18
0 28 + 25
0 29 + 8
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 base
2
0 0
5 0
2
0 1 0 5
0 2 0 1
3
0 27 - 25
0 28 + 25
0 29 + 25
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone1
2
0 1
5 0
2
0 1 1 5
0 2 0 1
3
0 27 - 25
0 28 + 25
0 29 + 25
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone2
2
0 2
5 0
2
0 1 2 5
0 2 0 1
3
0 27 - 25
0 28 + 25
0 29 + 25
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone3
2
0 3
5 0
2
0 1 3 5
0 2 0 1
3
0 27 - 25
0 28 + 25
0 29 + 25
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone4
2
0 4
5 0
2
0 1 4 5
0 2 0 1
3
0 27 - 25
0 28 + 25
0 29 + 25
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant1 zone3
5
0 3
1 5
5 0
9 0
11 0
0
5
0 27 - 25
0 28 + 25
0 29 + 2
0 30 - 25
0 31 + 25
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant2 zone3
5
0 3
1 5
5 0
9 0
12 0
0
5
0 27 - 25
0 28 + 25
0 29 + 2
0 30 - 25
0 32 + 25
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant3 zone1
5
0 1
1 5
5 0
9 0
10 0
0
5
0 27 - 25
0 28 + 25
0 29 + 2
0 30 - 25
0 33 + 25
1.0
end_operator
2
begin_rule
0
3 1 0
end_rule
begin_rule
6
0 0
1 0
2 0
17 0
18 0
19 0
4 1 0
end_rule
15
begin_comparison_axioms
5 >= 6 17
6 < 26 17
7 >= 3 17
8 >= 13 17
9 >= 21 17
10 < 1 17
11 < 7 17
12 < 20 17
13 >= 19 17
14 >= 24 17
15 < 22 17
16 >= 11 17
17 >= 1 17
18 >= 20 17
19 >= 7 17
end_comparison_axioms
15
begin_numeric_axioms
0 - 33 2
1 - 33 10
3 - 27 15
4 - 32 10
6 - 27 25
7 - 31 10
9 - 31 2
11 - 27 2
13 - 27 16
19 - 27 10
20 - 32 2
21 - 30 25
22 - 30 15
24 - 27 18
26 - 27 14
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
