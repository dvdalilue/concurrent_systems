-module (hash).

-export ([keyfind/2]).

keyfind(_,[]) -> false;
keyfind(K,[{K,V}|_]) -> {K,V};
keyfind(K,[_|T]) -> keyfind(K,T).