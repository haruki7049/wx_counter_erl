-module(wx_counter_erl).
-export([main/1]).
-include_lib("wx/include/wx.hrl").


-spec main(Args) -> any() when Args :: [string()].
main(Args) ->
    argparse:run(Args, cli(), #{}).


-spec cli() -> argparse:command().
cli() ->
    #{
      arguments => [],
      handler => fun app/1
     }.


-spec app(Args) -> ok when Args :: map().
app(#{}) ->
    wx:new(),
    Frame = wxFrame:new(wx:null(), ?wxID_ANY, "HOGE"),
    wxFrame:show(Frame),
    timer:sleep(infinity),
    wx:destroy().
