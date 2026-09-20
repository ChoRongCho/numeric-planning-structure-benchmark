begin_version
4
end_version
begin_metric
< 11
end_metric
10
begin_variable
var0
-1
11
Atom at-robot(robot1, n0)
Atom at-robot(robot1, n1)
Atom at-robot(robot1, n2)
Atom at-robot(robot1, n3)
Atom at-robot(robot1, n4)
Atom at-robot(robot1, side0_0)
Atom at-robot(robot1, side0_1)
Atom at-robot(robot1, side1_0)
Atom at-robot(robot1, side1_1)
Atom at-robot(robot1, side2_0)
Atom at-robot(robot1, side2_1)
end_variable
begin_variable
var1
-1
12
Atom container-at(can1, n0)
Atom container-at(can1, n1)
Atom container-at(can1, n2)
Atom container-at(can1, n3)
Atom container-at(can1, n4)
Atom container-at(can1, side0_0)
Atom container-at(can1, side0_1)
Atom container-at(can1, side1_0)
Atom container-at(can1, side1_1)
Atom container-at(can1, side2_0)
Atom container-at(can1, side2_1)
Atom holding(robot1, can1)
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
6
2
Atom new-axiom@0()
NegatedAtom new-axiom@0()
end_variable
begin_variable
var4
6
2
Atom new-axiom@1()
NegatedAtom new-axiom@1()
end_variable
begin_variable
var5
5
3
>= 0 8
< 0 8
<none of those>
end_variable
begin_variable
var6
5
3
>= 5 8
< 5 8
<none of those>
end_variable
begin_variable
var7
5
3
>= 2 8
< 2 8
<none of those>
end_variable
begin_variable
var8
5
3
< 3 8
>= 3 8
<none of those>
end_variable
begin_variable
var9
5
3
>= 3 8
< 3 8
<none of those>
end_variable
14
begin_numeric_variables
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, n2, n3)
C -1 PNE derived!1.0()
D 3 PNE derived!difference_PNE water-level(?container)_PNE container-capacity(?container)(can1, can1)
D 4 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant1, plant1)
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, n0, n1)
C -1 PNE derived!6.0()
C -1 PNE derived!10.0()
C -1 PNE derived!0.0()
R -1 PNE battery-level(robot1)
I -1 PNE total-cost()
R -1 PNE total-watering-time()
R -1 PNE water-level(can1)
R -1 PNE watered-amount(plant1)
end_numeric_variables
3
begin_mutex_group
11
0 0
0 1
0 2
0 3
0 4
0 5
0 6
0 7
0 8
0 9
0 10
end_mutex_group
begin_mutex_group
12
1 0
1 1
1 2
1 3
1 4
1 5
1 6
1 7
1 8
1 9
1 10
1 11
end_mutex_group
begin_mutex_group
2
1 11
2 0
end_mutex_group
begin_state
0
11
1
1
1
2
2
2
2
2
end_state
begin_numeric_state
0.0
1.0
0.0
0.0
0.0
0.0
6.0
10.0
0.0
10.0
0.0
0.0
1.0
0.0
end_numeric_state
begin_goal
1
4 0
end_goal
33
begin_operator
drop-container robot1 can1 n0
2
0 0
5 0
2
0 1 11 0
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
drop-container robot1 can1 n1
2
0 1
5 0
2
0 1 11 1
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
drop-container robot1 can1 n2
2
0 2
5 0
2
0 1 11 2
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
drop-container robot1 can1 n3
2
0 3
5 0
2
0 1 11 3
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
drop-container robot1 can1 n4
2
0 4
5 0
2
0 1 11 4
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
drop-container robot1 can1 side0_0
2
0 5
5 0
2
0 1 11 5
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
drop-container robot1 can1 side0_1
2
0 6
5 0
2
0 1 11 6
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
drop-container robot1 can1 side1_0
2
0 7
5 0
2
0 1 11 7
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
drop-container robot1 can1 side1_1
2
0 8
5 0
2
0 1 11 8
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
drop-container robot1 can1 side2_0
2
0 9
5 0
2
0 1 11 9
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
drop-container robot1 can1 side2_1
2
0 10
5 0
2
0 1 11 10
0 2 -1 0
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
move robot1 n0 n1
1
6 0
1
0 0 0 1
3
0 9 - 6
0 10 + 1
0 11 + 6
1.0
end_operator
begin_operator
move robot1 n0 side0_0
1
5 0
1
0 0 0 5
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
move robot1 n0 side0_1
1
5 0
1
0 0 0 6
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
move robot1 n1 n2
1
6 0
1
0 0 1 2
3
0 9 - 6
0 10 + 1
0 11 + 6
1.0
end_operator
begin_operator
move robot1 n1 side1_0
1
5 0
1
0 0 1 7
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
move robot1 n1 side1_1
1
5 0
1
0 0 1 8
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
move robot1 n2 n3
1
5 0
1
0 0 2 3
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
move robot1 n2 side2_0
1
5 0
1
0 0 2 9
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
move robot1 n2 side2_1
1
5 0
1
0 0 2 10
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
move robot1 n3 n4
1
5 0
1
0 0 3 4
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 n0
2
0 0
5 0
2
0 1 0 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 n1
2
0 1
5 0
2
0 1 1 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 n2
2
0 2
5 0
2
0 1 2 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 n3
2
0 3
5 0
2
0 1 3 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 n4
2
0 4
5 0
2
0 1 4 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 side0_0
2
0 5
5 0
2
0 1 5 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 side0_1
2
0 6
5 0
2
0 1 6 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 side1_0
2
0 7
5 0
2
0 1 7 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 side1_1
2
0 8
5 0
2
0 1 8 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 side2_0
2
0 9
5 0
2
0 1 9 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
pick-container robot1 can1 side2_1
2
0 10
5 0
2
0 1 10 11
0 2 0 1
3
0 9 - 1
0 10 + 1
0 11 + 1
1.0
end_operator
begin_operator
water-one-unit robot1 can1 plant1 n4
5
0 4
1 11
5 0
7 0
8 0
0
5
0 9 - 1
0 10 + 1
0 11 + 1
0 12 - 1
0 13 + 1
1.0
end_operator
2
begin_rule
0
3 1 0
end_rule
begin_rule
1
9 0
4 1 0
end_rule
5
begin_comparison_axioms
5 >= 0 8
6 >= 5 8
7 >= 2 8
8 < 3 8
9 >= 3 8
end_comparison_axioms
5
begin_numeric_axioms
0 - 9 1
2 - 12 1
3 - 13 1
4 - 9 7
5 - 9 6
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
