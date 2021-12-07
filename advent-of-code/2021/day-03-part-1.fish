set gamma ""
set lines (cat day-03.txt)
set bits (echo -n $lines[1] | wc -c)
for x in (seq $bits)
  set c (for line in $lines
    echo $line | cut -c$x | grep 1
  end | wc -l)
  if test $c -ge (math (count $lines) / 2)
    set gamma $gamma"1"
  else
    set gamma $gamma"0"
  end
end
echo "ibase=2; $gamma * ("(string repeat -n $bits 1)" - $gamma)" | bc
