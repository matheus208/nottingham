%route(+X, ?Y, ?R) : R is a route from X to Y
route(X,Y,R) :- route(X,Y,[X], R).

route(X,Y,_,[drive(X,Y)]) :-
	travel(X,Y).

route(X,Y,V,[drive(X,Z)|R]) :-
    travel(X,Z), 
	\+ member(Z,V),
	route(Z,Y,[Z|V],R),
	Z \= Y.
	
	

route_distance(X,Y,_,[drive(X,Y)],C) :-
	travel(X,Y),
	distance(X,Y,C).

route_distance(X,Y,V,[drive(X,Z)|R],C) :-
    travel(X,Z), 
	route_distance(Z,Y,[Z|V],R,D),
	distance(X,Y,A),
	D is C + A,
	\+ member(Z,V),
	Z \= Y.




	
road(arad,sibiu).
distance(arad,sibiu,140).

road(arad,timisoara).
distance(arad,timisoara,118).

road(arad,zerind).
distance(arad,zerind,75).

road(zerind,oradea).
distance(zerind,oradea,71).

road(oradea,sibiu).
distance(oradea,sibiu,151).

road(sibiu,fagaras).
distance(sibiu,fagaras,99).

road(sibiu,rimnicu_vilcea).
distance(sibiu,rimnicu_vilcea,80).

road(fagaras,bucharest).
distance(fagaras,bucharest,211).

road(timisoara,lugoj).
distance(timisoara,lugoj,111).

road(lugoj,mehadia).
distance(lugoj,mehadia,70).

road(mehadia,dobreta).
distance(mehadia,dobreta,75).

road(dobreta,craiova).
distance(dobreta,craiova,120).

road(rimnicu_vilcea,pitesti).
distance(rimnicu_vilcea,pitesti,97).

road(rimnicu_vilcea,craiova).
distance(rimnicu_vilcea,craiova,146).

road(craiova,pitesti).
distance(craiova,pitesti,138).

road(pitesti,bucharest).
distance(pitesti,bucharest,101).

road(bucharest,urziceni).
distance(bucharest,urziceni,85).

road(bucharest,giurgiu).
distance(bucharest,giurgiu,90).

road(urziceni,vaslui).
distance(urziceni,vaslui,142).

road(urziceni,hirsova).
distance(urziceni,hirsova,98).

road(vaslui,iasi).
distance(vaslui,iasi,142).

road(iasi,neamt).
distance(iasi,neamt,92).

road(hirsova,eforie).
distance(hirsova,eforie,86).

distance(X,Y,D) :- distance(Y,X,D).

travel(X,Y) :- road(X,Y).
travel(X,Y) :- road(Y,X).