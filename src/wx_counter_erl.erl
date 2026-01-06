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


-spec setup(Frame) -> any() when Frame :: wxWindow:wxWindow().
setup(Frame) ->
    MenuBar = wxMenuBar:new(),
    File = wxMenu:new(),
    wxMenu:append(File, ?wxID_CLOSE, "Close\tCtrl+W"),

    wxMenuBar:append(MenuBar, File, "&File"),
    wxFrame:setMenuBar(Frame, MenuBar),

    wxFrame:connect(Frame, command_menu_selected),
    wxFrame:connect(Frame, close_window).


-spec loop(Frame) -> any() when Frame :: wxWindow:wxWindow().
loop(Frame) ->
    receive
        #wx{event = #wxClose{}} ->
            wxWindow:close(Frame, []);

        #wx{id = ?wxID_CLOSE, event = #wxCommand{type = command_menu_selected}} ->
            wxWindow:destroy(Frame);

        %% Log other events for debugging
        Msg ->
            io:format("Event received: ~p~n", [Msg]),
            loop(Frame)
    end.
