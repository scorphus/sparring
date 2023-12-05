#!/usr/bin/env escript

-export([main/1]).

-define(DELTAS, [
    {-1, 0},
    {-1, 1},
    {0, 1},
    {1, 1},
    {1, 0},
    {1, -1},
    {0, -1},
    {-1, -1}
]).

main(_) ->
    Lines = read_stdin(),
    Map = parse_lines_into_map(Lines),
    io:format("Part one: ~p~n", [part_one(Map)]),
    io:format("Part two: ~p~n", [part_two(Map)]).

read_stdin() ->
    case io:get_line("") of
        eof -> [];
        L -> [string:trim(L) | read_stdin()]
    end.

parse_lines_into_map(Lines) -> parse_lines_into_map(Lines, #{}, 0, 0).

parse_lines_into_map([], Map, _Ii, _Jj) ->
    Map;
parse_lines_into_map([Line | Lines], Map, Ii, Jj) ->
    parse_lines_into_map(Lines, parse_line_into_map(Line, Map, Ii, Jj), Ii + 1, 0).

parse_line_into_map([], Map, _Ii, _Jj) ->
    Map;
parse_line_into_map([Char | Line], Map, Ii, Jj) ->
    parse_line_into_map(Line, maps:put({Ii, Jj}, Char, Map), Ii, Jj + 1).

part_one(Map) ->
    S = round(math:sqrt(maps:size(Map))),
    {Nums, _Geared} = walk_map(Map, S - 1, S - 1, [], #{}, [], false, sets:new()),
    lists:foldl(fun(N, Acc) -> Acc + list_to_integer(N) end, 0, Nums).

part_two(Map) ->
    S = round(math:sqrt(maps:size(Map))),
    {_Nums, Geared} = walk_map(Map, S - 1, S - 1, [], #{}, [], false, sets:new()),
    lists:foldl(
        fun(L, Acc) ->
            lists:foldl(
                fun(L1, Acc1) -> list_to_integer(L1) * Acc1 end, 1, L
            ) + Acc
        end,
        0,
        lists:filter(fun(L) -> length(L) == 2 end, maps:values(Geared))
    ).

walk_map(_Map, -1, _Jj, Nums, Geared, Num, _IsPN, _Gears) when length(Num) == 0 ->
    {Nums, Geared};
walk_map(Map, Ii, Jj, Nums, Geared, Num, IsPN, Gears) when Jj =< 0 andalso length(Num) == 0 ->
    walk_map(Map, Ii - 1, round(math:sqrt(maps:size(Map))) - 1, Nums, Geared, Num, IsPN, Gears);
walk_map(Map, Ii, Jj, Nums, Geared, Num, IsPN, Gears) ->
    case maps:get({Ii, Jj}, Map, duh) of
        N when N >= $0 andalso N =< $9 ->
            Sym = find_symbols(Map, Ii, Jj, ?DELTAS),
            case length(Sym) of
                0 ->
                    walk_map(Map, Ii, Jj - 1, Nums, Geared, [N | Num], IsPN, Gears);
                _ ->
                    G1 = sets:union(
                        Gears,
                        sets:from_list(
                            lists:filtermap(
                                fun({P, S}) ->
                                    case S of
                                        $* -> {true, P};
                                        _ -> false
                                    end
                                end,
                                Sym
                            )
                        )
                    ),
                    walk_map(Map, Ii, Jj - 1, Nums, Geared, [N | Num], true, G1)
            end;
        _ ->
            {N1, G1} =
                case IsPN of
                    true ->
                        {
                            [Num | Nums],
                            sets:fold(
                                fun(Gear, Acc) ->
                                    maps:update_with(
                                        Gear,
                                        fun(L) -> [Num | L] end,
                                        [Num],
                                        Acc
                                    )
                                end,
                                Geared,
                                Gears
                            )
                        };
                    false ->
                        {Nums, Geared}
                end,
            walk_map(Map, Ii, Jj - 1, N1, G1, [], false, sets:new())
    end.

find_symbols(_Map, _Ii, _Jj, []) ->
    [];
find_symbols(Map, Ii, Jj, [{Di, Dj} | Deltas]) ->
    case maps:get({Ii + Di, Jj + Dj}, Map, duh) of
        C when C >= $0 andalso C =< $9 orelse C == $. orelse C == duh ->
            find_symbols(Map, Ii, Jj, Deltas);
        S ->
            [{{Ii + Di, Jj + Dj}, S} | find_symbols(Map, Ii, Jj, Deltas)]
    end.
