% apply Definite Clause Grammar
program --> [functionList].
functionList --> [function, functionListCollection].
functionListCollection --> [functionList].
functionListCollection --> [ ].
function --> [typeID, '(', typeIDList, ')', '=', expression].
typeID --> ['TYPE_INT','IDENTIFIER'].
typeID --> ['TYPE_BOOL','IDENTIFIER'].
typeIDList --> [typeID, typeIDListCollection].
typeIDListCollection --> [',', typeIDList].
typeIDListCollection --> [ ].
expression --> ['if', comparison, 'then', value, 'else', value].
expression --> ['let', 'IDENTIFIER', '=', value, 'in', expression].
expression --> [value, extraExpression].
extraExpression --> [arithmetic].
extraExpression --> [ ].
arithmetic --> ['+', value].
arithmetic --> ['_', value].
comparison --> [value, comparisonRight].
comparisonRight --> ['==', value].
comparisonRight --> ['!=', value].
comparisonRight --> ['>', value].
comparisonRight --> ['>=', value].
value --> ['number'].
value --> ['Identifier',　valueParameters].
valueParameters --> ['(', parameters, ')'].
valueParameters --> [ ].
parameters --> [value, parametersList].
parametersList --> [',', parameters].
parametersList --> [ ].