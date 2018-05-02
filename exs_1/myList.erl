-module (myList).

-export ([foldl/3,foldr/3,map/2,all/2,filter/2,tree/0,mapT/2,foldT/3,find/2]).

foldl(_,ACC,[]) -> ACC;
foldl(F,ACC,[H|T]) -> foldl(F,F(H,ACC),T).

foldr(_,ACC,[]) -> ACC;
foldr(F,ACC,[H|T]) -> F(H,foldr(F,ACC,T)).

map(F,L) -> foldr(fun (E,ACC) -> [F(E)|ACC] end, [], L).

all(F,L) -> foldl(fun (A,B) -> A and B end,true,map(F,L)).

filter(_,[]) -> [];
filter(P,[H|T]) ->
    case P(H) of
        true -> [H|filter(P,T)];
        false -> filter(P,T)
    end.

tree() -> {node, 2, {node, 5, void, void}, {node, 6, {node, 8, void, void}, void}}.

mapT(_, void) -> void;
mapT(F,{node, N, L, R}) ->
    {node, F(N), mapT(F,L), mapT(F,R)}.

foldT(F,ACC,T) -> foldT_aux(F,ACC,[T]).

foldT_aux(_,ACC,[]) -> ACC;
foldT_aux(F,ACC,[void|T]) -> foldT_aux(F,ACC,T);
foldT_aux(F,ACC,[{node, N, L, R}|T]) -> foldT_aux(F,F(N,ACC),[L,R|T]).

find(P,T) -> find_aux(P,[T]).

find_aux(_,[]) -> false;
find_aux(P,[void|T]) -> find_aux(P,T);
find_aux(P,[{node, N, L, R}|T]) ->
    case P(N) of
         true -> {ok, N};
         false -> find_aux(P,[L,R|T])
     end.