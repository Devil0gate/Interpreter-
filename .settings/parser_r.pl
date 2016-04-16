%:-include('tokenizer.pl').
%:-include('lexer.pl').
%:-include('gra_m.pl').

% demo file for running parser
run(FileName, X):-
    tokenize_file(FileName, Tokens),
    lexer(Tokens, Y),
    parse_list(Y,X).
    
parse_list(LexedList,SList):-
    phrase(program(SList),LexedList).