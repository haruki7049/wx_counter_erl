-module(wx_counter_erl).
-export([main/1]).


-spec main(Args) -> any() when Args :: [string()].
main(Args) ->
    argparse:run(Args, cli(), #{}).


cli() ->
    #{
      arguments => [#{name => username, type => string}],
      handler => fun app/1
     }.


app(#{username := UserName}) ->
    io:format("~p~n", [UserName]).
