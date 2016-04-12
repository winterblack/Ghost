class Player
  attr_reader :losses

  def initialize(name)
    @name = name
    @losses = 0
  end

  def lose_round
    @losses += 1
  end

  def to_s
    "#{@name}"
  end

  def ghost
    "GHOST".slice(0, @losses)
  end

end
