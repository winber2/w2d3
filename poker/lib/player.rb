class Player
  attr_accessor :name, :bankroll, :total_bets, :hand, :active

  def initialize(name)
    @hand = Hand.new
    @name = name
    @bankroll = 10000
    @total_bets = 0
    @active = true
  end

  def bet_raise(amount)
    raise("Insufficient funds") if amount > bankroll
    @total_bets += amount

  end

  def make_move
    puts "Please choose an action: raise or fold"
    action = gets.chomp
    if action == "raise"
      begin
        puts "Please enter an amount"
        amount = gets.to_i
        bet_raise(amount)
      rescue
        retry
      end
    elsif action == "fold"
      self.fold
    end
    amount ||= 0
  end

  def fold
    @total_bets = 0
    @active = false
  end

  def take_pot(amount)
    @bankroll += amount
  end


end
