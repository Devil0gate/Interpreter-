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
create_empty_table():-
	empty_assoc(Map),
	b_setval(symbol_table,Map).
		
% Accepts a key, value pair as arguments and adds a symbol to
% the table in the form 
add_symbol(Key,Value):-
	b_getval(symbol_table,Table),
	get_assoc(Key,Table,Val),
	addFirst(Val,Value,RL),
	put_assoc(Key,Table,RL,NewMap_),
	b_setval(symbol_table,NewMap_).

% Add an element to the front of the given list
addFirst([], Element, [Element]).
addFirst(List, Element, [Element|List]).
	
% Accepts a list of keys as the first argument and a list of
% values as the second argument	
add_symbol_list([H|T],[H1|T1]):-
	add_symbol(H,H1),
	add_symbol_list(T,T1).

% Accepts a key as an argument and removes the most recently
% added value	
remove_symbol(Key):-
%	b_getval(symbol_table,[Key|Rest]),
%	b_setval([_|Rest],[_]).
	b_getval(symbol_table, Table),
	get_assoc(Key, Table, Val),
	get_tail(Val,Tail),
	put_assoc(Key,Table,Tail,Symbol),
	b_setval(symbol_table, Symbol).

% get the tail of the list	
get_tail([H|T],T).
		
% init_func(FunctionList):-
			
% executing a function	
% call_func(Name, Parameters, Result):-
%	get_symbol(Name, [RetType, Params, FuncBody]),
%	add_symbol_list(Params, Parameters),
%	expression(FuncBody, Result),
%	remove_symbols(Params),
%	b_getval(symbol_table,Map),
%	get_assoc(timer, Map, T, NewMap, NewT),
%	NewT is T + 1,
%	b_setval(symbol_table, NewMap).
	
	
%	add_symbol( a, Value ),
%	write('Func: '),
%	print_symbol_table, nl,
%	remove_symbol( a ).
	
% storing functions in associated list
% use function name as the key, the other list as value [[Rety, Para, Body]]
% as add_symbol/removel_symbol