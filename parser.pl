:-include('tokenizer.pl').
:-include('lexer.pl').
:-include('grammar.pl').

% demo file for running parser
run(FileName, StructuredList):-
    tokenize_file(FileName, Tokens),
    lexer(Tokens, LexedList),
    parse_list(LexedList, StructuredList),
    write(StructuredList).

% output the structured list appropriately labeling tokens in production well written in lists
% with given appropriate format
parse_list(LexedList, Result):-
    phrase(program(LexedList),StrcturedList,[]),
    phrase(program(LexedList),StrcturedList,Result),
    format('~s~n',[Result]).

% write out grammar in formatted manner
%    program(I)-->[I],{write_list(I),nl}.
%    program(I)-->[I],{write_list(I)},program(I).    

    

