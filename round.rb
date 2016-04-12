require "set"

class Round

  DICTIONARY = Set.new(File.readlines("dictionary.txt").map(&:chomp))

  def initialize(players)
    @players = players
    @fragment = ""
    play_round
  end

  def play_round
    until fragment_is_word
      add_letter
      @players.rotate!

      @players = nil
    end
    round_end
  end

  private
  def add_letter
    new_fragment = ""
    until valid_fragment?(new_fragment)
      turn_prompt
      letter = gets.chomp
      new_fragment = @fragment + letter
    end
    @fragment = new_fragment
  end

  def valid_fragment?(fragment)
    valid_length?(fragment) && valid_start?(fragment)
  end

  def valid_start?(fragment)
    DICTIONARY.any? {|word| word.start_with?(fragment)}
  end

  def valid_length?(fragment)
    fragment.length == @fragment.length + 1
  end

  def fragment_is_word
    DICTIONARY.include?(@fragment)
  end

  def current_player
    @players.first
  end

  def previous_player
    @players.last
  end

  def turn_prompt
    puts "It's your turn #{current_player}."
    puts "The word-fragment is #{@fragment}." if @fragment.length > 0
    puts "Enter a letter:"
  end

  def round_end
    previous_player.lose_round
    puts "The word is #{@fragment}. #{previous_player} loses this round."
  end

end
