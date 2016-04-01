:-include('tokenizer.pl').
:-include('lexer.pl').
:-include('grammar.pl').

% demo file for running parser
run(FileName):-
    tokenize_file(FileName, TokenList),
    lexer(TokenList, LexedList),
    phrase(program(SList),LexedList),
    format(TokenList,SList,Result,_),
    write(Result).
%    validate_rL(SList, TokenList),
%    write(SList).

% recap tokens
format(TokenList,[],[],TokenList).
   format(TokenList,[H1|T1],[X|Y],TokenList_):-
      is_list(H1),
      format(TokenList,H1,X,Z),
      format(Z,T1,Y,TokenList_).
format([H|T],[_|T1],[H|Result],TokenList_0):-
   format(T,T1,Result,TokenList_0).  
    
% validate_rL([H|T],[H1|T1]):-
%    check_list([H|T],H,_),
%    replace_token([H|_],[H1|_]),
%    check_list([H|T],_,T),
%    replace_token([_|T],[_|T1]).

% check when reading a list or not
% check_list(X,[],[]).
% check_list([H|T],H,T):-
%    check_list(H,_,_),
%    is_list(H),
%    check_list(T,_,_).
    
% replace labels with right tokens
% replace_token([],[]).
% replace_token([H|T],[H1|T1]):-
%    replace_token(H,H1),
%    replace_token(T,T1).
        

    
    
% output the structured list appropriately labeling tokens in production well written in lists
% with given appropriate format
% parse_list(LexedList, Slist):-
%    phrase(program(SList),LexedList,[]),
%    phrase(program(SList),LexedList),
%    format('~s~n',[SList]).

% write out grammar in formatted manner
%    program(I)-->[I],{write_list(I),nl}.
%    program(I)-->[I],{write_list(I)},program(I).    

    

