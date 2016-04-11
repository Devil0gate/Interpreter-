:-consult('parser.pl').
:-consult('symbol_.pl').
:-consult('type_check.pl').

run_program(FileName, Arguments, Result):-
	run(FileName, Parsed),
	create_empty_table(),
	initialize_functions(Parsed),
	call_func('main', Arguments, Result).
	

	
	