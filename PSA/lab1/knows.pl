
% KNOWLEDGE BASE

knows(pam,bob).
knows(bob,ann).
knows(bob,pat).

knows(jane, jim).
knows(jane, steve).
knows(jim, matt).

knows(kyle, susy).

likes(bob, coffee).
likes(pam, coffee).
likes(pam, clothes).

likes(jane, cars).
likes(steve, horses).

likes(kyle, coffee).



% DEFINITION OF FRIEND/2
% X is Y's friend if one of them knows the other
friend(X,Y) :-
	knows(X,Y).

% or if they share a common person they know.
friend(X,Y) :-
	knows(X,Z),
	friend(Z,Y),
	X\=Y.

%reciprocal
friend(X,Y) :-
	friend(Y,X),!.
	

%DEFINITION OF RECOMMENDS/2	
% a person is recommended a product if s/he likes the product or if one if their friends likes the product
recommends(X,P) :-
	likes(X,P).

recommends(X,P) :-
	friend(X,Z),
	likes(Z,P).