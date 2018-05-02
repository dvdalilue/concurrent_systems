-module (fib).

-export ([fib/1,fib_with_index/1,client/0,server/0]).
% -export ([fib/1,fib/3]).

% fib(0) -> 0;
% fib(1) -> 1;
% fib(X) when is_integer(X), X > 1 ->
%     fib(X-1) + fib(X-2).

fib(X) -> fib(0,1,X).

fib_with_index(X) -> {X,fib(0,1,X)}.

fib(Y,_,N) when is_integer(Y), N < 1 -> Y;
fib(X,Y,N) when is_integer(X),
                is_integer(Y),
                is_integer(N) ->
    fib(Y, X+Y, N-1).

client() ->
    receive
        {fib,N} -> io:format("Fib: ~p~n",[N]), client();
        {fib,Server,N} -> Server ! {fib,self(),N}, client();
        _ -> client()
    end.

server() ->
    receive
        {fib,PID,N} -> PID ! {fib,fib(N)}, server();
        _ -> server()
    end.