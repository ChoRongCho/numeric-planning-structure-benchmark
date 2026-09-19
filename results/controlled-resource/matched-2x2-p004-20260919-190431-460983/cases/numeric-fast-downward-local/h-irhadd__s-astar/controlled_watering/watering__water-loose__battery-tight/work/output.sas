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
>= 33 41
< 33 41
<none of those>
end_variable
begin_variable
var6
29
3
< 45 41
>= 45 41
<none of those>
end_variable
begin_variable
var7
29
3
>= 26 41
< 26 41
<none of those>
end_variable
begin_variable
var8
29
3
>= 1 41
< 1 41
<none of those>
end_variable
begin_variable
var9
29
3
>= 3 41
< 3 41
<none of those>
end_variable
begin_variable
var10
29
3
>= 29 41
< 29 41
<none of those>
end_variable
begin_variable
var11
29
3
< 18 41
>= 18 41
<none of those>
end_variable
begin_variable
var12
29
3
< 7 41
>= 7 41
<none of those>
end_variable
begin_variable
var13
29
3
>= 19 41
< 19 41
<none of those>
end_variable
begin_variable
var14
29
3
>= 25 41
< 25 41
<none of those>
end_variable
begin_variable
var15
29
3
>= 12 41
< 12 41
<none of those>
end_variable
begin_variable
var16
29
3
< 15 41
>= 15 41
<none of those>
end_variable
begin_variable
var17
29
3
>= 40 41
< 40 41
<none of those>
end_variable
begin_variable
var18
29
3
< 23 41
>= 23 41
<none of those>
end_variable
begin_variable
var19
29
3
< 20 41
>= 20 41
<none of those>
end_variable
begin_variable
var20
29
3
< 2 41
>= 2 41
<none of those>
end_variable
begin_variable
var21
29
3
< 9 41
>= 9 41
<none of those>
end_variable
begin_variable
var22
29
3
>= 9 41
< 9 41
<none of those>
end_variable
begin_variable
var23
29
3
>= 23 41
< 23 41
<none of those>
end_variable
begin_variable
var24
29
3
>= 18 41
< 18 41
<none of those>
end_variable
begin_variable
var25
29
3
>= 2 41
< 2 41
<none of those>
end_variable
begin_variable
var26
29
3
>= 20 41
< 20 41
<none of those>
end_variable
begin_variable
var27
29
3
>= 7 41
< 7 41
<none of those>
end_variable
56
begin_numeric_variables
D 28 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant6, plant4)
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone7, zone3)
D 17 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant2, plant3)
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone2, zone7)
D 12 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant5, plant6)
C -1 PNE derived!6.0()
D 23 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant3, plant1)
D 15 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant3, plant3)
D 25 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant4, plant6)
D 22 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant6, plant6)
D 16 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant6, plant1)
D 20 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant3, plant6)
D 7 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone7, zone5)
D 26 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant2, plant1)
D 27 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant4, plant1)
D 9 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
D 11 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant1, plant6)
D 21 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant5, plant4)
D 13 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant5)
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone1, zone6)
D 24 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant4, plant3)
C -1 PNE derived!5.0()
D 19 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant3)
D 18 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant5, plant1)
C -1 PNE derived!15.0()
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, zone5)
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone4)
C -1 PNE derived!12.0()
C -1 PNE derived!10.0()
D 10 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
D 14 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant2, plant6)
C -1 PNE derived!13.0()
C -1 PNE derived!2.0()
D 8 PNE derived!difference_PNE battery-level(?robot)_PNE drop-energy()(robot1)
C -1 PNE derived!8.0()
C -1 PNE derived!11.0()
C -1 PNE derived!1.0()
C -1 PNE derived!3.0()
C -1 PNE derived!7.0()
C -1 PNE derived!29.0()
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
C -1 PNE derived!0.0()
C -1 PNE derived!47.0()
C -1 PNE derived!4.0()
C -1 PNE derived!9.0()
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
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
6.0
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
5.0
0.0
0.0
15.0
0.0
0.0
12.0
10.0
0.0
0.0
13.0
2.0
0.0
8.0
11.0
1.0
3.0
7.0
29.0
0.0
0.0
47.0
4.0
9.0
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
6 0
0
3
0 46 = 42
0 47 + 36
0 48 + 24
1.0
end_operator
begin_operator
charge-battery robot1 zone5
2
0 5
6 0
0
3
0 46 = 42
0 47 + 36
0 48 + 24
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 32
0 47 + 36
0 48 + 5
0 49 = 39
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
0 46 - 32
0 47 + 36
0 48 + 5
0 49 = 39
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 46 - 37
0 47 + 36
0 48 + 43
1.0
end_operator
begin_operator
move robot1 base zone4
1
8 0
1
0 0 0 4
3
0 46 - 28
0 47 + 36
0 48 + 27
1.0
end_operator
begin_operator
move robot1 base zone5
1
9 0
1
0 0 0 5
3
0 46 - 21
0 47 + 36
0 48 + 34
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 46 - 37
0 47 + 36
0 48 + 43
1.0
end_operator
begin_operator
move robot1 zone1 zone6
1
13 0
1
0 0 1 6
3
0 46 - 38
0 47 + 36
0 48 + 28
1.0
end_operator
begin_operator
move robot1 zone2 zone3
1
15 0
1
0 0 2 3
3
0 46 - 34
0 47 + 36
0 48 + 44
1.0
end_operator
begin_operator
move robot1 zone2 zone7
1
9 0
1
0 0 2 7
3
0 46 - 21
0 47 + 36
0 48 + 44
1.0
end_operator
begin_operator
move robot1 zone3 zone2
1
15 0
1
0 0 3 2
3
0 46 - 34
0 47 + 36
0 48 + 44
1.0
end_operator
begin_operator
move robot1 zone3 zone5
1
14 0
1
0 0 3 5
3
0 46 - 44
0 47 + 36
0 48 + 27
1.0
end_operator
begin_operator
move robot1 zone3 zone7
1
8 0
1
0 0 3 7
3
0 46 - 28
0 47 + 36
0 48 + 31
1.0
end_operator
begin_operator
move robot1 zone4 base
1
8 0
1
0 0 4 0
3
0 46 - 28
0 47 + 36
0 48 + 27
1.0
end_operator
begin_operator
move robot1 zone4 zone5
1
7 0
1
0 0 4 5
3
0 46 - 37
0 47 + 36
0 48 + 38
1.0
end_operator
begin_operator
move robot1 zone5 base
1
9 0
1
0 0 5 0
3
0 46 - 21
0 47 + 36
0 48 + 34
1.0
end_operator
begin_operator
move robot1 zone5 zone3
1
14 0
1
0 0 5 3
3
0 46 - 44
0 47 + 36
0 48 + 27
1.0
end_operator
begin_operator
move robot1 zone5 zone4
1
7 0
1
0 0 5 4
3
0 46 - 37
0 47 + 36
0 48 + 38
1.0
end_operator
begin_operator
move robot1 zone5 zone6
1
15 0
1
0 0 5 6
3
0 46 - 34
0 47 + 36
0 48 + 27
1.0
end_operator
begin_operator
move robot1 zone5 zone7
1
15 0
1
0 0 5 7
3
0 46 - 34
0 47 + 36
0 48 + 35
1.0
end_operator
begin_operator
move robot1 zone6 zone1
1
13 0
1
0 0 6 1
3
0 46 - 38
0 47 + 36
0 48 + 28
1.0
end_operator
begin_operator
move robot1 zone6 zone5
1
15 0
1
0 0 6 5
3
0 46 - 34
0 47 + 36
0 48 + 27
1.0
end_operator
begin_operator
move robot1 zone7 zone2
1
9 0
1
0 0 7 2
3
0 46 - 21
0 47 + 36
0 48 + 44
1.0
end_operator
begin_operator
move robot1 zone7 zone3
1
8 0
1
0 0 7 3
3
0 46 - 28
0 47 + 36
0 48 + 31
1.0
end_operator
begin_operator
move robot1 zone7 zone5
1
15 0
1
0 0 7 5
3
0 46 - 34
0 47 + 36
0 48 + 35
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 36
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
0 46 - 36
0 47 + 36
0 48 + 32
0 49 - 36
0 50 + 36
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
0 46 - 36
0 47 + 36
0 48 + 32
0 49 - 36
0 51 + 36
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
0 46 - 36
0 47 + 36
0 48 + 32
0 49 - 36
0 52 + 36
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
0 46 - 36
0 47 + 36
0 48 + 32
0 49 - 36
0 53 + 36
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
0 46 - 36
0 47 + 36
0 48 + 32
0 49 - 36
0 54 + 36
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
0 46 - 36
0 47 + 36
0 48 + 32
0 49 - 36
0 55 + 36
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
5 >= 33 41
6 < 45 41
7 >= 26 41
8 >= 1 41
9 >= 3 41
10 >= 29 41
11 < 18 41
12 < 7 41
13 >= 19 41
14 >= 25 41
15 >= 12 41
16 < 15 41
17 >= 40 41
18 < 23 41
19 < 20 41
20 < 2 41
21 < 9 41
22 >= 9 41
23 >= 23 41
24 >= 18 41
25 >= 2 41
26 >= 20 41
27 >= 7 41
end_comparison_axioms
29
begin_numeric_axioms
0 - 55 5
1 - 46 28
2 - 51 5
3 - 46 21
4 - 54 21
6 - 52 37
7 - 52 5
8 - 53 21
9 - 55 21
10 - 55 37
11 - 52 21
12 - 46 34
13 - 51 37
14 - 53 37
15 - 49 39
16 - 50 21
17 - 54 5
18 - 50 37
19 - 46 38
20 - 53 5
22 - 50 5
23 - 54 37
25 - 46 44
26 - 46 37
29 - 49 36
30 - 51 21
33 - 46 36
40 - 46 32
45 - 46 42
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
