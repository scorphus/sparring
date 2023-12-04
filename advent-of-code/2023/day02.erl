#!/usr/bin/env escript

-export([main/1]).

main(_) ->
    Games = read_stdin(),
    io:format("Part one: ~p~n", [part_one(Games)]),
    io:format("Part two: ~p~n", [part_two(Games)]).

read_stdin() ->
    case io:get_line("") of
        eof ->
            [];
        L ->
            [_ | L0] = string:split(L, ": "),
            L1 = [string:split(D, ", ", all) || D <- string:split(string:trim(L0), "; ", all)],
            [L1 | read_stdin()]
    end.

part_one(Games) -> validate_games(Games, 1).

part_two([]) ->
    0;
part_two([Game | Games]) ->
    lists:foldl(fun(V, Acc) -> Acc * V end, 1, maps:values(get_max_cubes(Game))) + part_two(Games).

validate_games([], _I) ->
    0;
validate_games([Game | Games], Ii) ->
    case validate_draws(Game) of
        true ->
            Ii + validate_games(Games, Ii + 1);
        false ->
            validate_games(Games, Ii + 1)
    end.

validate_draws([]) -> true;
validate_draws([Draw | Draws]) -> validate_draw(Draw) andalso validate_draws(Draws).

validate_draw([]) ->
    true;
validate_draw([D | Draw]) ->
    [N, Color] = string:split(D, " "),
    case {Color, erlang:list_to_integer(N)} of
        {"red", N0} ->
            N0 =< 12 andalso validate_draw(Draw);
        {"green", N0} ->
            N0 =< 13 andalso validate_draw(Draw);
        {"blue", N0} ->
            N0 =< 14 andalso validate_draw(Draw);
        _ ->
            false
    end.

get_max_cubes([]) ->
    #{};
get_max_cubes([Draw | Draws]) ->
    lists:foldl(
        fun(D, Acc) ->
            [N, Color] = string:split(D, " "),
            N0 = erlang:list_to_integer(N),
            maps:update_with(Color, fun(V) -> erlang:max(V, N0) end, N0, Acc)
        end,
        get_max_cubes(Draws),
        Draw
    ).
