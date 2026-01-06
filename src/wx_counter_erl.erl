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
    setup(Frame),
    wxFrame:show(Frame),
    loop(Frame),
    wx:destroy().


-spec setup(Frame) -> ok when Frame :: wxWindow:wxWindow().
setup(Frame) ->
    wxFrame:connect(Frame, close_window),
    ok.


-spec loop(Frame) -> ok when Frame :: wxWindow:wxWindow().
loop(Frame) ->
    receive
        #wx{event = #wxClose{}} ->
            io:format("Closing window...~n"),
            wxWindow:destroy(Frame),
            ok;

        %% Log other events for debugging
        Msg ->
            io:format("Event received: ~p~n", [Msg]),
            loop(Frame)
    end.
