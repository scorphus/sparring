defmodule LeastCommonMultiple do
  def lcm(0, 0), do: 0
  def lcm(a, b), do: div(a * b, gcd(a, b))

  def gcd(a, 0), do: a
#   def gcd(0, b), do: b
  def gcd(a, b), do: gcd(b, rem(a, b))
end

LeastCommonMultiple.lcm(1, 2)
|> IO.inspect()

LeastCommonMultiple.gcd(1, 2)
|> IO.inspect()

LeastCommonMultiple.gcd(2, 0)
|> IO.inspect()

LeastCommonMultiple.gcd(0, 3)
|> IO.inspect()

LeastCommonMultiple.gcd(0, 0)
|> IO.inspect()
