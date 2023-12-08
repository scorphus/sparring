#!/usr/bin/env escript

-export([main/1]).

main(_) ->
    Lines = read_lines(),
    Cards = parse_lines_into_cards(Lines),
    io:format("Part one: ~p~n", [part_one(Cards)]),
    io:format("Part two: ~p~n", [part_two(Cards)]).

read_lines() ->
    case io:get_line("") of
        eof -> [];
        L -> [string:trim(L) | read_lines()]
    end.

parse_lines_into_cards(Lines) -> parse_lines_into_cards(Lines, []).

parse_lines_into_cards([], Cards) ->
    Cards;
parse_lines_into_cards([Line | Lines], Cards) ->
    parse_lines_into_cards(Lines, [parse_line_into_card(Line) | Cards]).

parse_line_into_card(Line) ->
    [_, L0] = string:split(string:replace(Line, "  ", " ", all), ": ", all),
    [Winning, Owned] = string:split(L0, " | ", all),
    [string:split(Winning, " ", all), string:split(Owned, " ", all)].

part_one(Cards) ->
    lists:foldl(
        fun(Card, Acc) ->
            Set = sets:intersection(lists:map(fun sets:from_list/1, Card)),
            trunc(math:pow(2, sets:size(Set) - 1)) + Acc
        end,
        0,
        Cards
    ).

part_two(Cards) ->
    Matches = lists:map(
        fun(Card) -> sets:size(sets:intersection(lists:map(fun sets:from_list/1, Card))) end,
        lists:reverse(Cards)
    ),
    explode(Matches, length(Matches)).

explode([], _) -> 0;
explode(_, 0) -> 0;
explode([Match | Matches], Length) -> 1 + explode(Matches, Length - 1) + explode(Matches, Match).
