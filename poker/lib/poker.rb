class Game
  attr_reader :deck, :players, :pot, :current_player, :ante

  def initialize(ante = 100, *players)
    @ante = ante
    @deck = Deck.new
    @players = players
    @current_player = players.first
    @pot = 0
  end


  def play
    until winner?
      until round_over?
      setup
      play_turn
      c

    end
  end


  def setup

  end

  def round_over?

  end



end
