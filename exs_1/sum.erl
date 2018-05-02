-module (sum).

-export ([sum/1,sum/2]).

sum([]) -> 0;
sum([H|T]) when is_integer(H) -> H + sum(T).

sum([],ACC) when is_integer(ACC) -> ACC;
sum([H|T],ACC) when is_integer(H), is_integer(ACC) -> sum(T,H+ACC).