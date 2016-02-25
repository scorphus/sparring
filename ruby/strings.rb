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

Cardboard hacker pre-cyber- free-market artisanal corrupted systema plastic
stimulate chrome rain. Sunglasses convenience store into disposable stimulate
youtube network. Modem dead human skyscraper industrial grade dome rifle
paranoid uplink narrative. Meta-systemic nano-city sentient dome smart- sub-
orbital kanji convenience store realism math- otaku cardboard table vinyl
Kowloon. Paranoid j-pop voodoo god camera rebar tanto bomb. Advert tiger-team
corporation shoes bomb disposable modem face forwards neon narrative drugs
range-rover woman.}

puts multi_line
