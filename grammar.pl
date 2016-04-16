program([A]) --> 
	functionList(A).
functionList([A,B]) --> 
	function(A), 
	functionListCollection(B).
functionListCollection(A) --> 
	functionList(A).
functionListCollection([]) --> [].
function([A,'(',B,')','=',C]) --> 
	typeID(A), 
	['OPEN_P'],
	typeIDList(B), 
	['CLOSE_P','ASSIGN'], 
	expression(C).
typeID(['int','id']) --> 
	['TYPE_INT','IDENTIFIER'].
typeID(['bool','id']) --> 
	['TYPE_BOOL','IDENTIFIER'].
typeIDList([A,B]) --> 
	typeID(A), 
	typeIDListCollection(B).
typeIDListCollection([',',A]) --> 
	['COMMA'], 
	typeIDList(A).
typeIDListCollection([]) --> [].
expression(['if',X,'then',Y,'else',Z]) -->
	['COND_IF'], 
	comparison(X), 
	['COND_THEN'], 
	value(Y), 
	['COND_ELSE'], 
	value(Z).
expression(['let','id','=',A,'in',B]) -->
        ['LET','IDENTIFIER','ASSIGN'], 
        value(A), 
        ['LET_IN'], 
        expression(B).
expression([A,B]) --> 
	value(A), 
	extraExpression(B).
extraExpression([A]) --> 
	arithmetic(A).
extraExpression([]) --> [].
arithmetic(['+',A]) --> 
	['ARITH_ADD'], 
	value(A).
arithmetic(['-',A]) --> 
	['ARITH_SUB'], 
	value(A).
comparison([A,B]) --> 
	value(A),
	comparisonRight(B).
comparisonRight(['==',A]) --> 
	['LOGIC_EQ'], 
	value(A).
comparisonRight(['!=',A]) -->
	['LOGIC_NOT_EQ'], 
	value(A).
comparisonRight(['>',A]) -->
	['LOGIC_GT'], 
	value(A).
comparisonRight(['>=',A]) -->
	['LOGIC_GTEQ'], 
	value(A).
value([integer]) --> 
	['INTEGER'].
value(['id',A]) --> 
	['IDENTIFIER'],
        valueParameters(A).
valueParameters(['(',A,')']) -->
	['OPEN_P'], 
	parameters(A), 
	['CLOSE_P'].
valueParameters([]) -->
	[].
parameters([A,B]) --> 
	value(A), 
	parametersList(B).
parametersList([',',A]) --> 
	['COMMA'], 
	parameters(A).
parametersList([]) --> 
	[].