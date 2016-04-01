main:-
	create_empty_table,
	add_symbol(a , 11 ),
	add_symbol(b, 7 ),
	write('main1; '),
	print_symbol_table, nl,
	func( 5 ),
	write('main2: '),
	print_symbol_table, nl,!.

% create a empty table
% create a empty symbol table
create_empty_table:-
	empty_assoc(Map),
	b_setval(NewMap,Map).
		
% Accepts a key, value pair as arguments and adds a symbol to
% the table in the form 
add_symbol(Key,Value):-
	b_getval(NewMap,Rest),
	put_assoc(Key,NewMap,Value,NewMap_),
	b_setval(Rest,NewMap_).

% Accepts a list of keys as the first argument and a list of
% values as the second argument	
add_symbol_list([H|T],[H1|T1]):-
	add_symbol(H,H1),
	add_symbol_list(T,T1).

% Accepts a key as an argument and removes the most recently
% added value	
remove_symbol(Result):-
	remove_symbol([_|Result]),
	remove_symbol([Result|_]).

% executing a function	
% call_func(Name, Parameters, Result):-
	












%	add_symbol( a, Value ),
%	write('Func: '),
%	print_symbol_table, nl,
%	remove_symbol( a ).
	
% storing functions in associated list
% use function name as the key, the other list as value [[Rety, Para, Body]]
% as add_symbol/removel_symbol