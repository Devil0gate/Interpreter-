tokenize_file(FileName, TokenList):-
	open(FileName, read, Str),
	token_list(Str,TokenList), 
	close(Str).
   
token_list(Str,L):-
	get0(Str, Char),
	checkAndread(Char,List,Str),
	replace(9,32,List,List1),
	replace(10,32,List1,List2),
	replace(13,32,List2,List3),
	compress(List3, List4),
	atom_codes(List5,List4),
	atomic_list_concat(L,' ',List5).
			
checkAndread(end_of_file,[],_):-!.
checkAndread(-1,[],_):-!.
checkAndread(Char, [Char|List], Str):-
	get0(Str, X),
	checkAndread(X, List, Str).
	
replace(_, _,[],[]).
replace(H,H2,[H|T],[H2|T2]) :- replace(H,H2,T,T2).
replace(H,H2,[H3|T],[H3|T2]) :- replace(H,H2,T,T2).

compress([], []).
compress([32|T1],[32|T2]):-
	reduce(T1,T2), !.
compress([H|T1],[H|T2]):-
	compress(T1,T2).
		
reduce([32|T1],T2):-
	reduce(T1,T2).
reduce([H|T1],[H|T2]):-
	H\==32,
	compress(T1,T2).
	
	
	
	
	

