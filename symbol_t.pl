:- use_module(library(assoc)).

main:-
	print_out_table().
	
print_out_table():-
	create_empty_table(),
	add_symbol(a,2),add_symbol(b,3),add_symbol(c,4),add_symbol(c,5),remove_symbol(c),
	b_getval(symbol_table,Map),
	assoc_to_list(Map,List),
	write(List).
		
test_Params():-
	P = [[int,a],[,,[[int,b],[]]]],
	form_Params(P, PL),
	write(PL).
	
test_format_func():-
	create_empty_table(),
	F = [['int','add'],'(',[['int','a'],[',',[['int','b'],[]]]],')','=',[['a',[]],[['+',['b',[]]]]]],
	format_function(F),
	b_getval(symbol_table,Map),
	assoc_to_list(Map,List),
	write(List).
	
print_out_symbolTable():-
	create_empty_table(),
	T = [[['int','add'],'(',[['int','a'],[',',[['int','b'],[]]]],')','=',[['a',[]],[['+',['b',[]]]]]]],
	init_func(T),
	b_getval(symbol_table,Map),
	assoc_to_list(Map,List),
	write(List).
		
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

init_func([]).		
init_func([Function|FunctionList]):-
	format_function(Function),
	init_func(FunctionList).
	
format_function([[Ret,Name],'(',Params,')','=',FuncBody]):-
	form_Params(Params, ParamsList),
	add_symbol(Name,[Ret,ParamsList,FuncBody]).
	
form_Params([P, []], [P]).
	form_Params([P, List],[Head|PL]):-
	(is_list(P)->
		(Head = P,
		form_Params(List,PL));
		form_Params(List,[Head|PL])
		).

	
% retrieve_([],[],[],[],[]).	
% retrieve_([H|T], N, Rt, Pa, Fb):-
%	member_(H, Rt, N),
%	retrieve_fb_member(T, _, _, Pa, Fb).

% retrieve_fb_member(BL, _, _, Pa, Fb):-
%	member_(BL, Pa, Fb),
%	is_list(Pa),is_list(Fb).
		
% retrieve_fb_member(BL, _, _, Pa, Fb):-
%	member_(BL, Pa, Fb),
%	get_tail(Pa,Tp),get_tail(Fb,Tf),
%	retrieve_fb_member(BL, _, _, Tp, Tf).
					
% assign corresponding values onto given list
% member_([],[]).
% member_([H|[H1|_]], N, B):-
%	N = H, B = H1.
		
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