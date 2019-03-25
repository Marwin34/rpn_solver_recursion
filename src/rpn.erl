%%%-------------------------------------------------------------------
%%% @author Marcin
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. Mar 2019 3:21 PM
%%%-------------------------------------------------------------------
-module(rpn).
-author("Marcin").

%% API
-export([rpn/1]).

% Wrapper for rpn solving functions.
rpn(Input) ->
  solve(string:tokens(Input, " "), []).

% Recursive decisions what to do with input and stack.
solve([], []) ->
  0;
solve([Operand | Operands], Stack) ->
  solve(Operands, action(Operand, Stack));
solve([], [Stack]) ->
  Stack.

% Defined arithmetic operations (simply pop necessary values from stack and then push result back on stack).
action("+", [O1, O2 | Stack]) ->
  [O1 + O2 | Stack];
action("-", [O1, O2 | Stack]) ->
  [O2 - O1 | Stack];
action("*", [O1, O2 | Stack]) ->
  [O1 * O2 | Stack];
action("/", [O1, O2 | Stack]) ->
  [O2 / O1 | Stack];
action("^", [O1, O2 | Stack]) ->
  [math:pow(O2, O1) | Stack];
action("ln", [O1 | Stack]) ->
  [math:log(O1) | Stack];
action("log10", [O1 | Stack]) ->
  [math:log10(O1) | Stack];
action("tan", [O1 | Stack]) ->
  [math:tan(O1) | Stack];
action("ctan", [O1 | Stack]) ->
  [1 / math:tan(O1) | Stack];
action("cos", [O1 | Stack]) ->
  [math:cos(O1) | Stack];
action("sin", [O1 | Stack]) ->
  [math:sin(O1) | Stack];
action("acos", [O1 | Stack]) ->
  [math:acos(O1) | Stack];
action("asin", [O1 | Stack]) ->
  [math:asin(O1) | Stack];
action("sqrt", [O1 | Stack]) ->
  [math:sqrt(O1) | Stack];

% If operand isn't specified above, we assume it is a Number and we attempt to parse it.
action(Operand, Stack) ->
  case (catch(list_to_float(Operand))) of
    {'EXIT', _} -> case (catch(list_to_integer(Operand))) of
                     {'EXIT', _} -> exit("Bledne dane.");
                     Integer_value -> [Integer_value | Stack]
                   end;
    Float_value -> [Float_value | Stack]
  end.
