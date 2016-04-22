:-consult('type_check.pl').


check(Result):-
%	expressionHandler(['if', [1, ['!=', 1]], 'then', 2, 'else', 1],Result).
	expressionHandler([[1],[['+',[1]]]],Result).