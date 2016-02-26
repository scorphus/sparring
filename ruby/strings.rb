sing_quoted = 'Yes, I\'m learning Ruby.'
doub_quoted = "And...\nI'm kinda liking it"
puts sing_quoted
puts doub_quoted

def multiply(a, b)
  "#{a} times #{b} equals #{a * b}"
end
puts multiply(3, 5)

multi_line = %Q{Some say it's very important to master the string API. In the
meantime, some Lorem Gibson will serve quite well:

Drugs singularity Legba realism network man long-chain hydrocarbons beef noodles
math-woman advert papier-mache. Bomb corrupted physical voodoo god hacker
computer vinyl. Physical office towards lights-ware systema wonton soup advert
nodality tube footage. Otaku fetishism drugs vehicle pen skyscraper 8-bit tube.
Boat receding shanty town cyber-market hotdog assassin dolphin katana assault
otaku tank-traps. Neural semiotics network RAF spook grenade dead. Bicycle
neural math-pen shrine silent city otaku BASE jump dolphin concrete sunglasses
dome construct girl motion uplink.}
puts multi_line

lang = ' ruby'
puts lang.lstrip.capitalize
p lang

puts lang.lstrip!.capitalize!
p lang

lang[0] = 'r'
puts lang

multi_line.lines do |line|
  line.sub! 's', 'S'
  puts "#{line.capitalize}"
end

p 'Ruby'.include? 'Ru'
p 'Ruby'.include? 'bu'
p 'Ruby'.include? ?y
p 'Ruby'.include? ?r
