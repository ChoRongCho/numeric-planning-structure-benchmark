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
< 13 0
>= 13 0
<none of those>
end_variable
begin_variable
var6
17
3
>= 14 0
< 14 0
<none of those>
end_variable
begin_variable
var7
17
3
>= 16 0
< 16 0
<none of those>
end_variable
begin_variable
var8
17
3
>= 17 0
< 17 0
<none of those>
end_variable
begin_variable
var9
17
3
>= 21 0
< 21 0
<none of those>
end_variable
begin_variable
var10
17
3
< 25 0
>= 25 0
<none of those>
end_variable
begin_variable
var11
17
3
< 27 0
>= 27 0
<none of those>
end_variable
begin_variable
var12
17
3
< 28 0
>= 28 0
<none of those>
end_variable
begin_variable
var13
17
3
< 22 0
>= 22 0
<none of those>
end_variable
begin_variable
var14
17
3
>= 18 0
< 18 0
<none of those>
end_variable
begin_variable
var15
17
3
>= 19 0
< 19 0
<none of those>
end_variable
begin_variable
var16
17
3
< 20 0
>= 20 0
<none of those>
end_variable
begin_variable
var17
17
3
>= 15 0
< 15 0
<none of those>
end_variable
begin_variable
var18
17
3
>= 25 0
< 25 0
<none of those>
end_variable
begin_variable
var19
17
3
>= 27 0
< 27 0
<none of those>
end_variable
begin_variable
var20
17
3
>= 22 0
< 22 0
<none of those>
end_variable
begin_variable
var21
17
3
>= 28 0
< 28 0
<none of those>
end_variable
38
begin_numeric_variables
C -1 PNE derived!0.0()
C -1 PNE derived!1.0()
C -1 PNE derived!11.0()
C -1 PNE derived!15.0()
C -1 PNE derived!2.0()
C -1 PNE derived!3.0()
C -1 PNE derived!4.0()
C -1 PNE derived!5.0()
C -1 PNE derived!59.0()
C -1 PNE derived!6.0()
C -1 PNE derived!7.0()
C -1 PNE derived!8.0()
C -1 PNE derived!9.0()
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE watering-unit-energy()(robot1)
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, zone1)
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone4, zone1)
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone4, zone3)
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone2)
D 7 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
D 8 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
D 9 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant1, plant4)
D 10 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant1, plant3)
D 11 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant2, plant4)
D 12 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant2, plant3)
D 13 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant3, plant4)
D 14 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant3, plant3)
D 15 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant4, plant4)
D 16 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant4, plant3)
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
1.0
11.0
15.0
2.0
3.0
4.0
5.0
59.0
6.0
7.0
8.0
9.0
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
0.0
0.0
0.0
0.0
0.0
59.0
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
5 0
0
3
0 30 = 8
0 31 + 1
0 32 + 3
1.0
end_operator
begin_operator
charge-battery robot1 zone3
2
0 3
5 0
0
3
0 30 = 8
0 31 + 1
0 32 + 3
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 base
2
0 0
6 0
2
0 1 6 0
0 2 -1 0
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone1
2
0 1
6 0
2
0 1 6 1
0 2 -1 0
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone2
2
0 2
6 0
2
0 1 6 2
0 2 -1 0
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone3
2
0 3
6 0
2
0 1 6 3
0 2 -1 0
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone4
2
0 4
6 0
2
0 1 6 4
0 2 -1 0
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone5
2
0 5
6 0
2
0 1 6 5
0 2 -1 0
3
0 30 - 1
0 31 + 1
0 32 + 1
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
0 30 - 4
0 31 + 1
0 32 + 9
0 33 = 12
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 30 - 7
0 31 + 1
0 32 + 10
1.0
end_operator
begin_operator
move robot1 base zone3
1
8 0
1
0 0 0 3
3
0 30 - 5
0 31 + 1
0 32 + 6
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 30 - 7
0 31 + 1
0 32 + 10
1.0
end_operator
begin_operator
move robot1 zone1 zone2
1
14 0
1
0 0 1 2
3
0 30 - 9
0 31 + 1
0 32 + 11
1.0
end_operator
begin_operator
move robot1 zone1 zone3
1
7 0
1
0 0 1 3
3
0 30 - 7
0 31 + 1
0 32 + 9
1.0
end_operator
begin_operator
move robot1 zone1 zone4
1
8 0
1
0 0 1 4
3
0 30 - 5
0 31 + 1
0 32 + 9
1.0
end_operator
begin_operator
move robot1 zone2 zone1
1
14 0
1
0 0 2 1
3
0 30 - 9
0 31 + 1
0 32 + 11
1.0
end_operator
begin_operator
move robot1 zone2 zone3
1
15 0
1
0 0 2 3
3
0 30 - 12
0 31 + 1
0 32 + 2
1.0
end_operator
begin_operator
move robot1 zone2 zone5
1
15 0
1
0 0 2 5
3
0 30 - 12
0 31 + 1
0 32 + 2
1.0
end_operator
begin_operator
move robot1 zone3 base
1
8 0
1
0 0 3 0
3
0 30 - 5
0 31 + 1
0 32 + 6
1.0
end_operator
begin_operator
move robot1 zone3 zone1
1
7 0
1
0 0 3 1
3
0 30 - 7
0 31 + 1
0 32 + 9
1.0
end_operator
begin_operator
move robot1 zone3 zone2
1
15 0
1
0 0 3 2
3
0 30 - 12
0 31 + 1
0 32 + 2
1.0
end_operator
begin_operator
move robot1 zone3 zone4
1
14 0
1
0 0 3 4
3
0 30 - 9
0 31 + 1
0 32 + 12
1.0
end_operator
begin_operator
move robot1 zone4 zone1
1
8 0
1
0 0 4 1
3
0 30 - 5
0 31 + 1
0 32 + 9
1.0
end_operator
begin_operator
move robot1 zone4 zone3
1
14 0
1
0 0 4 3
3
0 30 - 9
0 31 + 1
0 32 + 12
1.0
end_operator
begin_operator
move robot1 zone5 zone2
1
15 0
1
0 0 5 2
3
0 30 - 12
0 31 + 1
0 32 + 2
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 base
2
0 0
6 0
2
0 1 0 6
0 2 0 1
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone1
2
0 1
6 0
2
0 1 1 6
0 2 0 1
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone2
2
0 2
6 0
2
0 1 2 6
0 2 0 1
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone3
2
0 3
6 0
2
0 1 3 6
0 2 0 1
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone4
2
0 4
6 0
2
0 1 4 6
0 2 0 1
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone5
2
0 5
6 0
2
0 1 5 6
0 2 0 1
3
0 30 - 1
0 31 + 1
0 32 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant1 zone3
5
0 3
1 6
6 0
9 0
13 0
0
5
0 30 - 1
0 31 + 1
0 32 + 4
0 33 - 1
0 34 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant2 zone1
5
0 1
1 6
6 0
9 0
10 0
0
5
0 30 - 1
0 31 + 1
0 32 + 4
0 33 - 1
0 35 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant3 zone1
5
0 1
1 6
6 0
9 0
11 0
0
5
0 30 - 1
0 31 + 1
0 32 + 4
0 33 - 1
0 36 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant4 zone1
5
0 1
1 6
6 0
9 0
12 0
0
5
0 30 - 1
0 31 + 1
0 32 + 4
0 33 - 1
0 37 + 1
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
5 < 13 0
6 >= 14 0
7 >= 16 0
8 >= 17 0
9 >= 21 0
10 < 25 0
11 < 27 0
12 < 28 0
13 < 22 0
14 >= 18 0
15 >= 19 0
16 < 20 0
17 >= 15 0
18 >= 25 0
19 >= 27 0
20 >= 22 0
21 >= 28 0
end_comparison_axioms
17
begin_numeric_axioms
13 - 30 8
14 - 30 1
15 - 30 4
16 - 30 7
17 - 30 5
18 - 30 9
19 - 30 12
20 - 33 12
21 - 33 1
22 - 34 6
23 - 34 7
24 - 35 6
25 - 35 7
26 - 36 6
27 - 36 7
28 - 37 6
29 - 37 7
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
