set crabs (string split , < day-07.txt | sort -n)
set n (count $crabs)

set median $crabs[(math "ceil($n / 2)")]
for crab in $crabs
  echo (math "abs($crab - $median)")
end | string join + | math

for op in {"floor", "ceil"}
  set mean_crab (math "$op(("(string join "+" $crabs)") / $n)")
  set total_fuel 0
  for crab in $crabs
    set fuel (math "abs($crab - $mean_crab)")
    set total_fuel (math "$total_fuel + ($fuel + 1) * $fuel / 2")
  end
  echo $total_fuel
end | read -L total_fuel_floor total_fuel_ceil

test $total_fuel_floor -le $total_fuel_ceil
  and echo $total_fuel_floor
  or echo $total_fuel_ceil
