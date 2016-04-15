:-consult('symbol_.pl').

expressionHandler(['if', Comparison, 'then', Val1, 'else', Val2], Result):-
	compar(Comparison, ComparisonResult),
	valueHandler(Val1, ValResult1),
	valueHandler(Val2, ValResult2),
	evaluate(ComparisonResult, ValResult1, ValResult2, Result).
%	write('Result_conditional_check'), nl,
%	write(Result).
	
expressionHandler(['let',ID,'=',Value,'in',Expression], Result):-
%	write('begin'),
	valueHandler(Value, ValueResult),
	add_symbol(ID, ValueResult),
%	write('get_in'),
	expressionHandler(Expression, Result),
%	write('Result_Let_check'), nl,
%	write(Result),
	remove_symbol(ID).
			
expressionHandler([Value, ExtraExpression], Result):-
%	write('Start Func: '), write(Value), write(' '), write(ExtraExpression), nl,
	valueHandler(Value, ValueResult1),
%	write('Before ExtExp: '), write(ValueResult1), nl,
	extraExpressionHandler(ExtraExpression, [Operator, ValueResult2]),
	%write('Before Eval: '), write(ValueResult1), write(' '), write(Operator), write(' '), write(ValueResult2), nl,
	evaluate(Operator, ValueResult1, ValueResult2, Result).
%	write('Result_func_check'), nl,
%	write(Result).

evaluate('+', V1, V2, Result) :- Result is V1 + V2.
evaluate('-', V1, V2, Result) :- Result is V1 - V2.
evaluate( 0, ValResult1, _, ValResult1 ).
evaluate( 1, _, ValResult2, ValResult2 ).

extraExpressionHandler([], ['+', 0]).		
extraExpressionHandler([Arithmetic], Result):-
	arithmeticHandler(Arithmetic, Result).	
			
arithmeticHandler(['+', Value], ['+', ValueResult]):-
	valueHandler(Value, ValueResult).
		
arithmeticHandler(['-', Value], Result):-
	valueHandler(Value, ValueResult),
	Result = ['-', ValueResult].
	
comparHandler(['==', Value], Result):-
	valueHandler(Value, ValueResult),
	Result = ['==', ValueResult].

comparHandler(['!=', Value], Result):-
	valueHandler(Value, ValueResult),
	Result = ['!=', ValueResult].
	
comparHandler(['>', Value], Result):-
	valueHandler(Value, ValueResult),
	Result = ['>', ValueResult].
	
comparHandler(['>=', Value], Result):-
	valueHandler(Value, ValueResult),
	Result = ['>=', ValueResult].
	
compar([Value, ComparisonRight], Result):-
	valueHandler(Value, ValueResult),
	comparHandler(ComparisonRight, [Op, ComparR]),
	evaluateComparison( Op, ValueResult, ComparR, Result).
	
evaluateComparison( '==', A, A, 0 ):- !.

evaluateComparison( '==', _, _, 1 ).

evaluateComparison( '!=', A, B, 0 ):-
	A \== B, !.
evaluateComparison( '!=', _, _, 1).

evaluateComparison( '>', A, B, 0 ):-
	A > B, !.
evaluateComparison( '>', _, _, 1).

evaluateComparison( '>=', A, B, 0 ):-
	A >= B, !.
evaluateComparison( '>=', _, _, 1 ).

type_c('int', Val):- integer(Val).	
type_c('bool', 1).	
type_c('bool', 0).

parse_params( [], [], [] ).
parse_params( [[Type, Name], []], [H], [Name] ) :-
	type_c(Type, H),
%	write('Name: '), nl, write(Name), nl, write('Value: '), write(H),
	add_symbol(Name, H).
parse_params([[Type, Name],[',', T]], [H|Rest], [Name|Result] ):-
	type_c(Type, H),
%	write('Name: '), nl, write(Name), nl, write('Value: '), write(H),
	add_symbol(Name, H),
	parse_params(T, Rest, Result).
	
call_func(Name, Parameters, Result):-
	get_symbol(Name, [RT, Params, FuncBody]),
%	write('FuncBody: '), write( FuncBody ), nl,
%	write('Params: '), write(Params), nl,write('Parameters'), nl, write(Parameters),
%	trace,
	parse_params( Params, Parameters, VariableList),
	write('Calling Expression'), nl, !,
%	trace,
	expressionHandler(FuncBody, Result),
%	write('CResult: '), write(Result), nl,
	type_c(RT, Result),
	remove_symbols(VariableList).
	
			
valueHandler([Atom], Value) :- atom(Atom), atom_number(Atom, Value).
valueHandler([Number], Number).

valueHandler([ID, []], Result):-
	get_symbol(ID, Result).	
	
valueHandler([ID, ValueParameter], Result):-
%	write('VH1: '), write(ID), write('   '), write(ValueParameter), nl,
	valuePar(ValueParameter, ValParRe),
%	write('VH2: '), write(ID), write(' '), write(ValParRe), nl,
	call_func(ID, ValParRe, Result).
		
valuePar(['(', Parameters, ')'], Result):-
	par(Parameters, Result).
%	write('ParaList'),
	%nl, write(Result).
	
par([Value, ParametersList], Result):-
	valueHandler(Value, ValueResult),
	parList(ParametersList, ParLresult),
	Result = [ValueResult|ParLresult].

parList([],[]).	
parList([',', Parameters],Result):-
	par(Parameters, Result).




	
		