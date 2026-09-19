begin_version
4
end_version
begin_metric
< 47
end_metric
28
begin_variable
var0
-1
8
Atom at-robot(robot1, base)
Atom at-robot(robot1, zone1)
Atom at-robot(robot1, zone2)
Atom at-robot(robot1, zone3)
Atom at-robot(robot1, zone4)
Atom at-robot(robot1, zone5)
Atom at-robot(robot1, zone6)
Atom at-robot(robot1, zone7)
end_variable
begin_variable
var1
-1
9
Atom container-at(watering-can1, base)
Atom container-at(watering-can1, zone1)
Atom container-at(watering-can1, zone2)
Atom container-at(watering-can1, zone3)
Atom container-at(watering-can1, zone4)
Atom container-at(watering-can1, zone5)
Atom container-at(watering-can1, zone6)
Atom container-at(watering-can1, zone7)
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
30
2
Atom new-axiom@0()
NegatedAtom new-axiom@0()
end_variable
begin_variable
var4
30
2
Atom new-axiom@1()
NegatedAtom new-axiom@1()
end_variable
begin_variable
var5
29
3
< 16 0
>= 16 0
<none of those>
end_variable
begin_variable
var6
29
3
>= 17 0
< 17 0
<none of those>
end_variable
begin_variable
var7
29
3
>= 19 0
< 19 0
<none of those>
end_variable
begin_variable
var8
29
3
>= 20 0
< 20 0
<none of those>
end_variable
begin_variable
var9
29
3
>= 21 0
< 21 0
<none of those>
end_variable
begin_variable
var10
29
3
>= 26 0
< 26 0
<none of those>
end_variable
begin_variable
var11
29
3
< 27 0
>= 27 0
<none of those>
end_variable
begin_variable
var12
29
3
< 34 0
>= 34 0
<none of those>
end_variable
begin_variable
var13
29
3
>= 22 0
< 22 0
<none of those>
end_variable
begin_variable
var14
29
3
>= 24 0
< 24 0
<none of those>
end_variable
begin_variable
var15
29
3
>= 23 0
< 23 0
<none of those>
end_variable
begin_variable
var16
29
3
< 25 0
>= 25 0
<none of those>
end_variable
begin_variable
var17
29
3
>= 18 0
< 18 0
<none of those>
end_variable
begin_variable
var18
29
3
< 39 0
>= 39 0
<none of those>
end_variable
begin_variable
var19
29
3
< 37 0
>= 37 0
<none of those>
end_variable
begin_variable
var20
29
3
< 31 0
>= 31 0
<none of those>
end_variable
begin_variable
var21
29
3
< 44 0
>= 44 0
<none of those>
end_variable
begin_variable
var22
29
3
>= 34 0
< 34 0
<none of those>
end_variable
begin_variable
var23
29
3
>= 39 0
< 39 0
<none of those>
end_variable
begin_variable
var24
29
3
>= 44 0
< 44 0
<none of those>
end_variable
begin_variable
var25
29
3
>= 27 0
< 27 0
<none of those>
end_variable
begin_variable
var26
29
3
>= 37 0
< 37 0
<none of those>
end_variable
begin_variable
var27
29
3
>= 31 0
< 31 0
<none of those>
end_variable
55
begin_numeric_variables
C -1 PNE derived!0.0()
C -1 PNE derived!1.0()
C -1 PNE derived!10.0()
C -1 PNE derived!11.0()
C -1 PNE derived!12.0()
C -1 PNE derived!13.0()
C -1 PNE derived!15.0()
C -1 PNE derived!2.0()
C -1 PNE derived!3.0()
C -1 PNE derived!4.0()
C -1 PNE derived!47.0()
C -1 PNE derived!5.0()
C -1 PNE derived!6.0()
C -1 PNE derived!7.0()
C -1 PNE derived!8.0()
C -1 PNE derived!9.0()
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE watering-unit-energy()(robot1)
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone4)
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone7, zone3)
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone7, zone2)
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone6, zone1)
D 7 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone7, zone5)
D 8 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone3)
D 9 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
D 10 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
D 11 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant1, plant5)
D 12 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant1, plant4)
D 13 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant1, plant6)
D 14 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant2, plant5)
D 15 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant2, plant4)
D 16 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant2, plant6)
D 17 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant3, plant5)
D 18 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant3, plant4)
D 19 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant3, plant6)
D 20 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant4, plant5)
D 21 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant4, plant4)
D 22 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant4, plant6)
D 23 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant5, plant5)
D 24 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant5, plant4)
D 25 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant5, plant6)
D 26 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant6, plant5)
D 27 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant6, plant4)
D 28 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant6, plant6)
R -1 PNE battery-level(robot1)
I -1 PNE total-cost()
R -1 PNE total-watering-time()
R -1 PNE water-level(watering-can1)
R -1 PNE watered-amount(plant1)
R -1 PNE watered-amount(plant2)
R -1 PNE watered-amount(plant3)
R -1 PNE watered-amount(plant4)
R -1 PNE watered-amount(plant5)
R -1 PNE watered-amount(plant6)
end_numeric_variables
3
begin_mutex_group
8
0 0
0 1
0 2
0 3
0 4
0 5
0 6
0 7
end_mutex_group
begin_mutex_group
9
1 0
1 1
1 2
1 3
1 4
1 5
1 6
1 7
1 8
end_mutex_group
begin_mutex_group
2
1 8
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
2
2
2
end_state
begin_numeric_state
0.0
1.0
10.0
11.0
12.0
13.0
15.0
2.0
3.0
4.0
47.0
5.0
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
47.0
0.0
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
48
begin_operator
charge-battery robot1 base
2
0 0
5 0
0
3
0 45 = 10
0 46 + 1
0 47 + 6
1.0
end_operator
begin_operator
charge-battery robot1 zone5
2
0 5
5 0
0
3
0 45 = 10
0 46 + 1
0 47 + 6
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 base
2
0 0
6 0
2
0 1 8 0
0 2 -1 0
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone1
2
0 1
6 0
2
0 1 8 1
0 2 -1 0
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone2
2
0 2
6 0
2
0 1 8 2
0 2 -1 0
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone3
2
0 3
6 0
2
0 1 8 3
0 2 -1 0
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone4
2
0 4
6 0
2
0 1 8 4
0 2 -1 0
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone5
2
0 5
6 0
2
0 1 8 5
0 2 -1 0
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone6
2
0 6
6 0
2
0 1 8 6
0 2 -1 0
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone7
2
0 7
6 0
2
0 1 8 7
0 2 -1 0
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
fill-container robot1 watering-can1 zone3
4
0 3
1 8
16 0
17 0
0
4
0 45 - 7
0 46 + 1
0 47 + 12
0 48 = 15
1.0
end_operator
begin_operator
fill-container robot1 watering-can1 zone6
4
0 6
1 8
16 0
17 0
0
4
0 45 - 7
0 46 + 1
0 47 + 12
0 48 = 15
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 45 - 8
0 46 + 1
0 47 + 9
1.0
end_operator
begin_operator
move robot1 base zone4
1
8 0
1
0 0 0 4
3
0 45 - 2
0 46 + 1
0 47 + 4
1.0
end_operator
begin_operator
move robot1 base zone5
1
9 0
1
0 0 0 5
3
0 45 - 11
0 46 + 1
0 47 + 14
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 45 - 8
0 46 + 1
0 47 + 9
1.0
end_operator
begin_operator
move robot1 zone1 zone6
1
13 0
1
0 0 1 6
3
0 45 - 13
0 46 + 1
0 47 + 2
1.0
end_operator
begin_operator
move robot1 zone2 zone3
1
15 0
1
0 0 2 3
3
0 45 - 14
0 46 + 1
0 47 + 15
1.0
end_operator
begin_operator
move robot1 zone2 zone7
1
9 0
1
0 0 2 7
3
0 45 - 11
0 46 + 1
0 47 + 15
1.0
end_operator
begin_operator
move robot1 zone3 zone2
1
15 0
1
0 0 3 2
3
0 45 - 14
0 46 + 1
0 47 + 15
1.0
end_operator
begin_operator
move robot1 zone3 zone5
1
14 0
1
0 0 3 5
3
0 45 - 15
0 46 + 1
0 47 + 4
1.0
end_operator
begin_operator
move robot1 zone3 zone7
1
8 0
1
0 0 3 7
3
0 45 - 2
0 46 + 1
0 47 + 5
1.0
end_operator
begin_operator
move robot1 zone4 base
1
8 0
1
0 0 4 0
3
0 45 - 2
0 46 + 1
0 47 + 4
1.0
end_operator
begin_operator
move robot1 zone4 zone5
1
7 0
1
0 0 4 5
3
0 45 - 8
0 46 + 1
0 47 + 13
1.0
end_operator
begin_operator
move robot1 zone5 base
1
9 0
1
0 0 5 0
3
0 45 - 11
0 46 + 1
0 47 + 14
1.0
end_operator
begin_operator
move robot1 zone5 zone3
1
14 0
1
0 0 5 3
3
0 45 - 15
0 46 + 1
0 47 + 4
1.0
end_operator
begin_operator
move robot1 zone5 zone4
1
7 0
1
0 0 5 4
3
0 45 - 8
0 46 + 1
0 47 + 13
1.0
end_operator
begin_operator
move robot1 zone5 zone6
1
15 0
1
0 0 5 6
3
0 45 - 14
0 46 + 1
0 47 + 4
1.0
end_operator
begin_operator
move robot1 zone5 zone7
1
15 0
1
0 0 5 7
3
0 45 - 14
0 46 + 1
0 47 + 3
1.0
end_operator
begin_operator
move robot1 zone6 zone1
1
13 0
1
0 0 6 1
3
0 45 - 13
0 46 + 1
0 47 + 2
1.0
end_operator
begin_operator
move robot1 zone6 zone5
1
15 0
1
0 0 6 5
3
0 45 - 14
0 46 + 1
0 47 + 4
1.0
end_operator
begin_operator
move robot1 zone7 zone2
1
9 0
1
0 0 7 2
3
0 45 - 11
0 46 + 1
0 47 + 15
1.0
end_operator
begin_operator
move robot1 zone7 zone3
1
8 0
1
0 0 7 3
3
0 45 - 2
0 46 + 1
0 47 + 5
1.0
end_operator
begin_operator
move robot1 zone7 zone5
1
15 0
1
0 0 7 5
3
0 45 - 14
0 46 + 1
0 47 + 3
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 base
2
0 0
6 0
2
0 1 0 8
0 2 0 1
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone1
2
0 1
6 0
2
0 1 1 8
0 2 0 1
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone2
2
0 2
6 0
2
0 1 2 8
0 2 0 1
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone3
2
0 3
6 0
2
0 1 3 8
0 2 0 1
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone4
2
0 4
6 0
2
0 1 4 8
0 2 0 1
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone5
2
0 5
6 0
2
0 1 5 8
0 2 0 1
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone6
2
0 6
6 0
2
0 1 6 8
0 2 0 1
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone7
2
0 7
6 0
2
0 1 7 8
0 2 0 1
3
0 45 - 1
0 46 + 1
0 47 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant1 zone4
5
0 4
1 8
6 0
10 0
11 0
0
5
0 45 - 1
0 46 + 1
0 47 + 7
0 48 - 1
0 49 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant2 zone2
5
0 2
1 8
6 0
10 0
20 0
0
5
0 45 - 1
0 46 + 1
0 47 + 7
0 48 - 1
0 50 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant3 zone5
5
0 5
1 8
6 0
10 0
12 0
0
5
0 45 - 1
0 46 + 1
0 47 + 7
0 48 - 1
0 51 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant4 zone7
5
0 7
1 8
6 0
10 0
19 0
0
5
0 45 - 1
0 46 + 1
0 47 + 7
0 48 - 1
0 52 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant5 zone3
5
0 3
1 8
6 0
10 0
18 0
0
5
0 45 - 1
0 46 + 1
0 47 + 7
0 48 - 1
0 53 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant6 zone2
5
0 2
1 8
6 0
10 0
21 0
0
5
0 45 - 1
0 46 + 1
0 47 + 7
0 48 - 1
0 54 + 1
1.0
end_operator
2
begin_rule
0
3 1 0
end_rule
begin_rule
9
0 0
1 0
2 0
22 0
23 0
24 0
25 0
26 0
27 0
4 1 0
end_rule
23
begin_comparison_axioms
5 < 16 0
6 >= 17 0
7 >= 19 0
8 >= 20 0
9 >= 21 0
10 >= 26 0
11 < 27 0
12 < 34 0
13 >= 22 0
14 >= 24 0
15 >= 23 0
16 < 25 0
17 >= 18 0
18 < 39 0
19 < 37 0
20 < 31 0
21 < 44 0
22 >= 34 0
23 >= 39 0
24 >= 44 0
25 >= 27 0
26 >= 37 0
27 >= 31 0
end_comparison_axioms
29
begin_numeric_axioms
16 - 45 10
17 - 45 1
18 - 45 7
19 - 45 8
20 - 45 2
21 - 45 11
22 - 45 13
23 - 45 14
24 - 45 15
25 - 48 15
26 - 48 1
27 - 49 8
28 - 49 12
29 - 49 11
30 - 50 8
31 - 50 12
32 - 50 11
33 - 51 8
34 - 51 12
35 - 51 11
36 - 52 8
37 - 52 12
38 - 52 11
39 - 53 8
40 - 53 12
41 - 53 11
42 - 54 8
43 - 54 12
44 - 54 11
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
