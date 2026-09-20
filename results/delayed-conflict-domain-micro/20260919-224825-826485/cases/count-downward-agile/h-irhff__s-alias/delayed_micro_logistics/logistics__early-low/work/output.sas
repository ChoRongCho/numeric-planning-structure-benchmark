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
6
Atom at(driver1, n0)
Atom at(driver1, n1)
Atom at(driver1, n2)
Atom at(driver1, n3)
Atom at(driver1, n4)
Atom in(driver1, truck1)
end_variable
begin_variable
var1
-1
6
Atom at(pack1, n0)
Atom at(pack1, n1)
Atom at(pack1, n2)
Atom at(pack1, n3)
Atom at(pack1, n4)
Atom loaded(pack1, truck1)
end_variable
begin_variable
var2
-1
5
Atom at(truck1, n0)
Atom at(truck1, n1)
Atom at(truck1, n2)
Atom at(truck1, n3)
Atom at(truck1, n4)
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
>= 7 0
< 7 0
<none of those>
end_variable
begin_variable
var5
5
3
<= 6 0
> 6 0
<none of those>
end_variable
begin_variable
var6
5
3
>= 8 0
< 8 0
<none of those>
end_variable
15
begin_numeric_variables
C -1 PNE derived!0.0()
C -1 PNE derived!difference_PNE package-weight(?package)_PNE manual-capacity(?driver)(pack1, driver1)
C -1 PNE derived!10.0()
C -1 PNE derived!100.0()
C -1 PNE derived!6.0()
C -1 PNE derived!difference_PNE budget()_PNE refuel-cost(?truck)(truck1)
D 4 PNE derived!difference_PNE derived!sum_PNE package-weight(?package)_PNE truck-load(?truck)(?package, ?truck)_PNE truck-capacity(?truck)(pack1, truck1, truck1)
D 0 PNE derived!difference_PNE fuel-level(?truck)_PNE distance(?from, ?to)(truck1, n1, n2)
D 1 PNE derived!difference_PNE fuel-level(?truck)_PNE distance(?from, ?to)(truck1, n3, n4)
D 2 PNE derived!difference_PNE fuel-level(?truck)_PNE fuel-capacity(?truck)(truck1, truck1)
D 3 PNE derived!sum_PNE package-weight(?package)_PNE truck-load(?truck)(pack1, truck1)
R -1 PNE fuel-level(truck1)
I -1 PNE total-cost()
R -1 PNE total-delivery-time()
R -1 PNE truck-load(truck1)
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
6
1 0
1 1
1 2
1 3
1 4
1 5
end_mutex_group
begin_mutex_group
5
2 0
2 1
2 2
2 3
2 4
end_mutex_group
begin_state
5
5
0
1
2
2
2
end_state
begin_numeric_state
0.0
1.0
10.0
100.0
6.0
-100.0
0.0
0.0
0.0
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
24
begin_operator
board-truck driver1 truck1 n0
1
2 0
1
0 0 0 5
2
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
board-truck driver1 truck1 n1
1
2 1
1
0 0 1 5
2
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
board-truck driver1 truck1 n2
1
2 2
1
0 0 2 5
2
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
board-truck driver1 truck1 n3
1
2 3
1
0 0 3 5
2
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
board-truck driver1 truck1 n4
1
2 4
1
0 0 4 5
2
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n0 n1
2
0 5
4 0
1
0 2 0 1
3
0 11 - 4
0 12 + 1
0 13 + 4
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n1 n2
2
0 5
4 0
1
0 2 1 2
3
0 11 - 4
0 12 + 1
0 13 + 4
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n2 n3
2
0 5
6 0
1
0 2 2 3
3
0 11 - 1
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 n3 n4
2
0 5
6 0
1
0 2 3 4
3
0 11 - 1
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
get-out driver1 truck1 n0
1
2 0
1
0 0 5 0
2
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
get-out driver1 truck1 n1
1
2 1
1
0 0 5 1
2
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
get-out driver1 truck1 n2
1
2 2
1
0 0 5 2
2
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
get-out driver1 truck1 n3
1
2 3
1
0 0 5 3
2
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
get-out driver1 truck1 n4
1
2 4
1
0 0 5 4
2
0 12 + 1
0 13 + 1
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 n0
3
0 0
2 0
5 0
1
0 1 0 5
3
0 12 + 1
0 13 + 1
0 14 + 1
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 n1
3
0 1
2 1
5 0
1
0 1 1 5
3
0 12 + 1
0 13 + 1
0 14 + 1
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 n2
3
0 2
2 2
5 0
1
0 1 2 5
3
0 12 + 1
0 13 + 1
0 14 + 1
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 n3
3
0 3
2 3
5 0
1
0 1 3 5
3
0 12 + 1
0 13 + 1
0 14 + 1
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 n4
3
0 4
2 4
5 0
1
0 1 4 5
3
0 12 + 1
0 13 + 1
0 14 + 1
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 n0
2
0 0
2 0
1
0 1 5 0
3
0 12 + 1
0 13 + 1
0 14 - 1
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 n1
2
0 1
2 1
1
0 1 5 1
3
0 12 + 1
0 13 + 1
0 14 - 1
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 n2
2
0 2
2 2
1
0 1 5 2
3
0 12 + 1
0 13 + 1
0 14 - 1
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 n3
2
0 3
2 3
1
0 1 5 3
3
0 12 + 1
0 13 + 1
0 14 - 1
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 n4
2
0 4
2 4
1
0 1 5 4
3
0 12 + 1
0 13 + 1
0 14 - 1
1.0
end_operator
1
begin_rule
0
3 1 0
end_rule
3
begin_comparison_axioms
4 >= 7 0
5 <= 6 0
6 >= 8 0
end_comparison_axioms
5
begin_numeric_axioms
6 - 10 2
7 - 11 4
8 - 11 1
9 - 11 2
10 + 1 14
end_numeric_axioms
begin_global_constraint
3 0
end_global_constraint
