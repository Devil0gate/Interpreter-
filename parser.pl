:-consult('tokenizer.pl').
:-consult('lexer.pl').
:-consult('grammar.pl').

run_p(X) :-
	working_directory(_,'C:/Users/Dan/Desktop'),
	run('New_tokenize.txt', X).
	
run(FileName, Result):-
    tokenize_file(FileName, TokenList),
    lexer_file(TokenList, LexedList),
    phrase(program(SList),LexedList),
    format(TokenList,SList,Result,_).
    
format(TokenList,[],[],TokenList).
   format(TokenList,[H1|T1],[X|Y],TokenList_):-
      is_list(H1),
      format(TokenList,H1,X,Z),
      format(Z,T1,Y,TokenList_).
format([H|T],[_|T1],[H|Result],TokenList_0):-
   format(T,T1,Result,TokenList_0).  
   
% output the structured list appropriately labeling tokens in production well written in lists
% with given appropriate format
% parse_list(LexedList, Slist):-
%    phrase(program(SList),LexedList,[]),
%    phrase(program(SList),LexedList),
%    format('~s~n',[SList]).

% write out grammar in formatted manner
%    program(I)-->[I],{write_list(I),nl}.
%    program(I)-->[I],{write_list(I)},program(I).    

    

