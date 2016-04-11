% :-include('tokenizer.pl').
% :-include('lexer.pl').
% :-include('grammar.pl').
% :-include('parser.pl').
:-use_module(library(assoc)).

% main:-
%	print_out_table().
			
% print_out_symbolTable():-
%	create_empty_table(),
%	run('comparison_test.txt',T1),
%	initialize_functions(T1),
%	b_getval(symbol_table,Map),
%	assoc_to_list(Map,List),
%	write(List).
		
% create a empty symbol table
create_empty_table():-
	empty_assoc(Map),
	b_setval(symbol_table,Map).

% Accepts a key, value pair as arguments and adds a symbol to
% the table in the form ?
add_symbol(Key,Value):-
	b_getval(symbol_table,Table),
	assoc_to_keys(Table,KeyList),
	(if_key_exist(Key, KeyList)-> 
		get_assoc(Key,Table,Val,NewMap,[Value|Val]);
		put_assoc(Key,Table,Value,NewMap)),	
	b_setval(symbol_table,NewMap).
	
% get_symbol predicate used for call function
get_symbol(Name, Body):-
	b_getval(symbol_table,Table), 
	get_assoc(Name,Table,Body).
		
if_key_exist(Key,[Key|_]):-!.
	if_key_exist(Key,[_|KeyList]):-
	if_key_exist(Key,KeyList).	

add_symbol_list([],[]).
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
get_tail([],[]).	
get_tail([_|T],T).

% initialize function 
initialize_functions([]).
initialize_functions([[Type,ID],'(',B,')','=',C]):-
	b_getval(symbol_table,M),
	put_assoc(ID,M,[[Type,B,C]],Newmap),
	b_setval(symbol_table,Newmap), !.
initialize_functions([H|T]):-
	is_list(H),
	initialize_functions(H),
	initialize_functions(T), !.
initialize_functions([_|T]):-
	initialize_functions(T).
	
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

%----------------------------------------------------------this is for _intepreter

% print_out_table():-
%	create_empty_table(),
%	add_symbol(a,2),add_symbol(b,3),add_symbol(c,4),add_symbol(c,5),remove_symbol(c),
%	b_getval(symbol_table,Map),
%	assoc_to_list(Map,List),
%	write(List).
	
% storing functions in associated list
% use function name as the key, the other list as value [[Rety, Para, Body]]
% as add_symbol/removel_symbol