#!/usr/bin/env escript

-export([main/1]).

-define(SPELLING, [
    {1, "one"},
    {2, "two"},
    {3, "three"},
    {4, "four"},
    {5, "five"},
    {6, "six"},
    {7, "seven"},
    {8, "eight"},
    {9, "nine"}
]).

main(_) ->
    Words = read_stdin(),
    io:format("Part one: ~p~n", [part_one(Words)]),
    io:format("Part two: ~p~n", [part_two(Words)]).

read_stdin() ->
    case io:fread("", "~s") of
        eof ->
            [];
        {ok, [L]} ->
            L0 = string:strip(L, right, $,),
            [L0 | read_stdin()]
    end.

part_one(Words) ->
    lists:foldl(fun(W, Acc) -> calibration_value(W, 0, 0, false) + Acc end, 0, Words).

part_two(Words) ->
    lists:foldl(fun(W, Acc) -> calibration_value(W, 0, 0, true) + Acc end, 0, Words).

calibration_value([], V1, V2, _Spell) ->
    V1 + V2;
calibration_value([H | W], V1, _V2, Spell) when H >= $1, H =< $9 ->
    N = list_to_integer([H]),
    case V1 of
        0 -> calibration_value(W, N * 10, N, Spell);
        _ -> calibration_value(W, V1, N, Spell)
    end;
calibration_value([_H | W], V1, V2, false) ->
    calibration_value(W, V1, V2, false);
calibration_value([H | W], V1, V2, true) ->
    case find_prefix([H | W], ?SPELLING) of
        {ok, N} ->
            case V1 of
                0 -> calibration_value(W, N * 10, N, true);
                _ -> calibration_value(W, V1, N, true)
            end;
        _ ->
            calibration_value(W, V1, V2, true)
    end.

find_prefix(_Word, []) ->
    {error, no_prefix};
find_prefix(Word, [{N, Prefix} | Spelling]) ->
    case lists:prefix(Prefix, Word) of
        true ->
            {ok, N};
        false ->
            find_prefix(Word, Spelling)
    end.
