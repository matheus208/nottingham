:- use_module(library(lists)).
%Forward Planner
%The good thing about forward planner is that if it finds a plan, it is guaranteed to satisfy all goals
%However, it may not finish (due to depth first search infinite branch)
%And it may contain redundant steps


% fp(+State,+Goals,-Plan): Plan is a sequence of operators that applied in State achieves Goals
fp(S,G,P) :- fp(S,G,[],R), reverse(R,P).

fp(S,G,P,P) :- satisfied(G,S).
fp(S,G,Os,P) :-
    pop(O,Pre,A,D),		%Find an operator O ...
    satisfied(Pre,S),	%Whose pre-conditions satisfy the current state
    \+ member(O,Os),	%And that we haven't used yet.
	
    subtract(S,D,R),	%So we remove its delete list from the current state
    union(A,R,S1),		%And add its add list to the state
    fp(S1,G,[O|Os],P).	%And plan the next action, including the operator in the op list and using the new state

%Describes the operators
pop(stack(X,Y),
    [on(X,Z),clear(X),clear(Y),cube(Y)],
    [on(X,Y),clear(Z)],
    [on(X,Z),clear(Y)]).

pop(unstack(X),
    [on(X,Y),cube(Y),clear(X)],
    [on(X,table),clear(Y)],
    [on(X,Y)]).

	

satisfied([],_).
satisfied([Pre|Ps],S) :- select(Pre,S,S1), satisfied(Ps,S1).

%select(X,[X|Xs],Xs).
%select(X,[Y|Ys],[Y|Zs]) :- select(X,Ys,Zs).

initial_state([cube(a),cube(b),cube(c),
	       on(b,table),on(c,a),on(a,table),clear(b),clear(c)]).
goal_state([on(a,b),on(b,c),on(c,table)]).