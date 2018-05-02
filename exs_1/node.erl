-module (node).

-record(node, {value, left, right}).

-export ([new/3,tree/0,map/2,fold/3]).

-define (GET (T,V), T#node.V).

new(V,L,R) -> #node{value = V, left = L, right = R}.

tree() ->
    #node{
        value = 2,
        left = #node{value = 5, left = void, right = void},
        right = #node{
                    value = 6,
                    left = #node{value = 8, left = void, right = void},
                    right = void
                }
    }.

map(_,void) -> void;
map(F,T) ->
    new(F(T#node.value), map(F,T#node.left), map(F,T#node.right)).

fold(F,ACC,T) -> fold_aux(F,ACC,[T]).

fold_aux(_,ACC,[]) -> ACC;
fold_aux(F,ACC,[void|T]) -> fold_aux(F,ACC,T);
fold_aux(F,ACC,[Tree|T]) -> fold_aux(F,F(?GET(Tree,value),ACC),[Tree#node.left,Tree#node.right|T]).