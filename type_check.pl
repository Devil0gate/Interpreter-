:-consult('symbol_.pl').

expressionHandler(['if', Comparison, 'then', Val1, 'else', Val2], Result):-
	compar(Comparison, ComparisonResult),
	valueHandler(Val1, ValResult1),
	valueHandler(Val2, ValResult2),
	evaluate(ComparisonResult, ValResult1, ValResult2, Result).
	
expressionHandler(['let',ID,'=',Value,'in',Expression], Result):-
	valueHandler(Value, ValueResult),
	add_symbol(ID, ValueResult),
	expressionHandler(['let',ID,'=',ValueResult,'in',Expression], Result),
	remove_symbol(ID).
			
expressionHandler([Value, ExtraExpression], Result):-
	valueHandler(Value, ValueResult1),
	extraExpressionHandler(ExtraExpression, [Operator, ValueResult2]),
	evaluate(Operator, ValueResult1, ValueResult2, Result).

evaluate('+', V1, V2, Result) :- Result is V1 + V2.
evaluate('-', V1, V2, Result) :- Result is V1 - V2.
evaluate( 0, ValResult1, _, ValResult1 ).
evaluate( 1, _, ValResult2, ValResult2 ).

extraExpressionHandler([], []).		
extraExpressionHandler(Arithmetic, Result):-
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

call_func(Name, Parameters, Result):-
% return type could be ommited??
	get_symbol(Name, [_, Params, FuncBody]),
	
	add_symbol_list(Params, Parameters),
	expressionHandler(FuncBody, Result),
	remove_symbols(Params),
	
	b_getval(symbol_table,Map),
	get_assoc(timer, Map, T, NewMap, NewT),
	NewT is T + 1,
	b_setval(symbol_table, NewMap).
			
valueHandler(Number, Number).
	
valueHandler([ID, ValueParameter], Result):-
	valuePar(ValueParameter, ValParRe),
	Result = [ID, ValParRe],
	call_func(ID, ValParRe, Result).
	
valuePar(['(', Parameters, ')'], Result):-
	par(Parameters, Paresult),
	Result = ['(', Paresult, ')'].
	
par([Value, ParametersList], Result):-
	valueHandler(Value, ValueResult),
	parList(ParametersList, ParLresult),
	Result = [ValueResult, ParLresult].
	
parList([',', Parameters],Result):-
	par(Parameters, Paresult),
	Result = [',', Paresult].

parList([],[]).


	
		