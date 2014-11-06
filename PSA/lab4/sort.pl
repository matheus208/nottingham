%sort(+X,?Sorted) sorts the X list into Sorted

%Quicksort
qsort([],[]).
qsort([H|T], Sorted) :-
	
	%uses first element in list as a pivot to separate the tail into L1 and L2
	pivot(H,T,L1,L2),
	
	%sorts both lists
	qsort(L1, Sorted1),
	qsort(L2, Sorted2),
	
	%append them, with the pivot in the middle
	append(Sorted1,[H|Sorted2], Sorted).

%pivot(+P,+L,?O1,?O2) uses P as a pivot to separate list L into O1 and O2
pivot(_,[],[],[]).
pivot(P,[L|Ls],[L|O1s],O2) :-
	L =< P,
	pivot(P,Ls,O1s,O2).
pivot(P, [L|Ls], O1, [L|O2s]) :-
	L>P,
	pivot(P, Ls, O1, O2s).
