:- use_module([library(lists),library(sets)]). 
% gsp(+State,+Goals,-Plan): Plan is a sequence of
% operators that applied in State achieves Goals
gsp(S,G,P) :- gsp_pg(S,G,[],P,_). 
% gsp(+State,+Goals,+AGoals,-Plan,-NewState)
gsp_pg(S,Gs,_,[],S) :- holds(Gs,S).
gsp_pg(S,Gs,AGs,P,S3) :-
 select_goal(S,Gs,G),
 pop(O,Pre,A,D),
 member(G,A),
 \+ intersection(D,AGs,_),
 \+ intersection(Pre,AGs,_),
 gsp_pg(S,Pre,[G|AGs],P1,S1),
 apply(S1,A,D,S2),
 gsp_pg(S2,Gs,[G|AGs],P2,S3),
 append(P1,[O|P2],P). 

% select_goal(+State, +Goals, -Goal): Goal is a
% goal in Goals that is not achieved in State
select_goal(S,Gs,G) :-
 member(G,Gs),
 \+ member(G,S).
 
 
 
 
 % Move a block from on top of a block to on top
% of another block
pop(move(X,Y),
 [clear(X),clear(Y),on(X,Z)],
 [on(X,Y),clear(Z)],
 [clear(Y),on(X,Z)]) :-
 cube(X),
 cube(Y),
 cube(Z),
 X \= Y,
 X \= Z,
 Y \= Z. 
 
 % Move a block from the table to on top of
% another block
pop(move(X,Y),
 [clear(X),clear(Y),on(X,table)],
 [on(X,Y)],
 [clear(Y),on(X,table)]) :-
 cube(X),
 cube(Y),
 X \= Y. 
 
 
 % Move a block from on top of a block onto the table
pop(move_to_table(X),
 [clear(X),on(X,Y)],
 [on(X,table),clear(Y)],
 [on(X,Y)]) :-
 cube(X),
 cube(Y),
 X \= Y.
% Unit clauses specifying blocks
cube(a).
cube(b).
cube(c). 


% holds(+Goals,+State): the goals (or preconditions) Goals hold in State
holds([],_).
holds([Pre|Ps],S) :-
 select(Pre,S,S1), %S with Pre removed results in S1
 holds(Ps,S1).
% apply(+State,+AddList,+DeleteList,-NewState): NewState is the result of applying the operator with add and delete lists AddList and DeleteList in State
apply(S,A,D,S1) :-
 union(S,A,S2), %S2 union of S and A
 subtract(S2,D,S1). %delete all elements from D in S2 