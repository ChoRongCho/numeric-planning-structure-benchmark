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
5
Atom at-robot(robot1, n0)
Atom at-robot(robot1, n1)
Atom at-robot(robot1, n2)
Atom at-robot(robot1, n3)
Atom at-robot(robot1, n4)
end_variable
begin_variable
var1
-1
6
Atom container-at(can1, n0)
Atom container-at(can1, n1)
Atom container-at(can1, n2)
Atom container-at(can1, n3)
Atom container-at(can1, n4)
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
>= 5 0
< 5 0
<none of those>
end_variable
begin_variable
var6
5
3
>= 6 0
< 6 0
<none of those>
end_variable
begin_variable
var7
5
3
>= 7 0
< 7 0
<none of those>
end_variable
begin_variable
var8
5
3
< 8 0
>= 8 0
<none of those>
end_variable
begin_variable
var9
5
3
>= 8 0
< 8 0
<none of those>
end_variable
14
begin_numeric_variables
C -1 PNE derived!0.0()
C -1 PNE derived!1.0()
C -1 PNE derived!10.0()
C -1 PNE derived!6.0()
D 0 PNE derived!difference_PNE battery-level(?robot)_PNE battery-capacity(?robot)(robot1, robot1)
D 1 PNE derived!difference_PNE battery-level(?robot)_PNE watering-unit-energy()(robot1)
D 2 PNE derived!difference_PNE battery-level(?robot)_PNE move-energy(?from, ?to)(robot1, n1, n2)
D 3 PNE derived!difference_PNE water-level(?container)_PNE derived!1.0()(can1)
D 4 PNE derived!difference_PNE watered-amount(plant1)_PNE plant-demand(plant1)(plant1, plant1)
R -1 PNE battery-level(robot1)
I -1 PNE total-cost()
R -1 PNE total-watering-time()
R -1 PNE water-level(can1)
R -1 PNE watered-amount(plant1)
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
5
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
10.0
6.0
0.0
0.0
0.0
0.0
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
15
begin_operator
drop-container robot1 can1 n0
2
0 0
5 0
2
0 1 5 0
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
0 1 5 1
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
0 1 5 2
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
0 1 5 3
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
0 1 5 4
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
0 9 - 3
0 10 + 1
0 11 + 3
1.0
end_operator
begin_operator
move robot1 n1 n2
1
6 0
1
0 0 1 2
3
0 9 - 3
0 10 + 1
0 11 + 3
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
0 1 0 5
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
0 1 1 5
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
0 1 2 5
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
0 1 3 5
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
0 1 4 5
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
1 5
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
5 >= 5 0
6 >= 6 0
7 >= 7 0
8 < 8 0
9 >= 8 0
end_comparison_axioms
5
begin_numeric_axioms
4 - 9 2
5 - 9 1
6 - 9 3
7 - 12 1
8 - 13 1
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
