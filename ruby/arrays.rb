an_array = [1, 'foo', :bar]
p an_array[1]

words = %w{let us talk about ruby}
p words
puts words[-1]
puts "#{words.last}#{words.first}"
p words[-3, 2]
p words[2..4]
puts words.join(' ')

words << 'again'
puts words.join(' ')

words.push('and')
words.push 'again'
puts words.join ' '

words.pop
puts words.join ' '

words.shift
puts words.join ' '

words.unshift 'have'
puts words.join ' '

words[-1] = 'alright'
puts words.join ' '

p words.sample
p words.sample 2

words.sort!
p words

words.reverse!
p words

seq = [5, 7, 4, 3, 6]
seq.sort!.reverse!
seq[6] = 1
p seq

seq.each { |n| print n }
puts

seq[5] = 2
new_seq = seq.select { |n| n > 4 }
p new_seq

new_seq = seq.select { |n| n < 4 }.reject { |n| n.even? }
p new_seq

squares = seq.map { |n| n * n }
p squares
