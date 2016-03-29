main :-
	create_empty_table,
	add_symbol(a , 11 ),
	add_symbol(b, 7 ),
	write('main1; '),
	print_symbol_table, nl,
	func( 5 ),
	write('main2: '),
	print_symbol_table, nl, !.


func( Value ) :-
	add_symbol( a, Value ),
	write('Func: '),
	print_symbol_table, nl,
	remove_symbol( a ).
	
% storing functions in associated list
% use function name as the key, the other list as value [[Rety, Para, Body]]
% as add_symbol/removel_symbol