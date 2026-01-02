-module(wx_counter_erl).
-export([main/1]).


-spec main(Args) -> any() when Args :: [string()].
main(Args) ->
    argparse:run(Args, cli(), #{}).


-spec cli() -> argparse:command().
cli() ->
    #{
      arguments => [#{name => username, type => string}],
      handler => fun app/1
     }.


-spec app(Args) -> ok when Args :: map().
app(#{username := UserName}) ->
    io:format("~p~n", [UserName]).
