class Deck
  attr_accessor :cards

  def self.random
    all_cards =  []
    Card::VALUES.each do |val|
      Card::SUITS.each do |suit|
        deck << Card.new(suit,val)
      end
    end
    all_cards.shuffle
  end

  def initialize
    @cards = Deck.random
  end

end



class Card
  VALUES = (1..13).to_a
  SUITS = [:spades,:hearts,:clubs,:diamonds]

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def evaluate
    rank
    suit_freq = Hash.new(0)
    @cards.each {|card| suit_freq[card.suit] += 1}
    val_freq = Hash.new(0)
    @cards.each {|card| val_freq[card.val] += 1}

    if suit_freq.values.include?(5)
      rank = 5
    elsif

  end

end
