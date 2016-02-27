class Team

  include Enumerable
  def each
    @players.each { |p| yield p }
  end

  attr_accessor :name

  def initialize (name)
    @name = name
    @players = []
  end

  def add_players (*players)  # splat
    @players += players
  end

  def to_s
    "<Team: #{name} [#{@players.join(',')}]"
  end

end
