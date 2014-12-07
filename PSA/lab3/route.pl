route(X,Y,[drive(X,Y)]) :-
    road(X,Y).
route(X,Y,[drive(X,Z)|R]) :-
    road(X,Z), route(Z,Y,R).

road(arad,sibiu,140).
road(arad,timisoara,118).
road(arad,zerind,75).
road(zerind,oradea,71).
road(oradea,sibiu,151).
road(sibiu,fagaras,99).
road(sibiu,rimnicu_vilcea,80).
road(fagaras,bucharest,211).
road(timisoara,lugoj,111).
road(lugoj,mehadia,70).
road(mehadia,dobreta,75).
road(dobreta,craiova,120).
road(rimnicu_vilcea,pitesti,97).
road(rimnicu_vilcea,craiova,146).
road(craiova,pitesti,138).
road(pitesti,bucharest,101).
road(bucharest,urziceni,85).
road(bucharest,giurgiu,90).
road(urziceni,vaslui,142).
road(urziceni,hirsova,98).
road(vaslui,iasi,92).
road(iasi,neamt,87).
road(hirsova,eforie,86).


route_cost(X,Y,[drive(X,Y)],Z) :-
    road(X,Y,Z).

route_cost(X,Y,[drive(X,Z)|R],V) :-
    road(X,Z,A),
    route_cost(Z,Y,R,B),
    V is A+B.
