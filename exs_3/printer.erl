-module (printer).

-export ([client/0,server/0]).

client() ->
    receive
        {lp,SID} ->
            SID ! {req,self()},
            client();
        _ -> client()
    end.

server() ->
    receive
        {req,PID} -> link(PID), server();
        _ -> server()
    end.