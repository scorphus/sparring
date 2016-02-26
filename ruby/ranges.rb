digits = 0..9
puts digits.max
puts digits.include? 5

puts '= = = ='

puts digits === 5
puts digits == 5

puts '= = = ='

puts digits === 5.5
puts digits === 10
puts digits === "R"

p (1..20).to_a
p ('a'..'z').to_a

p (1...20).to_a
p ('a'...'z').to_a

digit = 20
case digit
  when 0..9 then puts "#{digit} has one digit"
  when 10..99 then puts "#{digit} has two digits"
  when 100..999 then puts "#{digit} has three digits"
  else puts "#{digit} has more than three digits"
end
