require 'rspec'
require 'poker'

describe Card do
  subject(:card) { Card.new }
  let(:values) { (1..13).to_a }
  let(:suits) { [:spades, :diamonds, :hearts, :clubs] }

  describe '#initialize' do
    it 'initializes with value' do
      expect(values).to include(card.value)
    end

    it 'initializes with suit' do
      expect(suits).to include(card.suit)
    end

  end

end

describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do
    it 'starts with 52 cards' do
      expect(deck.cards.count).to eq(52)
    end
    it 'contains 13 cards of each suit' do
      suit_freq = Hash.new(0)
      deck.cards.each { |card| suit_freq[card.suit] += 1}
      expect(suit_freq.values.all? {|x| x == 13}).to be(true)
    end
    it 'contains 4 cards of each value' do
      val_freq = Hash.new(0)
      deck.cards.each { |card| suit_freq[card.value] += 1}
      expect(val_freq.values.all? {|x| x == 4}).to be(true)
    end

  end
end

describe Hand do
  subject(:new_hand) { Hand.new }

  let(:straight_flush) { Hand.new.cards = [Card.new(:spades, 1), Card.new(:spades, 2), Card.new(:spades, 3), Card.new(:spades, 4), Card.new(:spades, 5)]}
  let(:four_of_a_kind) { Hand.new.cards = [Card.new(:spades, 1), Card.new(:hearts, 1), Card.new(:diamonds, 1), Card.new(:clubs, 1), Card.new(:spades, 5)]}
  let(:full_house) { Hand.new.cards = [Card.new(:spades, 3), Card.new(:hearts, 3), Card.new(:clubs, 3), Card.new(:spades, 11), Card.new(:diamonds, 11)]}
  let(:flush) { Hand.new.cards = [Card.new(:spades, 1), Card.new(:spades, 2), Card.new(:spades, 13), Card.new(:spades, 4), Card.new(:spades, 5)]}
  let(:straight) { Hand.new.cards = [Card.new(:spades, 1), Card.new(:diamonds, 2), Card.new(:spades, 3), Card.new(:spades, 4), Card.new(:clubs, 5)]}
  let(:three_of_a_kind) { Hand.new.cards = [Card.new(:spades, 1), Card.new(:hearts, 1), Card.new(:clubs, 1), Card.new(:spades, 4), Card.new(:spades, 5)]}
  let(:two_pair) { Hand.new.cards = [Card.new(:spades, 3), Card.new(:hearts, 3), Card.new(:spades, 2), Card.new(:hearts, 2), Card.new(:clubs, 5)]}
  let(:pair) { Hand.new.cards = [Card.new(:spades, 1), Card.new(:hearts, 1), Card.new(:spades, 3), Card.new(:spades, 4), Card.new(:spades, 5)]}
  let(:high_card1) { Hand.new.cards = [Card.new(:spades, 1), Card.new(:spades, 2), Card.new(:spades, 3), Card.new(:spades, 4), Card.new(:hearts, 12)]}
  let(:high_card2) { Hand.new.cards = [Card.new(:spades, 13), Card.new(:spades, 2), Card.new(:spades, 3), Card.new(:spades, 4), Card.new(:hearts, 11)]}

  describe '#initialize' do
    it 'intializes as an empty array' do
      expect(new_hand.cards).to be_empty
    end
  end

  describe '#draw' do

    before(:each) { new_hand.draw }
    it 'draws 5 cards' do
      expect(new_hand.cards.length).to eq(5)
    end
    it 'picks unique cards' do
      suit_val_combs = []
      new_hand.cards.each do |card|
        suit_val_combs << '#{card.value}#{card.suit}'
      end
      expect(suit_val_combs.uniq.length).to eq(5)
    end

  end

  describe '#evaluate' do

    it 'evaluates straight flush' do
      expect(straight_flush).to be(true)
    end
    it 'evaluates four of a kind' do
      expect(four_of_a_kind).to be(true)
    end
    it 'evaluates full house' do
      expect(full_house).to be(true)
    end
    it 'evaluates non-straight flush' do
      expect(flush).to be(true)
    end
    it 'evaluates straight' do
      expect(straight).to be(true)
    end
    it 'evaluates three of a kind' do
      expect(three_of_a_kind).to be(true)
    end
    it 'evaluates two pair' do
      expect(two_pair).to be(true)
    end
    it 'evaluates pair' do
      expect(pair).to be(true)
    end

    it 'evaluates high card' do
      expect(high_card1).to be(true)
    end
  end

  describe '#rank' do
    it 'assigns relative ranks between different hands' do
      expect(straight_flush.rank).to eq(8)
      expect(four_of_a_kind.rank).to eq(7)
      expect(full_house.rank).to eq(6)
      expect(flush.rank).to eq(5)
      expect(straight.rank).to eq(4)
      expect(three_of_a_kind.rank).to eq(3)
      expect(two_pair.rank).to eq(2)
      expect(pair.rank).to eq(1)
      expect(high_card1.rank).to eq(0)
    end
  end

  describe '#tiebreak' do
    it 'correctly breaks ties between hands' do
      expect(Hand.tiebreak(high_card1, high_card2)).to eq(1)
    end
  end

end

describe Player do
  subject(:player) { Player.new("Steve") }

  describe '#initialize' do
    it 'assigns a name' do
      expect(player.name).to eq("Steve")
    end
    it 'assigns bankroll' do
      expect(player.bankroll).to eq(10000)
    end
    it 'assigns player total bets' do
      expect(player.total_bets).to eq(0)
    end

  end

  describe '#bet_raise' do
    it 'correctly lowers bankroll' do
      player.bet_raise(2000)
      expect(player.bankroll).to eq(8000)
    end

    it 'acculumate previous bets' do
      player.bet_raise(2000)
      player.bet_raise(1000)
      expect(player.total_bets).to eq(3000)
    end

    it 'limits bet to bankroll' do
      expect {player.bet_raise(12000) }.to raise_error("Insufficient funds")
    end

  end

  describe '#fold' do
    it 'forfeits previous bets' do
      player.bet_raise(2000)
      player.fold
      expect(player.bankroll).to eq(8000)
      expect(player.total_bets).to eq(0)
    end
  end

  describe '#win_hand' do
    it 'correctly adds to bankroll' do
      player.win_hand(5000)
      expect(player.bankroll).to eq(15000)
    end
  end
end

describe Game do
  subject(:game) { Game.new }
  describe '#initialize' do
    it 'creates empty pot' do
      expect(game.pot).to eq(0)
    end

    it 'creates players' do
      expect(game.players.count).to_not eq(0)
    end

    it 'sets current player' do
      expect(game.current_player).to_not eq(nil)
    end

    it 'creates a deck' do
      expect(game.deck.count).to eq(52)
    end

  end

  describe '#setup' do
    let(:ante) { 100 }

    before(:each) { game.setup }

    it 'correctly requires ante' do
      expect(game.pot).to eq(game.players.count * 100)
    end

    it 'correctly gives 5 cards to each player' do
      expect(game.players.all? {|player| player.cards.length == 5} ).to be(true)
    end

    it 'shuffles deck' do
      d1 = game.deck
      game.setup
      d2 = game.deck
      expect(d1).to_not eq(d2)
    end
  end

  describe '#switch_player!' do
    it 'switches between players' do
      p1 = game.current_player
      game.switch_player!
      p2 = game.current_player
      expect(p1).to_not eq(p2)
    end
  end
end
