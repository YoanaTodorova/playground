- module(sum).
- compile(export_all).


funct() ->
     Main = self(),
     [spawn(fun() ->
		    Main ! { main, X * X } end) || X <- lists:seq(1,10)],
    lists:sum([getMsg() || X <- lists:seq(1,10)]);
funct(Pid) ->
    [spawn(fun(X) ->
		   Pid ! { main, X * X } end) || X <- lists:seq(1,10)],
    loop().

getMsg() ->
    receive
	{ main, Msg } -> Msg
    end.

loop() ->
    receive
	{ main, S } -> S
    end,    
    loop().

