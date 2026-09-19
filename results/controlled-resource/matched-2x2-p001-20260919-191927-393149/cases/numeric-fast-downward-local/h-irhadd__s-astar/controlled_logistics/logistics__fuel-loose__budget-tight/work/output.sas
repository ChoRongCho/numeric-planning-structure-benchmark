begin_version
4
end_version
begin_metric
< 45
end_metric
19
begin_variable
var0
-1
6
Atom at(driver1, place1)
Atom at(driver1, place2)
Atom at(driver1, place3)
Atom at(driver1, place4)
Atom at(driver1, place5)
Atom in(driver1, truck1)
end_variable
begin_variable
var1
-1
6
Atom at(pack1, place1)
Atom at(pack1, place2)
Atom at(pack1, place3)
Atom at(pack1, place4)
Atom at(pack1, place5)
Atom loaded(pack1, truck1)
end_variable
begin_variable
var2
-1
6
Atom at(pack2, place1)
Atom at(pack2, place2)
Atom at(pack2, place3)
Atom at(pack2, place4)
Atom at(pack2, place5)
Atom loaded(pack2, truck1)
end_variable
begin_variable
var3
-1
6
Atom at(pack3, place1)
Atom at(pack3, place2)
Atom at(pack3, place3)
Atom at(pack3, place4)
Atom at(pack3, place5)
Atom loaded(pack3, truck1)
end_variable
begin_variable
var4
-1
5
Atom at(truck1, place1)
Atom at(truck1, place2)
Atom at(truck1, place3)
Atom at(truck1, place4)
Atom at(truck1, place5)
end_variable
begin_variable
var5
14
2
Atom new-axiom@0()
NegatedAtom new-axiom@0()
end_variable
begin_variable
var6
13
3
<= 20 34
> 20 34
<none of those>
end_variable
begin_variable
var7
13
3
< 16 34
>= 16 34
<none of those>
end_variable
begin_variable
var8
13
3
>= 6 34
< 6 34
<none of those>
end_variable
begin_variable
var9
13
3
<= 13 34
> 13 34
<none of those>
end_variable
begin_variable
var10
13
3
<= 29 34
> 29 34
<none of those>
end_variable
begin_variable
var11
13
3
>= 10 34
< 10 34
<none of those>
end_variable
begin_variable
var12
13
3
>= 4 34
< 4 34
<none of those>
end_variable
begin_variable
var13
13
3
>= 8 34
< 8 34
<none of those>
end_variable
begin_variable
var14
13
3
<= 12 34
> 12 34
<none of those>
end_variable
begin_variable
var15
13
3
<= 0 34
> 0 34
<none of those>
end_variable
begin_variable
var16
13
3
<= 19 34
> 19 34
<none of those>
end_variable
begin_variable
var17
13
3
>= 23 34
< 23 34
<none of those>
end_variable
begin_variable
var18
13
3
>= 15 34
< 15 34
<none of those>
end_variable
47
begin_numeric_variables
D 10 PNE derived!difference_PNE derived!sum_PNE package-weight(?package)_PNE truck-load(?truck)(?package, ?truck)_PNE truck-capacity(?truck)(pack1, truck1, truck1)
C -1 PNE derived!5.0()
C -1 PNE derived!27.0()
C -1 PNE derived!100.0()
D 4 PNE derived!difference_PNE fuel-level(?truck)_PNE distance(?from, ?to)(truck1, place1, place4)
D 7 PNE derived!sum_PNE package-weight(?package)_PNE truck-load(?truck)(pack1, truck1)
D 0 PNE derived!difference_PNE budget()_PNE refuel-cost(?truck)(truck1)
D 8 PNE derived!sum_PNE package-weight(?package)_PNE truck-load(?truck)(pack2, truck1)
D 5 PNE derived!difference_PNE fuel-level(?truck)_PNE distance(?from, ?to)(truck1, place5, place4)
C -1 PNE derived!17.0()
D 2 PNE derived!difference_PNE fuel-level(?truck)_PNE distance(?from, ?to)(truck1, place2, place1)
C -1 PNE derived!36.0()
D 11 PNE derived!difference_PNE derived!sum_PNE package-weight(?package)_PNE truck-load(?truck)(?package, ?truck)_PNE truck-capacity(?truck)(pack2, truck1, truck1)
C -1 PNE derived!difference_PNE package-weight(?package)_PNE manual-capacity(?driver)(pack1, driver1)
C -1 PNE derived!20.0()
D 1 PNE derived!difference_PNE budget()_PNE toll-cost(?from, ?to)(place5, place3)
D 6 PNE derived!difference_PNE fuel-level(?truck)_PNE fuel-capacity(?truck)(truck1, truck1)
C -1 PNE derived!13.0()
C -1 PNE derived!22.0()
D 12 PNE derived!difference_PNE derived!sum_PNE package-weight(?package)_PNE truck-load(?truck)(?package, ?truck)_PNE truck-capacity(?truck)(pack3, truck1, truck1)
C -1 PNE derived!difference_PNE package-weight(?package)_PNE manual-capacity(?driver)(pack2, driver1)
C -1 PNE derived!26.0()
C -1 PNE derived!3.0()
D 3 PNE derived!difference_PNE fuel-level(?truck)_PNE distance(?from, ?to)(truck1, place5, place3)
C -1 PNE derived!2.0()
C -1 PNE derived!29.0()
C -1 PNE derived!12.0()
C -1 PNE derived!7.0()
C -1 PNE derived!63.0()
C -1 PNE derived!difference_PNE package-weight(?package)_PNE manual-capacity(?driver)(pack3, driver1)
C -1 PNE derived!19.0()
C -1 PNE derived!38.0()
C -1 PNE derived!76.0()
C -1 PNE derived!8.0()
C -1 PNE derived!0.0()
C -1 PNE derived!863.0()
C -1 PNE derived!18.0()
C -1 PNE derived!24.0()
C -1 PNE derived!101.0()
C -1 PNE derived!11.0()
C -1 PNE derived!111.0()
D 9 PNE derived!sum_PNE package-weight(?package)_PNE truck-load(?truck)(pack3, truck1)
R -1 PNE budget()
R -1 PNE fuel-level(truck1)
I -1 PNE total-cost()
R -1 PNE total-delivery-time()
R -1 PNE truck-load(truck1)
end_numeric_variables
5
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
6
2 0
2 1
2 2
2 3
2 4
2 5
end_mutex_group
begin_mutex_group
6
3 0
3 1
3 2
3 3
3 4
3 5
end_mutex_group
begin_mutex_group
5
4 0
4 1
4 2
4 3
4 4
end_mutex_group
begin_state
0
1
0
1
0
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
end_state
begin_numeric_state
0.0
5.0
27.0
100.0
0.0
0.0
0.0
0.0
0.0
17.0
0.0
36.0
0.0
1.0
20.0
0.0
0.0
13.0
22.0
0.0
-37.0
26.0
3.0
0.0
2.0
29.0
12.0
7.0
63.0
-24.0
19.0
38.0
76.0
8.0
0.0
863.0
18.0
24.0
101.0
11.0
111.0
0.0
8.0
111.0
0.0
0.0
0.0
end_numeric_state
begin_goal
3
1 0
2 1
3 3
end_goal
105
begin_operator
board-truck driver1 truck1 place1
1
4 0
1
0 0 0 5
2
0 44 + 13
0 45 + 13
1.0
end_operator
begin_operator
board-truck driver1 truck1 place2
1
4 1
1
0 0 1 5
2
0 44 + 13
0 45 + 13
1.0
end_operator
begin_operator
board-truck driver1 truck1 place3
1
4 2
1
0 0 2 5
2
0 44 + 13
0 45 + 13
1.0
end_operator
begin_operator
board-truck driver1 truck1 place4
1
4 3
1
0 0 3 5
2
0 44 + 13
0 45 + 13
1.0
end_operator
begin_operator
board-truck driver1 truck1 place5
1
4 4
1
0 0 4 5
2
0 44 + 13
0 45 + 13
1.0
end_operator
begin_operator
drive-highway driver1 truck1 place3 place5
3
0 5
17 0
18 0
1
0 4 2 4
4
0 42 - 24
0 43 - 1
0 44 + 24
0 45 + 22
2.0
end_operator
begin_operator
drive-highway driver1 truck1 place5 place3
3
0 5
17 0
18 0
1
0 4 4 2
4
0 42 - 24
0 43 - 1
0 44 + 24
0 45 + 22
2.0
end_operator
begin_operator
drive-local-road driver1 truck1 place1 place2
2
0 5
11 0
1
0 4 0 1
3
0 43 - 33
0 44 + 13
0 45 + 17
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place1 place3
2
0 5
11 0
1
0 4 0 2
3
0 43 - 33
0 44 + 13
0 45 + 26
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place1 place4
2
0 5
12 0
1
0 4 0 3
3
0 43 - 27
0 44 + 13
0 45 + 26
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place1 place5
2
0 5
13 0
1
0 4 0 4
3
0 43 - 26
0 44 + 13
0 45 + 30
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place2 place1
2
0 5
11 0
1
0 4 1 0
3
0 43 - 33
0 44 + 13
0 45 + 17
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place3 place1
2
0 5
11 0
1
0 4 2 0
3
0 43 - 33
0 44 + 13
0 45 + 26
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place3 place5
2
0 5
17 0
1
0 4 2 4
3
0 43 - 1
0 44 + 13
0 45 + 39
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place4 place1
2
0 5
12 0
1
0 4 3 0
3
0 43 - 27
0 44 + 13
0 45 + 26
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place4 place5
2
0 5
13 0
1
0 4 3 4
3
0 43 - 26
0 44 + 13
0 45 + 36
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place5 place1
2
0 5
13 0
1
0 4 4 0
3
0 43 - 26
0 44 + 13
0 45 + 30
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place5 place3
2
0 5
17 0
1
0 4 4 2
3
0 43 - 1
0 44 + 13
0 45 + 39
1.0
end_operator
begin_operator
drive-local-road driver1 truck1 place5 place4
2
0 5
13 0
1
0 4 4 3
3
0 43 - 26
0 44 + 13
0 45 + 36
1.0
end_operator
begin_operator
get-out driver1 truck1 place1
1
4 0
1
0 0 5 0
2
0 44 + 13
0 45 + 13
1.0
end_operator
begin_operator
get-out driver1 truck1 place2
1
4 1
1
0 0 5 1
2
0 44 + 13
0 45 + 13
1.0
end_operator
begin_operator
get-out driver1 truck1 place3
1
4 2
1
0 0 5 2
2
0 44 + 13
0 45 + 13
1.0
end_operator
begin_operator
get-out driver1 truck1 place4
1
4 3
1
0 0 5 3
2
0 44 + 13
0 45 + 13
1.0
end_operator
begin_operator
get-out driver1 truck1 place5
1
4 4
1
0 0 5 4
2
0 44 + 13
0 45 + 13
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 place1
3
0 0
4 0
15 0
1
0 1 0 5
3
0 44 + 13
0 45 + 13
0 46 + 38
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 place2
3
0 1
4 1
15 0
1
0 1 1 5
3
0 44 + 13
0 45 + 13
0 46 + 38
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 place3
3
0 2
4 2
15 0
1
0 1 2 5
3
0 44 + 13
0 45 + 13
0 46 + 38
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 place4
3
0 3
4 3
15 0
1
0 1 3 5
3
0 44 + 13
0 45 + 13
0 46 + 38
1.0
end_operator
begin_operator
load-truck driver1 pack1 truck1 place5
3
0 4
4 4
15 0
1
0 1 4 5
3
0 44 + 13
0 45 + 13
0 46 + 38
1.0
end_operator
begin_operator
load-truck driver1 pack2 truck1 place1
3
0 0
4 0
14 0
1
0 2 0 5
3
0 44 + 13
0 45 + 13
0 46 + 28
1.0
end_operator
begin_operator
load-truck driver1 pack2 truck1 place2
3
0 1
4 1
14 0
1
0 2 1 5
3
0 44 + 13
0 45 + 13
0 46 + 28
1.0
end_operator
begin_operator
load-truck driver1 pack2 truck1 place3
3
0 2
4 2
14 0
1
0 2 2 5
3
0 44 + 13
0 45 + 13
0 46 + 28
1.0
end_operator
begin_operator
load-truck driver1 pack2 truck1 place4
3
0 3
4 3
14 0
1
0 2 3 5
3
0 44 + 13
0 45 + 13
0 46 + 28
1.0
end_operator
begin_operator
load-truck driver1 pack2 truck1 place5
3
0 4
4 4
14 0
1
0 2 4 5
3
0 44 + 13
0 45 + 13
0 46 + 28
1.0
end_operator
begin_operator
load-truck driver1 pack3 truck1 place1
3
0 0
4 0
16 0
1
0 3 0 5
3
0 44 + 13
0 45 + 13
0 46 + 32
1.0
end_operator
begin_operator
load-truck driver1 pack3 truck1 place2
3
0 1
4 1
16 0
1
0 3 1 5
3
0 44 + 13
0 45 + 13
0 46 + 32
1.0
end_operator
begin_operator
load-truck driver1 pack3 truck1 place3
3
0 2
4 2
16 0
1
0 3 2 5
3
0 44 + 13
0 45 + 13
0 46 + 32
1.0
end_operator
begin_operator
load-truck driver1 pack3 truck1 place4
3
0 3
4 3
16 0
1
0 3 3 5
3
0 44 + 13
0 45 + 13
0 46 + 32
1.0
end_operator
begin_operator
load-truck driver1 pack3 truck1 place5
3
0 4
4 4
16 0
1
0 3 4 5
3
0 44 + 13
0 45 + 13
0 46 + 32
1.0
end_operator
begin_operator
refuel-truck driver1 truck1 place1
4
0 5
4 0
7 0
8 0
0
4
0 42 - 27
0 43 = 40
0 44 + 27
0 45 + 22
7.0
end_operator
begin_operator
refuel-truck driver1 truck1 place3
4
0 5
4 2
7 0
8 0
0
4
0 42 - 27
0 43 = 40
0 44 + 27
0 45 + 22
7.0
end_operator
begin_operator
refuel-truck driver1 truck1 place4
4
0 5
4 3
7 0
8 0
0
4
0 42 - 27
0 43 = 40
0 44 + 27
0 45 + 22
7.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 place1
2
0 0
4 0
1
0 1 5 0
3
0 44 + 13
0 45 + 13
0 46 - 38
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 place2
2
0 1
4 1
1
0 1 5 1
3
0 44 + 13
0 45 + 13
0 46 - 38
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 place3
2
0 2
4 2
1
0 1 5 2
3
0 44 + 13
0 45 + 13
0 46 - 38
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 place4
2
0 3
4 3
1
0 1 5 3
3
0 44 + 13
0 45 + 13
0 46 - 38
1.0
end_operator
begin_operator
unload-truck driver1 pack1 truck1 place5
2
0 4
4 4
1
0 1 5 4
3
0 44 + 13
0 45 + 13
0 46 - 38
1.0
end_operator
begin_operator
unload-truck driver1 pack2 truck1 place1
2
0 0
4 0
1
0 2 5 0
3
0 44 + 13
0 45 + 13
0 46 - 28
1.0
end_operator
begin_operator
unload-truck driver1 pack2 truck1 place2
2
0 1
4 1
1
0 2 5 1
3
0 44 + 13
0 45 + 13
0 46 - 28
1.0
end_operator
begin_operator
unload-truck driver1 pack2 truck1 place3
2
0 2
4 2
1
0 2 5 2
3
0 44 + 13
0 45 + 13
0 46 - 28
1.0
end_operator
begin_operator
unload-truck driver1 pack2 truck1 place4
2
0 3
4 3
1
0 2 5 3
3
0 44 + 13
0 45 + 13
0 46 - 28
1.0
end_operator
begin_operator
unload-truck driver1 pack2 truck1 place5
2
0 4
4 4
1
0 2 5 4
3
0 44 + 13
0 45 + 13
0 46 - 28
1.0
end_operator
begin_operator
unload-truck driver1 pack3 truck1 place1
2
0 0
4 0
1
0 3 5 0
3
0 44 + 13
0 45 + 13
0 46 - 32
1.0
end_operator
begin_operator
unload-truck driver1 pack3 truck1 place2
2
0 1
4 1
1
0 3 5 1
3
0 44 + 13
0 45 + 13
0 46 - 32
1.0
end_operator
begin_operator
unload-truck driver1 pack3 truck1 place3
2
0 2
4 2
1
0 3 5 2
3
0 44 + 13
0 45 + 13
0 46 - 32
1.0
end_operator
begin_operator
unload-truck driver1 pack3 truck1 place4
2
0 3
4 3
1
0 3 5 3
3
0 44 + 13
0 45 + 13
0 46 - 32
1.0
end_operator
begin_operator
unload-truck driver1 pack3 truck1 place5
2
0 4
4 4
1
0 3 5 4
3
0 44 + 13
0 45 + 13
0 46 - 32
1.0
end_operator
begin_operator
walk-alone driver1 place1 place2
0
1
0 0 0 1
2
0 44 + 13
0 45 + 14
1.0
end_operator
begin_operator
walk-alone driver1 place1 place3
0
1
0 0 0 2
2
0 44 + 13
0 45 + 36
1.0
end_operator
begin_operator
walk-alone driver1 place1 place4
0
1
0 0 0 3
2
0 44 + 13
0 45 + 36
1.0
end_operator
begin_operator
walk-alone driver1 place1 place5
0
1
0 0 0 4
2
0 44 + 13
0 45 + 25
1.0
end_operator
begin_operator
walk-alone driver1 place2 place1
0
1
0 0 1 0
2
0 44 + 13
0 45 + 14
1.0
end_operator
begin_operator
walk-alone driver1 place3 place1
0
1
0 0 2 0
2
0 44 + 13
0 45 + 36
1.0
end_operator
begin_operator
walk-alone driver1 place3 place5
0
1
0 0 2 4
2
0 44 + 13
0 45 + 9
1.0
end_operator
begin_operator
walk-alone driver1 place4 place1
0
1
0 0 3 0
2
0 44 + 13
0 45 + 36
1.0
end_operator
begin_operator
walk-alone driver1 place4 place5
0
1
0 0 3 4
2
0 44 + 13
0 45 + 2
1.0
end_operator
begin_operator
walk-alone driver1 place5 place1
0
1
0 0 4 0
2
0 44 + 13
0 45 + 25
1.0
end_operator
begin_operator
walk-alone driver1 place5 place3
0
1
0 0 4 2
2
0 44 + 13
0 45 + 9
1.0
end_operator
begin_operator
walk-alone driver1 place5 place4
0
1
0 0 4 3
2
0 44 + 13
0 45 + 2
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place1 place2
1
9 0
2
0 0 0 1
0 1 0 1
2
0 44 + 13
0 45 + 21
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place1 place3
1
9 0
2
0 0 0 2
0 1 0 2
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place1 place4
1
9 0
2
0 0 0 3
0 1 0 3
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place1 place5
1
9 0
2
0 0 0 4
0 1 0 4
2
0 44 + 13
0 45 + 31
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place2 place1
1
9 0
2
0 0 1 0
0 1 1 0
2
0 44 + 13
0 45 + 21
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place3 place1
1
9 0
2
0 0 2 0
0 1 2 0
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place3 place5
1
9 0
2
0 0 2 4
0 1 2 4
2
0 44 + 13
0 45 + 18
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place4 place1
1
9 0
2
0 0 3 0
0 1 3 0
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place4 place5
1
9 0
2
0 0 3 4
0 1 3 4
2
0 44 + 13
0 45 + 11
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place5 place1
1
9 0
2
0 0 4 0
0 1 4 0
2
0 44 + 13
0 45 + 31
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place5 place3
1
9 0
2
0 0 4 2
0 1 4 2
2
0 44 + 13
0 45 + 18
1.0
end_operator
begin_operator
walk-with-package driver1 pack1 place5 place4
1
9 0
2
0 0 4 3
0 1 4 3
2
0 44 + 13
0 45 + 11
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place1 place2
1
6 0
2
0 0 0 1
0 2 0 1
2
0 44 + 13
0 45 + 21
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place1 place3
1
6 0
2
0 0 0 2
0 2 0 2
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place1 place4
1
6 0
2
0 0 0 3
0 2 0 3
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place1 place5
1
6 0
2
0 0 0 4
0 2 0 4
2
0 44 + 13
0 45 + 31
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place2 place1
1
6 0
2
0 0 1 0
0 2 1 0
2
0 44 + 13
0 45 + 21
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place3 place1
1
6 0
2
0 0 2 0
0 2 2 0
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place3 place5
1
6 0
2
0 0 2 4
0 2 2 4
2
0 44 + 13
0 45 + 18
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place4 place1
1
6 0
2
0 0 3 0
0 2 3 0
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place4 place5
1
6 0
2
0 0 3 4
0 2 3 4
2
0 44 + 13
0 45 + 11
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place5 place1
1
6 0
2
0 0 4 0
0 2 4 0
2
0 44 + 13
0 45 + 31
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place5 place3
1
6 0
2
0 0 4 2
0 2 4 2
2
0 44 + 13
0 45 + 18
1.0
end_operator
begin_operator
walk-with-package driver1 pack2 place5 place4
1
6 0
2
0 0 4 3
0 2 4 3
2
0 44 + 13
0 45 + 11
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place1 place2
1
10 0
2
0 0 0 1
0 3 0 1
2
0 44 + 13
0 45 + 21
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place1 place3
1
10 0
2
0 0 0 2
0 3 0 2
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place1 place4
1
10 0
2
0 0 0 3
0 3 0 3
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place1 place5
1
10 0
2
0 0 0 4
0 3 0 4
2
0 44 + 13
0 45 + 31
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place2 place1
1
10 0
2
0 0 1 0
0 3 1 0
2
0 44 + 13
0 45 + 21
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place3 place1
1
10 0
2
0 0 2 0
0 3 2 0
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place3 place5
1
10 0
2
0 0 2 4
0 3 2 4
2
0 44 + 13
0 45 + 18
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place4 place1
1
10 0
2
0 0 3 0
0 3 3 0
2
0 44 + 13
0 45 + 37
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place4 place5
1
10 0
2
0 0 3 4
0 3 3 4
2
0 44 + 13
0 45 + 11
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place5 place1
1
10 0
2
0 0 4 0
0 3 4 0
2
0 44 + 13
0 45 + 31
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place5 place3
1
10 0
2
0 0 4 2
0 3 4 2
2
0 44 + 13
0 45 + 18
1.0
end_operator
begin_operator
walk-with-package driver1 pack3 place5 place4
1
10 0
2
0 0 4 3
0 3 4 3
2
0 44 + 13
0 45 + 11
1.0
end_operator
1
begin_rule
0
5 1 0
end_rule
13
begin_comparison_axioms
6 <= 20 34
7 < 16 34
8 >= 6 34
9 <= 13 34
10 <= 29 34
11 >= 10 34
12 >= 4 34
13 >= 8 34
14 <= 12 34
15 <= 0 34
16 <= 19 34
17 >= 23 34
18 >= 15 34
end_comparison_axioms
13
begin_numeric_axioms
0 - 5 35
4 - 43 27
5 + 38 46
6 - 42 27
7 + 28 46
8 - 43 26
10 - 43 33
12 - 7 35
15 - 42 24
16 - 43 40
19 - 41 35
23 - 43 1
41 + 32 46
end_numeric_axioms
begin_global_constraint
5 0
end_global_constraint
