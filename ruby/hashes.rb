best_book_ever = {
  'title' => 'Blood Meridian',
  'long_title' => 'Blood Meridian, or the Evening Redness in the West',
  'author' => 'Cormac McCarthy',
  'pages' => 337,
  'genres' => [
    'Fiction', 'Western', 'Historical Fiction', 'Literature', 'Classics',
  ],
  'stars' => 4.19,
  'publication' => '1985-04-25',
}

puts "Best book ever is #{best_book_ever['title']} by #{best_book_ever['author']}"

best_book_ever['my_rating'] = 5

puts "I've rated #{best_book_ever['title']} #{best_book_ever['my_rating']} stars"

puts 'Let\'s recap:'
best_book_ever.each_pair { |key, val| puts "#{key}: #{val}" }

p best_book_ever['price']

letter_count = Hash.new(0)  # 0 here is the default
best_book_ever['long_title'].chars.each do |letter|
  letter_count[letter] += 1
end
('a'..'z').each { |letter| puts "#{letter}: #{letter_count[letter]}" }

blood_meridian_characters = {
  protagnist: 'The Kid',
  boss: 'John Glanton',
  badass: 'Judge Holden',
}
blood_meridian_characters[:priest] = 'Ben Tobin'
p blood_meridian_characters

def commit_atrocity (
    props = {actor: 'The Judge', action:'raped', victim: 'a girl'}
  )
  puts "#{props[:actor]} #{props[:action]} #{props[:victim]}"
end
commit_atrocity
commit_atrocity ({actor: 'The Judge', :action => 'scalped', victim: 'a young dark boy'})
commit_atrocity :actor => 'A Yuma Indian', :action => 'killed', :victim => 'Glanton'
commit_atrocity actor: 'The Judge', action: 'killed', victim: 'The Kid'

a_hash = {foo: 1, :bar => 2}
puts a_hash

# puts {foo: 1, :bar => 2}  # BANG!!!
puts ({foo: 1, :bar => 2})  # Nice!
puts foo: 1, :bar => 2  # Nicer!
