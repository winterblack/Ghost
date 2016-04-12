require_relative "round.rb"
require_relative "player.rb"

class Game

  def initialize
    @players = []
    play_game
  end

  def get_players
    puts "Enter the name of a player or press enter to start."
    name = gets.chomp
    return if name == ""
    @players << Player.new(name)
    get_players
  end

  def play_game
    get_players
    until remaining_players.count == 1
      Round.new(remaining_players)
      @players.rotate!
      display_ghost
    end
    puts "#{winner} is the winner!"
  end

  def display_ghost
    @players.each do |player|
      puts "#{player}: #{player.ghost}"
    end
  end

  def remaining_players
    @players.select {|player| player.losses < 5}
  end

  def winner
    remaining_players.first
  end

end
