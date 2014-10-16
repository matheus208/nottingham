% KNOWLEDGE BASE
% TREE/3
% TREE(VALUE, LEFT_SUBTREE, RIGHT_SUBTREE)


% DEFINITION HEIGHT/2	
height(void,0).
height(tree(_,L,R),N) :-
	height(L, NL),
	height(R, NR),
	N is max(NL, NR) + 1.
	
	