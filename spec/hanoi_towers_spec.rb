require 'rspec'
require 'hanoi_towers'

describe 'Hanoi towers' do
  subject(:game) { Game.new }

  describe '#initialize' do
    it 'initiates an array of three subarrays' do
      expect(game.towers.count).to eq(3)
    end

    it 'initiates disks in one subarray' do
      expect(game.towers).to eq([[3,2,1],[],[]])
    end

  end

  describe '#move' do
    before(:each) { game.towers = [[3,1],[2],[]] }

    it 'allows you to move disk to empty towers' do
      game.move(1,2)
      expect(game.towers).to eq([[3,1],[],[2]])
    end

    it 'prevents you from moving disk to a tower with a smaller disk' do
      expect {game.move(1,0)}.to raise_error("Invalid")
    end


  end

  describe '#won?' do
    let(:beginning_game) { Game.new }
    let(:finished_game) { g1 = Game.new ; g1.towers = [[],[],[3,2,1]]; g1}
    let(:mid_game) { g1 = Game.new ; g1.towers = [[],[1],[3,2]]; g1}

    it 'returns false if all disks are in the starting tower' do
      expect(beginning_game.won?).to be(false)
    end
    it 'returns true if all disks are in one tower' do
      expect(finished_game.won?).to be(true)
    end
    it 'returns false until the game is done' do
      expect(mid_game.won?).to be(false)
    end
  end






end
