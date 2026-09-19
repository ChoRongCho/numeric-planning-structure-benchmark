begin_version
4
end_version
begin_metric
< 48
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
>= 40 24
< 40 24
<none of those>
end_variable
begin_variable
var6
29
3
< 15 24
>= 15 24
<none of those>
end_variable
begin_variable
var7
29
3
>= 12 24
< 12 24
<none of those>
end_variable
begin_variable
var8
29
3
>= 18 24
< 18 24
<none of those>
end_variable
begin_variable
var9
29
3
>= 32 24
< 32 24
<none of those>
end_variable
begin_variable
var10
29
3
>= 38 24
< 38 24
<none of those>
end_variable
begin_variable
var11
29
3
< 29 24
>= 29 24
<none of those>
end_variable
begin_variable
var12
29
3
< 14 24
>= 14 24
<none of those>
end_variable
begin_variable
var13
29
3
>= 25 24
< 25 24
<none of those>
end_variable
begin_variable
var14
29
3
>= 28 24
< 28 24
<none of those>
end_variable
begin_variable
var15
29
3
>= 1 24
< 1 24
<none of those>
end_variable
begin_variable
var16
29
3
< 34 24
>= 34 24
<none of those>
end_variable
begin_variable
var17
29
3
>= 43 24
< 43 24
<none of those>
end_variable
begin_variable
var18
29
3
< 6 24
>= 6 24
<none of those>
end_variable
begin_variable
var19
29
3
< 10 24
>= 10 24
<none of those>
end_variable
begin_variable
var20
29
3
< 3 24
>= 3 24
<none of those>
end_variable
begin_variable
var21
29
3
< 31 24
>= 31 24
<none of those>
end_variable
begin_variable
var22
29
3
>= 31 24
< 31 24
<none of those>
end_variable
begin_variable
var23
29
3
>= 10 24
< 10 24
<none of those>
end_variable
begin_variable
var24
29
3
>= 14 24
< 14 24
<none of those>
end_variable
begin_variable
var25
29
3
>= 3 24
< 3 24
<none of those>
end_variable
begin_variable
var26
29
3
>= 6 24
< 6 24
<none of those>
end_variable
begin_variable
var27
29
3
>= 29 24
< 29 24
<none of those>
end_variable
56
begin_numeric_variables
D 16 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant2, plant6)
D 7 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone6)
D 28 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant6, plant2)
D 11 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant2, plant3)
D 24 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant5, plant6)
D 20 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant4, plant1)
D 17 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant5, plant5)
D 15 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant2, plant1)
D 22 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant3, plant5)
D 18 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant2)
D 23 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant4, plant2)
D 27 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant6, plant5)
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, base, zone1)
D 21 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant1, plant6)
D 19 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant3, plant4)
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
C -1 PNE derived!9.0()
D 14 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant5, plant4)
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, zone7)
C -1 PNE derived!3.0()
D 12 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant3, plant6)
C -1 PNE derived!29.0()
C -1 PNE derived!7.0()
C -1 PNE derived!6.0()
C -1 PNE derived!0.0()
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone1, zone6)
C -1 PNE derived!5.0()
D 13 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant4, plant6)
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, zone5)
D 26 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant5)
C -1 PNE derived!12.0()
D 25 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant6, plant6)
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone2, zone7)
C -1 PNE derived!10.0()
D 9 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
C -1 PNE derived!15.0()
C -1 PNE derived!141.0()
C -1 PNE derived!8.0()
D 10 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
C -1 PNE derived!1.0()
D 8 PNE derived!difference_PNE battery-level(?robot)_PNE watering-unit-energy()(robot1)
C -1 PNE derived!13.0()
C -1 PNE derived!2.0()
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
C -1 PNE derived!4.0()
C -1 PNE derived!11.0()
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
9.0
0.0
0.0
3.0
0.0
29.0
7.0
6.0
0.0
0.0
5.0
0.0
0.0
0.0
12.0
0.0
0.0
10.0
0.0
15.0
141.0
8.0
0.0
1.0
0.0
13.0
2.0
0.0
4.0
11.0
141.0
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
6 0
0
3
0 46 = 36
0 47 + 39
0 48 + 35
1.0
end_operator
begin_operator
charge-battery robot1 zone5
2
0 5
6 0
0
3
0 46 = 36
0 47 + 39
0 48 + 35
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 base
2
0 0
5 0
2
0 1 8 0
0 2 -1 0
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone1
2
0 1
5 0
2
0 1 8 1
0 2 -1 0
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone2
2
0 2
5 0
2
0 1 8 2
0 2 -1 0
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone3
2
0 3
5 0
2
0 1 8 3
0 2 -1 0
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone4
2
0 4
5 0
2
0 1 8 4
0 2 -1 0
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone5
2
0 5
5 0
2
0 1 8 5
0 2 -1 0
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone6
2
0 6
5 0
2
0 1 8 6
0 2 -1 0
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
drop-container robot1 watering-can1 zone7
2
0 7
5 0
2
0 1 8 7
0 2 -1 0
3
0 46 - 39
0 47 + 39
0 48 + 39
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
0 46 - 42
0 47 + 39
0 48 + 23
0 49 = 21
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
0 46 - 42
0 47 + 39
0 48 + 23
0 49 = 21
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 46 - 19
0 47 + 39
0 48 + 44
1.0
end_operator
begin_operator
move robot1 base zone4
1
8 0
1
0 0 0 4
3
0 46 - 33
0 47 + 39
0 48 + 30
1.0
end_operator
begin_operator
move robot1 base zone5
1
9 0
1
0 0 0 5
3
0 46 - 26
0 47 + 39
0 48 + 37
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 46 - 19
0 47 + 39
0 48 + 44
1.0
end_operator
begin_operator
move robot1 zone1 zone6
1
13 0
1
0 0 1 6
3
0 46 - 22
0 47 + 39
0 48 + 33
1.0
end_operator
begin_operator
move robot1 zone2 zone3
1
15 0
1
0 0 2 3
3
0 46 - 37
0 47 + 39
0 48 + 16
1.0
end_operator
begin_operator
move robot1 zone2 zone7
1
9 0
1
0 0 2 7
3
0 46 - 26
0 47 + 39
0 48 + 16
1.0
end_operator
begin_operator
move robot1 zone3 zone2
1
15 0
1
0 0 3 2
3
0 46 - 37
0 47 + 39
0 48 + 16
1.0
end_operator
begin_operator
move robot1 zone3 zone5
1
14 0
1
0 0 3 5
3
0 46 - 16
0 47 + 39
0 48 + 30
1.0
end_operator
begin_operator
move robot1 zone3 zone7
1
8 0
1
0 0 3 7
3
0 46 - 33
0 47 + 39
0 48 + 41
1.0
end_operator
begin_operator
move robot1 zone4 base
1
8 0
1
0 0 4 0
3
0 46 - 33
0 47 + 39
0 48 + 30
1.0
end_operator
begin_operator
move robot1 zone4 zone5
1
7 0
1
0 0 4 5
3
0 46 - 19
0 47 + 39
0 48 + 22
1.0
end_operator
begin_operator
move robot1 zone5 base
1
9 0
1
0 0 5 0
3
0 46 - 26
0 47 + 39
0 48 + 37
1.0
end_operator
begin_operator
move robot1 zone5 zone3
1
14 0
1
0 0 5 3
3
0 46 - 16
0 47 + 39
0 48 + 30
1.0
end_operator
begin_operator
move robot1 zone5 zone4
1
7 0
1
0 0 5 4
3
0 46 - 19
0 47 + 39
0 48 + 22
1.0
end_operator
begin_operator
move robot1 zone5 zone6
1
15 0
1
0 0 5 6
3
0 46 - 37
0 47 + 39
0 48 + 30
1.0
end_operator
begin_operator
move robot1 zone5 zone7
1
15 0
1
0 0 5 7
3
0 46 - 37
0 47 + 39
0 48 + 45
1.0
end_operator
begin_operator
move robot1 zone6 zone1
1
13 0
1
0 0 6 1
3
0 46 - 22
0 47 + 39
0 48 + 33
1.0
end_operator
begin_operator
move robot1 zone6 zone5
1
15 0
1
0 0 6 5
3
0 46 - 37
0 47 + 39
0 48 + 30
1.0
end_operator
begin_operator
move robot1 zone7 zone2
1
9 0
1
0 0 7 2
3
0 46 - 26
0 47 + 39
0 48 + 16
1.0
end_operator
begin_operator
move robot1 zone7 zone3
1
8 0
1
0 0 7 3
3
0 46 - 33
0 47 + 39
0 48 + 41
1.0
end_operator
begin_operator
move robot1 zone7 zone5
1
15 0
1
0 0 7 5
3
0 46 - 37
0 47 + 39
0 48 + 45
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 base
2
0 0
5 0
2
0 1 0 8
0 2 0 1
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone1
2
0 1
5 0
2
0 1 1 8
0 2 0 1
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone2
2
0 2
5 0
2
0 1 2 8
0 2 0 1
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone3
2
0 3
5 0
2
0 1 3 8
0 2 0 1
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone4
2
0 4
5 0
2
0 1 4 8
0 2 0 1
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone5
2
0 5
5 0
2
0 1 5 8
0 2 0 1
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone6
2
0 6
5 0
2
0 1 6 8
0 2 0 1
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
pick-container robot1 watering-can1 zone7
2
0 7
5 0
2
0 1 7 8
0 2 0 1
3
0 46 - 39
0 47 + 39
0 48 + 39
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant1 zone4
5
0 4
1 8
5 0
10 0
11 0
0
5
0 46 - 39
0 47 + 39
0 48 + 42
0 49 - 39
0 50 + 39
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant2 zone2
5
0 2
1 8
5 0
10 0
20 0
0
5
0 46 - 39
0 47 + 39
0 48 + 42
0 49 - 39
0 51 + 39
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant3 zone5
5
0 5
1 8
5 0
10 0
12 0
0
5
0 46 - 39
0 47 + 39
0 48 + 42
0 49 - 39
0 52 + 39
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant4 zone7
5
0 7
1 8
5 0
10 0
19 0
0
5
0 46 - 39
0 47 + 39
0 48 + 42
0 49 - 39
0 53 + 39
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant5 zone3
5
0 3
1 8
5 0
10 0
18 0
0
5
0 46 - 39
0 47 + 39
0 48 + 42
0 49 - 39
0 54 + 39
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant6 zone2
5
0 2
1 8
5 0
10 0
21 0
0
5
0 46 - 39
0 47 + 39
0 48 + 42
0 49 - 39
0 55 + 39
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
5 >= 40 24
6 < 15 24
7 >= 12 24
8 >= 18 24
9 >= 32 24
10 >= 38 24
11 < 29 24
12 < 14 24
13 >= 25 24
14 >= 28 24
15 >= 1 24
16 < 34 24
17 >= 43 24
18 < 6 24
19 < 10 24
20 < 3 24
21 < 31 24
22 >= 31 24
23 >= 10 24
24 >= 14 24
25 >= 3 24
26 >= 6 24
27 >= 29 24
end_comparison_axioms
29
begin_numeric_axioms
0 - 51 26
1 - 46 37
2 - 55 23
3 - 51 23
4 - 54 26
5 - 53 19
6 - 54 19
7 - 51 19
8 - 52 19
9 - 50 23
10 - 53 23
11 - 55 19
12 - 46 19
13 - 50 26
14 - 52 23
15 - 46 36
17 - 54 23
18 - 46 33
20 - 52 26
25 - 46 22
27 - 53 26
28 - 46 16
29 - 50 19
31 - 55 26
32 - 46 26
34 - 49 21
38 - 49 39
40 - 46 39
43 - 46 42
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
