% :-include('tokenizer.pl').
%:-include('grammar.pl').

% test demo for lexer
run(FileName, LexedList):-
    tokenize_file(FileName, Tokens),
    lexer(Tokens, LexedList).
% convert_token("int","TYPE_INT").
convert_token(X,Y):-
    (Y = 'int', X = 'TYPE_INT'),!;
    (Y = 'bool', X = 'TYPE_BOOL'),!;
    (Y = ',',X = 'COMMA'),!;
    (Y = '=',X = 'ASSIGN'),!;
    (Y = 'let',X = 'LET'),!;
    (Y = 'in',X = 'LET_IN'),!;
    (Y = 'if',X = 'COND_IF'),!;
    (Y = 'then',X = 'COND_THEN'),!;
    (Y = 'else',X = 'COND_ELSE'),!;
    (Y = '==',X = 'LOGIC_EQ'),!;
    (Y = '!=',X = 'LOGIC_NOT_EQ'),!;
    (Y = '>',X = 'LOGIC_GT'),!;
    (Y = '>=',X = 'LOGIC_GTEQ'),!;
    (Y = '+',X = 'ARITH_ADD'),!;
    (Y = '-',X = 'ARITH_SUB'),!;
    (Y = '(',X = 'OPEN_P'),!;
    (Y = ')',X = 'CLOSE_P'),!;
    (atom_number(Y, Z),integer(Z) ,X = 'INTEGER'),!;
    (X='IDENTIFIER').
    
    lexer([],[]).
    lexer([H1|T1],[H2|T2]):-
    	convert_token(H2,H1),
    	lexer(T1,T2).
    	