begin_version
4
end_version
begin_metric
< 13
end_metric
7
begin_variable
var0
-1
12
Atom at(driver1, n0)
Atom at(driver1, n1)
Atom at(driver1, n2)
Atom at(driver1, n3)
Atom at(driver1, n4)
Atom at(driver1, side0_0)
Atom at(driver1, side0_1)
Atom at(driver1, side1_0)
Atom at(driver1, side1_1)
Atom at(driver1, side2_0)
Atom at(driver1, side2_1)
Atom in(driver1, truck1)
end_variable
begin_variable
var1
-1
12
Atom at(pack1, n0)
Atom at(pack1, n1)
Atom at(pack1, n2)
Atom at(pack1, n3)
Atom at(pack1, n4)
Atom at(pack1, side0_0)
Atom at(pack1, side0_1)
Atom at(pack1, side1_0)
Atom at(pack1, side1_1)
Atom at(pack1, side2_0)
Atom at(pack1, side2_1)
Atom loaded(pack1, truck1)
end_variable
begin_variable
var2
-1
11
Atom at(truck1, n0)
Atom at(truck1, n1)
Atom at(truck1, n2)
Atom at(truck1, n3)
Atom at(truck1, n4)
Atom at(truck1, side0_0)
Atom at(truck1, side0_1)
Atom at(truck1, side1_0)
Atom at(truck1, side1_1)
Atom at(truck1, side2_0)
Atom at(truck1, side2_1)
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
5
3
>= 1 9
< 1 9
<none of those>
end_variable
begin_variable
var5
5
3
<= 10 9
> 10 9
<none of those>
end_variable
begin_variable
var6
5
3
>= 3 9
< 3 9
<none of those>
end_variable
15
begin_numeric_variables
D 2 PNE derived!difference_PNE fuel-level(?truck)_PNE fuel-capacity(?truck)(truck1, truck1)
D 0 PNE derived!difference_PNE fuel-level(?truck)_PNE distance(?from, ?to)(truck1, n2, side2_1)
C -1 PNE derived!difference_PNE package-weight(?package)_PNE manual-capacity(?driver)(pack1, driver1)
D 1 PNE derived!difference_PNE fuel-level(?truck)_PNE distance(?from, ?to)(truck1, n3, n4)
D 3 PNE derived!sum_PNE truck-load(?truck)_PNE package-weight(?package)(truck1, pack1)
C -1 PNE derived!100.0()
C -1 PNE derived!6.0()
C -1 PNE derived!difference_PNE budget()_PNE refuel-cost(?truck)(truck1)
C -1 PNE derived!10.0()
C -1 PNE derived!0.0()
D 4 PNE derived!difference_PNE derived!sum_PNE truck-load(?truck)_PNE package-weight(?package)(?truck, ?package)_PNE truck-capacity(?truck)(truck1, pack1, truck1)
R -1 PNE fuel-level(truck1)
I -1 PNE total-cost()
R -1 PNE total-delivery-time()
R -1 PNE truck-load(truck1)
end_numeric_variables
3
begin_mutex_group
12
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
0 11
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
11
2 0
2 1
2 2
2 3
2 4
2 5
2 6
2 7
2 8
2 9
2 10
end_mutex_group
begin_state
11
11
0
1
2
2
2
end_state
begin_numeric_state
0.0
0.0
1.0
0.0
0.0
100.0
6.0
-100.0
10.0
0.0
0.0
10.0
0.0
0.0
1.0
end_numeric_state
begin_goal
1
1 4
end_goal
54
begin_operator
board-truck driver1 truck1 n0
1
2 0
1
0 0 0 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
board-truck driver1 truck1 n1
1
2 1
1
0 0 1 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
board-truck driver1 truck1 n2
1
2 2
1
0 0 2 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
board-truck driver1 truck1 n3
1
2 3
1
0 0 3 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
board-truck driver1 truck1 n4
1
2 4
1
0 0 4 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
board-truck driver1 truck1 side0_0
1
2 5
1
0 0 5 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
board-truck driver1 truck1 side0_1
1
2 6
1
0 0 6 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
board-truck driver1 truck1 side1_0
1
2 7
1
0 0 7 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
board-truck driver1 truck1 side1_1
1
2 8
1
0 0 8 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
board-truck driver1 truck1 side2_0
1
2 9
1
0 0 9 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
board-truck driver1 truck1 side2_1
1
2 10
1
0 0 10 11
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n0 n1
2
0 11
4 0
1
0 2 0 1
3
0 11 - 2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n0 side0_0
2
0 11
4 0
1
0 2 0 5
3
0 11 - 2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n0 side0_1
2
0 11
4 0
1
0 2 0 6
3
0 11 - 2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n1 n2
2
0 11
4 0
1
0 2 1 2
3
0 11 - 2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n1 side1_0
2
0 11
4 0
1
0 2 1 7
3
0 11 - 2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n1 side1_1
2
0 11
4 0
1
0 2 1 8
3
0 11 - 2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n2 n3
2
0 11
6 0
1
0 2 2 3
3
0 11 - 6
0 12 + 2
0 13 + 6
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n2 side2_0
2
0 11
4 0
1
0 2 2 9
3
0 11 - 2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n2 side2_1
2
0 11
4 0
1
0 2 2 10
3
0 11 - 2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n3 n4
2
0 11
6 0
1
0 2 3 4
3
0 11 - 6
0 12 + 2
0 13 + 6
1.0
end_operator
begin_operator
get-out driver1 truck1 n0
1
2 0
1
0 0 11 0
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
get-out driver1 truck1 n1
1
2 1
1
0 0 11 1
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
get-out driver1 truck1 n2
1
2 2
1
0 0 11 2
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
get-out driver1 truck1 n3
1
2 3
1
0 0 11 3
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
get-out driver1 truck1 n4
1
2 4
1
0 0 11 4
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
get-out driver1 truck1 side0_0
1
2 5
1
0 0 11 5
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
get-out driver1 truck1 side0_1
1
2 6
1
0 0 11 6
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
get-out driver1 truck1 side1_0
1
2 7
1
0 0 11 7
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
get-out driver1 truck1 side1_1
1
2 8
1
0 0 11 8
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
get-out driver1 truck1 side2_0
1
2 9
1
0 0 11 9
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
get-out driver1 truck1 side2_1
1
2 10
1
0 0 11 10
2
0 12 + 2
0 13 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 n0
3
0 0
2 0
5 0
1
0 1 0 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 n1
3
0 1
2 1
5 0
1
0 1 1 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 n2
3
0 2
2 2
5 0
1
0 1 2 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 n3
3
0 3
2 3
5 0
1
0 1 3 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 n4
3
0 4
2 4
5 0
1
0 1 4 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 side0_0
3
0 5
2 5
5 0
1
0 1 5 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 side0_1
3
0 6
2 6
5 0
1
0 1 6 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 side1_0
3
0 7
2 7
5 0
1
0 1 7 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 side1_1
3
0 8
2 8
5 0
1
0 1 8 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 side2_0
3
0 9
2 9
5 0
1
0 1 9 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 side2_1
3
0 10
2 10
5 0
1
0 1 10 11
3
0 12 + 2
0 13 + 2
0 14 + 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 n0
2
0 0
2 0
1
0 1 11 0
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 n1
2
0 1
2 1
1
0 1 11 1
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 n2
2
0 2
2 2
1
0 1 11 2
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 n3
2
0 3
2 3
1
0 1 11 3
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 n4
2
0 4
2 4
1
0 1 11 4
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 side0_0
2
0 5
2 5
1
0 1 11 5
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 side0_1
2
0 6
2 6
1
0 1 11 6
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 side1_0
2
0 7
2 7
1
0 1 11 7
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 side1_1
2
0 8
2 8
1
0 1 11 8
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 side2_0
2
0 9
2 9
1
0 1 11 9
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 side2_1
2
0 10
2 10
1
0 1 11 10
3
0 12 + 2
0 13 + 2
0 14 - 2
1.0
end_operator
1
begin_rule
0
3 1 0
end_rule
3
begin_comparison_axioms
4 >= 1 9
5 <= 10 9
6 >= 3 9
end_comparison_axioms
5
begin_numeric_axioms
0 - 11 8
1 - 11 2
3 - 11 6
4 + 14 2
10 - 4 8
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
