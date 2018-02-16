-module (sort).

-export ([sort/1]).

% sort([]) -> [];
sort(L) -> mergesort(L).

mergesort([]) -> [];
mergesort([S]) -> [S];
mergesort(L) ->
    {LH, RH} = split(L),
    SLH = mergesort(LH),
    SRH = mergesort(RH),
    merge(SLH,SRH).

split([]) -> {[],[]};
split([H]) -> {[H],[]};
split([H1,H2|T]) ->
    {L, R} = split(T),
    {[H1|L],[H2|R]}.

merge([],X) -> X;
merge(X,[]) -> X;
merge([H1|T1],[H2|T2]) ->
    if
        H1 < H2 -> [H1|merge(T1,[H2|T2])];
        true    -> [H2|merge([H1|T1],T2)]
    end.