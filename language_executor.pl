:-consult('parser.pl').
:-consult('symbol_.pl').
:-consult('_interpreter.pl').

run_program(FileName, Arguments, Result):-
	create_empty_table(),
	run(FileName, Parsed),
	initialize_functions(Parsed), !,
	
	call_func('main', Arguments, Result).
	
run_I() :-
	working_directory(_,'C:/Users/Dan/Desktop'),
	run_program('New_tokenize.txt', [2, 3], X),
	write(X).
%	

	
	