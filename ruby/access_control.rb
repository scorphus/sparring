class Book

  def initialize (title, author, pages)
    @title = title
    @author = author
    self.pages = pages
    @rating_sum = 0.0
    @rating_count = 0.0
    # puts self.rating_count  # BANG!
    puts rating_count
  end

  private
    def pages=(pages)
      if pages < 5
        puts 'Invalid number of pages'
        # raise an exception
        return
      end
      @pages = pages
    end

    def rating_count
      if @rating_count <= 0
        1.0
      else
        @rating_count
      end
    end

  public
    def add_rating(rating)
      rating ||= @rating_sum / rating_count
      rating = 0 if rating < 0
      rating = 5 if rating > 5
      @rating_sum += rating
      @rating_count += 1
    end

    def rating()
      @rating_sum / rating_count
    end

    def pages()
      @pages
    end

end

book = Book.new('Blood Meridian', 'Cormac McCarthy', 337)
# book.pages = 5  # BANG!
puts book.pages()
puts book.rating

book.add_rating(4)
puts book.rating
book.add_rating(5)
puts book.rating
book.add_rating(4)
puts book.rating
book.add_rating(4)
puts book.rating
book.add_rating(4)
puts book.rating
# puts book.rating_count  # BANG!
# book.rating_sum = 15  # BANG!
