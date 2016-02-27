class Book

  def initialize (title, author, pages, rating=nil)
    @title = title
    @author = author
    @pages = pages
    @rating = rating
  end

  def rating
    @rating
  end

  def rating=(rating)
    @rating = rating
  end

  def get_info
    @state = 'searched'
    "#{@title} by #{@author}, #{@pages} pages#{@rating != nil ? ", #{@rating} stars" : ''}"
  end

end

book = Book.new('Blood Meridian', 'Cormac McCarthy', 337)
p book.instance_variables
puts book.get_info
p book.instance_variables

p book.rating
book.rating = 4.19
puts book.get_info


class BetterBook

  attr_accessor :title, :author, :pages, :rating

  def get_info
    @state = 'searched'
    "#{@title} by #{@author}, #{@pages} pages#{@rating != nil ? ", #{@rating} stars" : ''}"
  end

end

book = BetterBook.new
p book.title
book.title = 'Blood Meridian, or the Evening Redness in the West'
puts book.title

book.author = 'Cormac McCarthy'
book.pages = 337
book.rating = 10
puts book.get_info


class EvenBetterBook

  attr_accessor :title, :author, :pages
  attr_reader :rating

  def initialize (title, author, pages, rating)
    @title = title
    @author = author
    @pages = pages
    self.rating = rating  # self.rating is created by attr_reader above ;-)
  end

  def rating=(rating)
    @rating = rating unless rating > 5
  end

  def get_info
    @state = 'searched'
    "#{@title} by #{@author}, #{@pages} pages#{@rating != nil ? ", #{@rating} stars" : ''}"
  end

end

book = EvenBetterBook.new('Blood Meridian', 'Cormac McCarthy', 337, 4.19)
puts book.get_info

book.title = 'Blood Meridian, or the Evening Redness in the West'
book.rating = 4.99
book.rating = 10
puts book.get_info


class BetterYetBook

  attr_accessor :title, :author, :pages
  attr_reader :rating

  def initialize (title, author, pages, rating=nil)
    @title = title
    @author = author
    @pages = pages
    self.rating = rating  # self.rating is created by attr_reader above ;-)
  end

  def rating=(rating)
    rating ||= 0
    @rating = rating unless rating > 5
  end

  def get_info
    @state = 'searched'
    "#{@title} by #{@author}, #{@pages} pages#{@rating > 0 ? ", #{@rating} stars" : ''}"
  end

end

book = BetterYetBook.new('Blood Meridian', 'Cormac McCarthy', 337)
puts book.get_info
book.rating = 4.98
puts book.get_info


class Multiplier

  class << self
    def call_count
      @@call_count ||= 0
      @@call_count += 1
    end
  end

  def self.double(x)
    call_count
    x * 2
  end

end

def Multiplier.triple(x)
  call_count
  x * 3
end

puts Multiplier.double(2)
puts Multiplier.double 3
puts Multiplier.triple 4
puts Multiplier.call_count
puts Multiplier.call_count
