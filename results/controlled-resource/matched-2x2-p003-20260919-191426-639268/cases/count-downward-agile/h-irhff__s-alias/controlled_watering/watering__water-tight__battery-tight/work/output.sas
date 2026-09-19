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
< 12 0
>= 12 0
<none of those>
end_variable
begin_variable
var6
25
3
>= 13 0
< 13 0
<none of those>
end_variable
begin_variable
var7
25
3
>= 15 0
< 15 0
<none of those>
end_variable
begin_variable
var8
25
3
>= 16 0
< 16 0
<none of those>
end_variable
begin_variable
var9
25
3
>= 21 0
< 21 0
<none of those>
end_variable
begin_variable
var10
25
3
< 32 0
>= 32 0
<none of those>
end_variable
begin_variable
var11
25
3
>= 17 0
< 17 0
<none of those>
end_variable
begin_variable
var12
25
3
>= 18 0
< 18 0
<none of those>
end_variable
begin_variable
var13
25
3
< 26 0
>= 26 0
<none of those>
end_variable
begin_variable
var14
25
3
>= 19 0
< 19 0
<none of those>
end_variable
begin_variable
var15
25
3
< 22 0
>= 22 0
<none of those>
end_variable
begin_variable
var16
25
3
< 30 0
>= 30 0
<none of those>
end_variable
begin_variable
var17
25
3
< 20 0
>= 20 0
<none of those>
end_variable
begin_variable
var18
25
3
>= 14 0
< 14 0
<none of those>
end_variable
begin_variable
var19
25
3
< 34 0
>= 34 0
<none of those>
end_variable
begin_variable
var20
25
3
>= 22 0
< 22 0
<none of those>
end_variable
begin_variable
var21
25
3
>= 32 0
< 32 0
<none of those>
end_variable
begin_variable
var22
25
3
>= 34 0
< 34 0
<none of those>
end_variable
begin_variable
var23
25
3
>= 30 0
< 30 0
<none of those>
end_variable
begin_variable
var24
25
3
>= 26 0
< 26 0
<none of those>
end_variable
46
begin_numeric_variables
C -1 PNE derived!0.0()
C -1 PNE derived!1.0()
C -1 PNE derived!10.0()
C -1 PNE derived!12.0()
C -1 PNE derived!15.0()
C -1 PNE derived!2.0()
C -1 PNE derived!5.0()
C -1 PNE derived!6.0()
C -1 PNE derived!7.0()
C -1 PNE derived!74.0()
C -1 PNE derived!8.0()
C -1 PNE derived!9.0()
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE watering-unit-energy()(robot1)
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, zone1)
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone2)
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone4, zone1)
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone6, zone5)
D 7 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone6, zone3)
D 8 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
D 9 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
D 10 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant5)
D 11 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant4)
D 12 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant3)
D 13 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant2, plant5)
D 14 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant2, plant4)
D 15 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant2, plant3)
D 16 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant3, plant5)
D 17 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant3, plant4)
D 18 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant3, plant3)
D 19 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant4, plant5)
D 20 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant4, plant4)
D 21 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant4, plant3)
D 22 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant5, plant5)
D 23 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant5, plant4)
D 24 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant5, plant3)
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
1.0
10.0
12.0
15.0
2.0
5.0
6.0
7.0
74.0
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
0.0
0.0
0.0
0.0
0.0
0.0
0.0
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
5 0
0
3
0 37 = 9
0 38 + 1
0 39 + 4
1.0
end_operator
begin_operator
charge-battery robot1 zone2
2
0 2
5 0
0
3
0 37 = 9
0 38 + 1
0 39 + 4
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 base
2
0 0
6 0
2
0 1 7 0
0 2 -1 0
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone1
2
0 1
6 0
2
0 1 7 1
0 2 -1 0
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone2
2
0 2
6 0
2
0 1 7 2
0 2 -1 0
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone3
2
0 3
6 0
2
0 1 7 3
0 2 -1 0
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone4
2
0 4
6 0
2
0 1 7 4
0 2 -1 0
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone5
2
0 5
6 0
2
0 1 7 5
0 2 -1 0
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone6
2
0 6
6 0
2
0 1 7 6
0 2 -1 0
3
0 37 - 1
0 38 + 1
0 39 + 1
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
0 37 - 5
0 38 + 1
0 39 + 7
0 40 = 10
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 37 - 8
0 38 + 1
0 39 + 10
1.0
end_operator
begin_operator
move robot1 base zone4
1
8 0
1
0 0 0 4
3
0 37 - 7
0 38 + 1
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
0 37 - 8
0 38 + 1
0 39 + 10
1.0
end_operator
begin_operator
move robot1 zone1 zone3
1
7 0
1
0 0 1 3
3
0 37 - 8
0 38 + 1
0 39 + 10
1.0
end_operator
begin_operator
move robot1 zone1 zone4
1
11 0
1
0 0 1 4
3
0 37 - 10
0 38 + 1
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
0 38 + 1
0 39 + 2
1.0
end_operator
begin_operator
move robot1 zone2 zone5
1
8 0
1
0 0 2 5
3
0 37 - 7
0 38 + 1
0 39 + 2
1.0
end_operator
begin_operator
move robot1 zone3 zone1
1
7 0
1
0 0 3 1
3
0 37 - 8
0 38 + 1
0 39 + 10
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
0 38 + 1
0 39 + 2
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
0 38 + 1
0 39 + 2
1.0
end_operator
begin_operator
move robot1 zone3 zone6
1
14 0
1
0 0 3 6
3
0 37 - 6
0 38 + 1
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
0 37 - 7
0 38 + 1
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
0 37 - 10
0 38 + 1
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
0 38 + 1
0 39 + 2
1.0
end_operator
begin_operator
move robot1 zone5 zone2
1
8 0
1
0 0 5 2
3
0 37 - 7
0 38 + 1
0 39 + 2
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
0 38 + 1
0 39 + 3
1.0
end_operator
begin_operator
move robot1 zone6 zone3
1
14 0
1
0 0 6 3
3
0 37 - 6
0 38 + 1
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
0 38 + 1
0 39 + 3
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 base
2
0 0
6 0
2
0 1 0 7
0 2 0 1
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone1
2
0 1
6 0
2
0 1 1 7
0 2 0 1
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone2
2
0 2
6 0
2
0 1 2 7
0 2 0 1
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone3
2
0 3
6 0
2
0 1 3 7
0 2 0 1
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone4
2
0 4
6 0
2
0 1 4 7
0 2 0 1
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone5
2
0 5
6 0
2
0 1 5 7
0 2 0 1
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone6
2
0 6
6 0
2
0 1 6 7
0 2 0 1
3
0 37 - 1
0 38 + 1
0 39 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant1 zone2
5
0 2
1 7
6 0
9 0
15 0
0
5
0 37 - 1
0 38 + 1
0 39 + 5
0 40 - 1
0 41 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant2 zone3
5
0 3
1 7
6 0
9 0
13 0
0
5
0 37 - 1
0 38 + 1
0 39 + 5
0 40 - 1
0 42 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant3 zone2
5
0 2
1 7
6 0
9 0
16 0
0
5
0 37 - 1
0 38 + 1
0 39 + 5
0 40 - 1
0 43 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant4 zone4
5
0 4
1 7
6 0
9 0
10 0
0
5
0 37 - 1
0 38 + 1
0 39 + 5
0 40 - 1
0 44 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant5 zone6
5
0 6
1 7
6 0
9 0
19 0
0
5
0 37 - 1
0 38 + 1
0 39 + 5
0 40 - 1
0 45 + 1
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
5 < 12 0
6 >= 13 0
7 >= 15 0
8 >= 16 0
9 >= 21 0
10 < 32 0
11 >= 17 0
12 >= 18 0
13 < 26 0
14 >= 19 0
15 < 22 0
16 < 30 0
17 < 20 0
18 >= 14 0
19 < 34 0
20 >= 22 0
21 >= 32 0
22 >= 34 0
23 >= 30 0
24 >= 26 0
end_comparison_axioms
25
begin_numeric_axioms
12 - 37 9
13 - 37 1
14 - 37 5
15 - 37 8
16 - 37 7
17 - 37 10
18 - 37 11
19 - 37 6
20 - 40 10
21 - 40 1
22 - 41 5
23 - 41 6
24 - 41 7
25 - 42 5
26 - 42 6
27 - 42 7
28 - 43 5
29 - 43 6
30 - 43 7
31 - 44 5
32 - 44 6
33 - 44 7
34 - 45 5
35 - 45 6
36 - 45 7
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
