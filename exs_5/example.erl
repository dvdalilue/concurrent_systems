-module (example).

-import (lists, [member/2,delete/2]).

-include_lib("eqc/include/eqc.hrl").

-compile([export_all]).

even_nat() ->
    ?SUCHTHAT(N, nat(),
              N rem 2 == 0).
                          
prop_nat() ->
    ?FORALL(N, even_nat(),
            N * N >= 0).

prop_delete_elem() ->
    ?FORALL(L, list(int()),
        ?FORALL(E, int(),
            case member(E,L) of
                true -> length(delete(E,L)) == length(L) - 1;
                false -> delete(E,L) == L
            end
        )
    ).

prop_add_delete() ->
    ?FORALL(L, list(int()),
        ?FORALL(E, int(),
            delete(E,[E|L]) == L
        )
    ).