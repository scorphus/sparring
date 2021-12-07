function get_most_common_bit -a i crit
  set c (for line in $argv[3..-1]
    echo -n $line | cut -c$i | grep $crit
  end | wc -l)
  if test $crit = 1
    test $c -ge (math (count $argv) - $c - 2); and echo 1; or echo 0
  else
    test $c -le (math (count $argv) - $c - 2); and echo 0; or echo 1
  end
end

function determine_rating -a crit
  set numbers $argv[2..-1]
  for i in (seq (echo -n $numbers[1] | wc -c))
    set numbers_
    set c (get_most_common_bit $i $crit $numbers)
    for line in $numbers
      set d (string sub -s $i -l 1 $line)
      if test "$d" = "$c"
        set numbers_ $numbers_ $line
      end
    end
    set numbers $numbers_
    if test (count $numbers) -eq 1
      break
    end
  end
  echo $numbers
end

set oxygen (determine_rating 1 (cat day-03.txt))
set scrubber (determine_rating 0 (cat day-03.txt))
echo "ibase=2; $oxygen * $scrubber" | bc
