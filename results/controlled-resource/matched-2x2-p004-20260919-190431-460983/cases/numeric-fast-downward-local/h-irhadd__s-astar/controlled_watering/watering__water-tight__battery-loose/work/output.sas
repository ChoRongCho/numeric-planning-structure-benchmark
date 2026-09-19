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
>= 19 26
< 19 26
<none of those>
end_variable
begin_variable
var6
29
3
< 30 26
>= 30 26
<none of those>
end_variable
begin_variable
var7
29
3
>= 15 26
< 15 26
<none of those>
end_variable
begin_variable
var8
29
3
>= 21 26
< 21 26
<none of those>
end_variable
begin_variable
var9
29
3
>= 32 26
< 32 26
<none of those>
end_variable
begin_variable
var10
29
3
>= 39 26
< 39 26
<none of those>
end_variable
begin_variable
var11
29
3
< 9 26
>= 9 26
<none of those>
end_variable
begin_variable
var12
29
3
< 17 26
>= 17 26
<none of those>
end_variable
begin_variable
var13
29
3
>= 28 26
< 28 26
<none of those>
end_variable
begin_variable
var14
29
3
>= 38 26
< 38 26
<none of those>
end_variable
begin_variable
var15
29
3
>= 20 26
< 20 26
<none of those>
end_variable
begin_variable
var16
29
3
< 34 26
>= 34 26
<none of those>
end_variable
begin_variable
var17
29
3
>= 42 26
< 42 26
<none of those>
end_variable
begin_variable
var18
29
3
< 0 26
>= 0 26
<none of those>
end_variable
begin_variable
var19
29
3
< 1 26
>= 1 26
<none of those>
end_variable
begin_variable
var20
29
3
< 5 26
>= 5 26
<none of those>
end_variable
begin_variable
var21
29
3
< 27 26
>= 27 26
<none of those>
end_variable
begin_variable
var22
29
3
>= 5 26
< 5 26
<none of those>
end_variable
begin_variable
var23
29
3
>= 27 26
< 27 26
<none of those>
end_variable
begin_variable
var24
29
3
>= 1 26
< 1 26
<none of those>
end_variable
begin_variable
var25
29
3
>= 0 26
< 0 26
<none of those>
end_variable
begin_variable
var26
29
3
>= 9 26
< 9 26
<none of those>
end_variable
begin_variable
var27
29
3
>= 17 26
< 17 26
<none of those>
end_variable
55
begin_numeric_variables
D 20 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant5, plant5)
D 15 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant4, plant4)
C -1 PNE derived!11.0()
D 19 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant4, plant6)
D 16 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant5, plant3)
D 14 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant2, plant3)
D 24 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant1, plant4)
D 18 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant2, plant6)
D 28 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant6, plant2)
D 13 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant1, plant5)
D 22 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant4, plant1)
D 27 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant5, plant6)
D 23 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant6, plant1)
D 17 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant2, plant5)
D 26 PNE derived!difference_PNE watered-amount(plant5)_PNE plant-demand(plant5)(plant3, plant5)
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, base, zone1)
D 25 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant1, plant6)
D 21 PNE derived!difference_PNE watered-amount(plant6)_PNE plant-demand(plant6)(plant3, plant4)
C -1 PNE derived!1.0()
D 8 PNE derived!difference_PNE battery-level(?robot)_PNE watering-unit-energy()(robot1)
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone5, zone6)
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, zone7)
C -1 PNE derived!3.0()
D 11 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant3, plant6)
C -1 PNE derived!7.0()
C -1 PNE derived!6.0()
C -1 PNE derived!0.0()
D 12 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant6, plant6)
D 7 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone1, zone6)
C -1 PNE derived!9.0()
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
C -1 PNE derived!12.0()
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone2, zone7)
C -1 PNE derived!10.0()
D 9 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
C -1 PNE derived!5.0()
C -1 PNE derived!15.0()
C -1 PNE derived!141.0()
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, zone5)
D 10 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
C -1 PNE derived!13.0()
C -1 PNE derived!2.0()
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
C -1 PNE derived!4.0()
C -1 PNE derived!8.0()
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
11.0
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
1.0
0.0
0.0
0.0
3.0
0.0
7.0
6.0
0.0
0.0
0.0
9.0
0.0
12.0
0.0
10.0
0.0
5.0
15.0
141.0
0.0
0.0
13.0
2.0
0.0
4.0
8.0
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
0 45 = 37
0 46 + 18
0 47 + 36
1.0
end_operator
begin_operator
charge-battery robot1 zone5
2
0 5
6 0
0
3
0 45 = 37
0 46 + 18
0 47 + 36
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 41
0 46 + 18
0 47 + 25
0 48 = 29
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
0 45 - 41
0 46 + 18
0 47 + 25
0 48 = 29
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 45 - 22
0 46 + 18
0 47 + 43
1.0
end_operator
begin_operator
move robot1 base zone4
1
8 0
1
0 0 0 4
3
0 45 - 33
0 46 + 18
0 47 + 31
1.0
end_operator
begin_operator
move robot1 base zone5
1
9 0
1
0 0 0 5
3
0 45 - 35
0 46 + 18
0 47 + 44
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 45 - 22
0 46 + 18
0 47 + 43
1.0
end_operator
begin_operator
move robot1 zone1 zone6
1
13 0
1
0 0 1 6
3
0 45 - 24
0 46 + 18
0 47 + 33
1.0
end_operator
begin_operator
move robot1 zone2 zone3
1
15 0
1
0 0 2 3
3
0 45 - 44
0 46 + 18
0 47 + 29
1.0
end_operator
begin_operator
move robot1 zone2 zone7
1
9 0
1
0 0 2 7
3
0 45 - 35
0 46 + 18
0 47 + 29
1.0
end_operator
begin_operator
move robot1 zone3 zone2
1
15 0
1
0 0 3 2
3
0 45 - 44
0 46 + 18
0 47 + 29
1.0
end_operator
begin_operator
move robot1 zone3 zone5
1
14 0
1
0 0 3 5
3
0 45 - 29
0 46 + 18
0 47 + 31
1.0
end_operator
begin_operator
move robot1 zone3 zone7
1
8 0
1
0 0 3 7
3
0 45 - 33
0 46 + 18
0 47 + 40
1.0
end_operator
begin_operator
move robot1 zone4 base
1
8 0
1
0 0 4 0
3
0 45 - 33
0 46 + 18
0 47 + 31
1.0
end_operator
begin_operator
move robot1 zone4 zone5
1
7 0
1
0 0 4 5
3
0 45 - 22
0 46 + 18
0 47 + 24
1.0
end_operator
begin_operator
move robot1 zone5 base
1
9 0
1
0 0 5 0
3
0 45 - 35
0 46 + 18
0 47 + 44
1.0
end_operator
begin_operator
move robot1 zone5 zone3
1
14 0
1
0 0 5 3
3
0 45 - 29
0 46 + 18
0 47 + 31
1.0
end_operator
begin_operator
move robot1 zone5 zone4
1
7 0
1
0 0 5 4
3
0 45 - 22
0 46 + 18
0 47 + 24
1.0
end_operator
begin_operator
move robot1 zone5 zone6
1
15 0
1
0 0 5 6
3
0 45 - 44
0 46 + 18
0 47 + 31
1.0
end_operator
begin_operator
move robot1 zone5 zone7
1
15 0
1
0 0 5 7
3
0 45 - 44
0 46 + 18
0 47 + 2
1.0
end_operator
begin_operator
move robot1 zone6 zone1
1
13 0
1
0 0 6 1
3
0 45 - 24
0 46 + 18
0 47 + 33
1.0
end_operator
begin_operator
move robot1 zone6 zone5
1
15 0
1
0 0 6 5
3
0 45 - 44
0 46 + 18
0 47 + 31
1.0
end_operator
begin_operator
move robot1 zone7 zone2
1
9 0
1
0 0 7 2
3
0 45 - 35
0 46 + 18
0 47 + 29
1.0
end_operator
begin_operator
move robot1 zone7 zone3
1
8 0
1
0 0 7 3
3
0 45 - 33
0 46 + 18
0 47 + 40
1.0
end_operator
begin_operator
move robot1 zone7 zone5
1
15 0
1
0 0 7 5
3
0 45 - 44
0 46 + 18
0 47 + 2
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 18
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
0 45 - 18
0 46 + 18
0 47 + 41
0 48 - 18
0 49 + 18
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
0 45 - 18
0 46 + 18
0 47 + 41
0 48 - 18
0 50 + 18
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
0 45 - 18
0 46 + 18
0 47 + 41
0 48 - 18
0 51 + 18
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
0 45 - 18
0 46 + 18
0 47 + 41
0 48 - 18
0 52 + 18
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
0 45 - 18
0 46 + 18
0 47 + 41
0 48 - 18
0 53 + 18
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
0 45 - 18
0 46 + 18
0 47 + 41
0 48 - 18
0 54 + 18
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
5 >= 19 26
6 < 30 26
7 >= 15 26
8 >= 21 26
9 >= 32 26
10 >= 39 26
11 < 9 26
12 < 17 26
13 >= 28 26
14 >= 38 26
15 >= 20 26
16 < 34 26
17 >= 42 26
18 < 0 26
19 < 1 26
20 < 5 26
21 < 27 26
22 >= 5 26
23 >= 27 26
24 >= 1 26
25 >= 0 26
26 >= 9 26
27 >= 17 26
end_comparison_axioms
29
begin_numeric_axioms
0 - 53 22
1 - 52 25
3 - 52 35
4 - 53 25
5 - 50 25
6 - 49 25
7 - 50 35
8 - 54 25
9 - 49 22
10 - 52 22
11 - 53 35
12 - 54 22
13 - 50 22
14 - 51 22
15 - 45 22
16 - 49 35
17 - 51 25
19 - 45 18
20 - 45 44
21 - 45 33
23 - 51 35
27 - 54 35
28 - 45 24
30 - 45 37
32 - 45 35
34 - 48 29
38 - 45 29
39 - 48 18
42 - 45 41
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
