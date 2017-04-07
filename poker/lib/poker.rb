class Game
  attr_reader :deck, :players, :pot, :current_player, :ante

  def initialize(ante = 100, *players)
    @ante = ante
    @players = players
    @current_player = players.first
    @pot = 0
    @deck = Deck.new
    @count = 0
  end


  def play
    until winner?
      setup
      until round_over?
        play_turn
        switch_player!
      end
      evaluate
      @pot, @counter = 0, 0
    end
  end


  def setup
    @deck = Deck.new
    @deck.cards.shuffle!
    @players.each do |player|
        player.hand.cards << @deck.pop(5)
        player.active = true
        player.bankroll -= @ante
        @pot += @ante
    end
  end

  def play_turn
    amount = @current_player.make_move
    @pot += amount
  end

  def evaluate
    # best = nil
    # arr.each()
  end

  def switch_player!
    prev_player = @players.first
    @players.rotate!
    until @players.first.active == true
      @players.rotate!
    end

    @current_player = @players.first
    if @current_player == prev_player
      @current_player.take_pot
      @pot = 0
    end
  end

  def round_over?
    @pot == 0
  end



end
