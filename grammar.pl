% apply Definite Clause Grammar
program --> functionList.
functionList --> function, functionListCollection.
functionListCollection --> functionList.
functionListCollection --> [].
function --> typeID, ['OPEN_P'], typeIDList, ['CLOSE_P'], ['ASSIGN'], expression.
typeID --> ['TYPE_INT'],['IDENTIFIER'].
typeID --> ['TYPE_BOOL'],['IDENTIFIER'].
typeIDList --> typeID, typeIDListCollection.
typeIDListCollection --> ['COMMA'], typeIDList.
typeIDListCollection --> [].
expression --> ['COND_IF'], comparison, ['COND_THEN'], value, ['COND_ELSE'], value.
expression --> ['LET'], ['IDENTIFIER'], ['ASSIGN'], value, ['LET_IN'], expression.
expression --> value, extraExpression.
extraExpression --> arithmetic.
extraExpression --> [].
arithmetic --> ['ARITH_ADD'], value.
arithmetic --> ['ARITH_SUB'], value.
comparison --> value, comparisonRight.
comparisonRight --> ['LOGIC_EQ'], value.
comparisonRight --> ['LOGIC_NOT_EQ'], value.
comparisonRight --> ['LOGIC_GT'], value.
comparisonRight --> ['LOGIC_GTEQ'], value.
value --> ['INTEGER'].
value --> ['IDENTIFIER'], valueParameters.
valueParameters --> ['OPEN_P'], parameters, ['CLOSE_P'].
valueParameters --> [].
parameters --> value, parametersList.
parametersList --> ['COMMA'], parameters.
parametersList --> [].