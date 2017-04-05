class Deck
  attr_accessor :cards

  def self.random

  def initialize
    @cards =
  end






class Card
  VALUES = (1..13).to_a
  SUITS = [:spades,:hearts,:clubs,:diamonds]

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def

end
