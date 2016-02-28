v1 = 'outside'

class Class

  p self

  def a_method
    # p v1  # BANG!
    v1 = 'inside'
    p v1
    p local_variables
    p self
  end

end

p v1

obj = Class.new
obj.a_method

p local_variables
p self


module SomeModule

  PI = 3.141592653589

  class SomeClass
    def circunference(r)
      2 * PI * r
    end
  end

end

p SomeModule::SomeClass.new.circunference(2)


module MyModule

  MyConstant = 'ModuleConstant'

  class MyClass
    puts MyConstant
    MyConstant = 'ClassConstant'
    puts MyConstant
  end

  puts MyConstant

end


class Book

  attr_accessor :title, :author, :pages

  def initialize(title, author, pages)
    @title = title
    @author = author
    @pages = pages
  end

end

books = [
  Book.new('Federacy Hostships', 'Linette Priolean', 370),
  Book.new('Vampire Artesian', 'Alexandra Ruuska', 353),
  Book.new('Extort Calvinist', 'Ariel Pesnell', 406),
  Book.new('The Sabbathkeeper Schedular', 'Ta Ito', 408),
  Book.new('Preaccommodating Graphics', 'Keva Cappel', 404),
]

total_pages = 0
books.each do |book|
  puts "Summing #{book.pages} for #{book.title}..."
  total_pages += book.pages
  puts "#{total_pages} and counting"
end

puts 'Done!'
puts "Number of books read: #{books.length}"
puts "Total pages read: #{total_pages}"


some_primes = [2, 3, 5, 7, 11, 13, 17, 19]
a_prime = 359
some_primes.each do |a_prime|
  another_prime = 4561
  puts "#{a_prime} is prime"
end

puts local_variables  # has no another_prime


divisor = 2
an_even_number = 2
some_primes.each do |a_prime; an_even_number|
  an_even_number ||= 10
  print "#{an_even_number} * #{a_prime} / #{divisor} = "
  print "#{an_even_number * a_prime / divisor}\n"
end
puts an_even_number
