begin_version
4
end_version
begin_metric
< 33
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
>= 19 27
< 19 27
<none of those>
end_variable
begin_variable
var6
17
3
< 25 27
>= 25 27
<none of those>
end_variable
begin_variable
var7
17
3
>= 7 27
< 7 27
<none of those>
end_variable
begin_variable
var8
17
3
>= 13 27
< 13 27
<none of those>
end_variable
begin_variable
var9
17
3
>= 10 27
< 10 27
<none of those>
end_variable
begin_variable
var10
17
3
< 0 27
>= 0 27
<none of those>
end_variable
begin_variable
var11
17
3
< 3 27
>= 3 27
<none of those>
end_variable
begin_variable
var12
17
3
< 12 27
>= 12 27
<none of those>
end_variable
begin_variable
var13
17
3
< 2 27
>= 2 27
<none of those>
end_variable
begin_variable
var14
17
3
>= 1 27
< 1 27
<none of those>
end_variable
begin_variable
var15
17
3
>= 4 27
< 4 27
<none of those>
end_variable
begin_variable
var16
17
3
< 11 27
>= 11 27
<none of those>
end_variable
begin_variable
var17
17
3
>= 22 27
< 22 27
<none of those>
end_variable
begin_variable
var18
17
3
>= 0 27
< 0 27
<none of those>
end_variable
begin_variable
var19
17
3
>= 2 27
< 2 27
<none of those>
end_variable
begin_variable
var20
17
3
>= 12 27
< 12 27
<none of those>
end_variable
begin_variable
var21
17
3
>= 3 27
< 3 27
<none of those>
end_variable
39
begin_numeric_variables
D 12 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant2, plant2)
D 4 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone1, zone2)
D 9 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant1, plant1)
D 11 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant3, plant2)
D 5 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, zone2)
D 13 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant4, plant3)
D 14 PNE derived!difference_PNE watered-amount(?plant)_PNE plant-demand(?plant)(plant3, plant4)
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone3, zone1)
D 16 PNE derived!difference_PNE watered-amount(plant2)_PNE plant-demand(plant2)(plant2, plant4)
D 10 PNE derived!difference_PNE watered-amount(plant3)_PNE plant-demand(plant3)(plant1, plant3)
D 8 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(watering-can1)
D 7 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(watering-can1, watering-can1)
D 15 PNE derived!difference_PNE watered-amount(plant4)_PNE plant-demand(plant4)(plant4, plant4)
D 3 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, zone1, zone4)
C -1 PNE derived!2.0()
C -1 PNE derived!8.0()
C -1 PNE derived!18.0()
C -1 PNE derived!11.0()
C -1 PNE derived!1.0()
D 6 PNE derived!difference_PNE battery-level(?robot)_PNE watering-unit-energy()(robot1)
C -1 PNE derived!3.0()
C -1 PNE derived!7.0()
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE fill-energy()(robot1)
C -1 PNE derived!4.0()
C -1 PNE derived!9.0()
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
C -1 PNE derived!6.0()
C -1 PNE derived!0.0()
C -1 PNE derived!59.0()
C -1 PNE derived!5.0()
C -1 PNE derived!15.0()
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
2.0
8.0
18.0
11.0
1.0
0.0
3.0
7.0
0.0
4.0
9.0
0.0
6.0
0.0
59.0
5.0
15.0
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
6 0
0
3
0 31 = 28
0 32 + 18
0 33 + 30
1.0
end_operator
begin_operator
charge-battery robot1 zone3
2
0 3
6 0
0
3
0 31 = 28
0 32 + 18
0 33 + 30
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 14
0 32 + 18
0 33 + 26
0 34 = 16
1.0
end_operator
begin_operator
move robot1 base zone1
1
7 0
1
0 0 0 1
3
0 31 - 29
0 32 + 18
0 33 + 21
1.0
end_operator
begin_operator
move robot1 base zone3
1
8 0
1
0 0 0 3
3
0 31 - 20
0 32 + 18
0 33 + 23
1.0
end_operator
begin_operator
move robot1 zone1 base
1
7 0
1
0 0 1 0
3
0 31 - 29
0 32 + 18
0 33 + 21
1.0
end_operator
begin_operator
move robot1 zone1 zone2
1
14 0
1
0 0 1 2
3
0 31 - 26
0 32 + 18
0 33 + 15
1.0
end_operator
begin_operator
move robot1 zone1 zone3
1
7 0
1
0 0 1 3
3
0 31 - 29
0 32 + 18
0 33 + 26
1.0
end_operator
begin_operator
move robot1 zone1 zone4
1
8 0
1
0 0 1 4
3
0 31 - 20
0 32 + 18
0 33 + 26
1.0
end_operator
begin_operator
move robot1 zone2 zone1
1
14 0
1
0 0 2 1
3
0 31 - 26
0 32 + 18
0 33 + 15
1.0
end_operator
begin_operator
move robot1 zone2 zone3
1
15 0
1
0 0 2 3
3
0 31 - 24
0 32 + 18
0 33 + 17
1.0
end_operator
begin_operator
move robot1 zone2 zone5
1
15 0
1
0 0 2 5
3
0 31 - 24
0 32 + 18
0 33 + 17
1.0
end_operator
begin_operator
move robot1 zone3 base
1
8 0
1
0 0 3 0
3
0 31 - 20
0 32 + 18
0 33 + 23
1.0
end_operator
begin_operator
move robot1 zone3 zone1
1
7 0
1
0 0 3 1
3
0 31 - 29
0 32 + 18
0 33 + 26
1.0
end_operator
begin_operator
move robot1 zone3 zone2
1
15 0
1
0 0 3 2
3
0 31 - 24
0 32 + 18
0 33 + 17
1.0
end_operator
begin_operator
move robot1 zone3 zone4
1
14 0
1
0 0 3 4
3
0 31 - 26
0 32 + 18
0 33 + 24
1.0
end_operator
begin_operator
move robot1 zone4 zone1
1
8 0
1
0 0 4 1
3
0 31 - 20
0 32 + 18
0 33 + 26
1.0
end_operator
begin_operator
move robot1 zone4 zone3
1
14 0
1
0 0 4 3
3
0 31 - 26
0 32 + 18
0 33 + 24
1.0
end_operator
begin_operator
move robot1 zone5 zone2
1
15 0
1
0 0 5 2
3
0 31 - 24
0 32 + 18
0 33 + 17
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 18
0 32 + 18
0 33 + 18
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
0 31 - 18
0 32 + 18
0 33 + 18
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant1 zone3
5
0 3
1 6
5 0
9 0
13 0
0
5
0 31 - 18
0 32 + 18
0 33 + 14
0 34 - 18
0 35 + 18
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant2 zone1
5
0 1
1 6
5 0
9 0
10 0
0
5
0 31 - 18
0 32 + 18
0 33 + 14
0 34 - 18
0 36 + 18
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant3 zone1
5
0 1
1 6
5 0
9 0
11 0
0
5
0 31 - 18
0 32 + 18
0 33 + 14
0 34 - 18
0 37 + 18
1.0
end_operator
begin_operator
water-one-unit robot1 watering-can1 plant4 zone1
5
0 1
1 6
5 0
9 0
12 0
0
5
0 31 - 18
0 32 + 18
0 33 + 14
0 34 - 18
0 38 + 18
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
5 >= 19 27
6 < 25 27
7 >= 7 27
8 >= 13 27
9 >= 10 27
10 < 0 27
11 < 3 27
12 < 12 27
13 < 2 27
14 >= 1 27
15 >= 4 27
16 < 11 27
17 >= 22 27
18 >= 0 27
19 >= 2 27
20 >= 12 27
21 >= 3 27
end_comparison_axioms
17
begin_numeric_axioms
0 - 36 29
1 - 31 26
2 - 35 23
3 - 37 29
4 - 31 24
5 - 38 29
6 - 37 23
7 - 31 29
8 - 36 23
9 - 35 29
10 - 34 18
11 - 34 16
12 - 38 23
13 - 31 20
19 - 31 18
22 - 31 14
25 - 31 28
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
