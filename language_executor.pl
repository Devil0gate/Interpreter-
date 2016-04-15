:-consult('parser.pl').
:-consult('symbol_.pl').
:-consult('_interpreter.pl').

run_program(FileName, Arguments, Result):-
	create_empty_table(),
	run(FileName, Parsed),
%	write(Parsed),nl,
	initialize_functions(Parsed), !,
%	write(Parsed), nl,
	
	call_func('main', Arguments, Result).
	
run_I() :-
	working_directory(_,'C:/Users/Dan/Desktop'),
	run_program('New_tokenize.txt', [2], X),
	write(X).
%	

	
	