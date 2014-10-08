% Family relationships (after Bratko (2001), program 1.8)

father(X,Y) :-
    parent(X,Y),
    male(X).

mother(X,Y) :-
    parent(X,Y),
    female(X).

grandparent(X,Z) :-
    parent(X,Y),
    parent(Y,Z).

% X is Y's sibling
sibling(X,Y) :-
	parent(X,Z),
	parent(Y,Z).
	
% X is Y's sister
sister(X,Y) :-
	sibling(X,Y),
	female(X).

% X is Y's brother
brother(X,Y) :-
	sibling(X,Y),
	male(X).
	
parent(pam,bob).
parent(tom,bob).
parent(tom,liz).
parent(bob,ann).
parent(bob,pat).
parent(pat,jim).
parent(liz,jim).

male(tom).     
male(bob).
male(jim).
female(pam).
female(liz).
female(ann).
female(pat).

