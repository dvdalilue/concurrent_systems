-module (member).

-export ([member/2,insert/2]).

member(_,[]) -> false;
member(H,[H|_]) -> true;
member(E,[_|T]) -> member(E,T).

insert(X,[]) -> [X];
insert(X,[H|T]) when X > H -> [H|insert(X,T)];
insert(X,[H|T]) -> [X,H|T].