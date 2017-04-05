class Player
  attr_reader :name, :bankroll, :total_bets

  def initialize(name)
    @name = name
    @bankroll = 10000
    @total_bets = 0
  end

  def bet_raise(amount)
    raise("Insufficient funds") if amount > bankroll
    @total_bets += amount

  end

  def get_input
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
  end



  def fold
    @total_bets = 0
  end



end
