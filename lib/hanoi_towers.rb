require 'byebug'

class Game
  attr_accessor :towers

  def initialize
    @towers = [[3,2,1],[],[]]
  end

  def play
    until won?
      begin
        render
        from_idx, to_idx = get_input
        move(from_idx, to_idx)
      rescue
        retry
      end
    end
    puts 'Congratulations, you win!'
  end

  def render
    p @towers
  end

  def won?
    @towers == [[],[3,2,1],[]] || @towers == [[],[],[3,2,1]]
  end

  def valid_move?(from_idx, to_idx)
    raise("Invalid") unless @towers[to_idx].empty? || @towers[from_idx].last < @towers[to_idx].last
    @towers[to_idx].empty? || @towers[from_idx].last < @towers[to_idx].last
  end

  def move(from_idx, to_idx)
    @towers[to_idx] << @towers[from_idx].pop if valid_move?(from_idx, to_idx)
  end

  def get_input
    puts "Pick a tower to take from: (0 - 2)"
    from_idx = gets.to_i
    puts "Pick a tower to place disk: (0 - 2)"
    to_idx = gets.to_i
    [from_idx, to_idx]
  end


end
