%sort(+X,?Sorted,R) sorts the X list into Sorted based on the relation R

%Quicksort
qsort([],[],_).
qsort([H|T], Sorted,R) :-
	
	%uses first element in list as a pivot to separate the tail into L1 and L2
	pivot(H,T,L1,L2,R),
	
	%sorts both lists
	qsort(L1, Sorted1,R),
	qsort(L2, Sorted2,R),
	
	%append them, with the pivot in the middle
	append(Sorted1,[H|Sorted2], Sorted).

%pivot(+P,+L,?O1,?O2,R) uses P as a pivot to separate list L into O1 and O2 according to relation R
pivot(_,[],[],[],_).
pivot(P,[L|Ls],[L|O1s],O2,R) :-
	%calls user-defined relation R onto parameters L and P
	G =.. [R,L,P],
	call(G),
	%proceeds pivoting
	pivot(P,Ls,O1s,O2,R).

pivot(P, [L|Ls], O1, [L|O2s],R) :-
	%calls user-defined relation R onto parameters L and P
	G =.. [R,P,L],
	call(G),
	
	pivot(P, Ls, O1, O2s,R).

	
less_than(X,Y) :-
	X < Y.