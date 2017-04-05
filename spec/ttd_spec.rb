require 'rspec'
require 'ttd'

describe '#remove_dups' do
  it 'returns empty array when input is empty' do
    expect(remove_dups([])).to be_empty
  end

  it 'finds unique values' do
    expect(remove_dups([1,2,2,3,3,4])).to eq([1,2,3,4])
  end

  it 'returns in the order of appearance' do
    expect(remove_dups([2,2,1,1,3,4,4,4])).to eq([2,1,3,4])
  end

end

describe '#two_sum' do
  it 'finds one index pair that sums to zero' do
    expect(two_sum([-3,1,3,2])).to eq([[0,2]])
  end

  it 'returns multiple index pairs that sum to zero' do
    expect(two_sum([-5,1,5,2,-1]).sort).to eq([[0,2],[1,4]].sort)
  end

  it 'returns results dictionary-wise' do
    expect(two_sum([-5,1,5,2,-1])).to eq([[0,2],[1,4]])
  end

  it 'returns empty array when input is empty' do
    expect(two_sum([])).to eq([])
  end
  it 'returns empty array when no pairs sum to zero' do
    expect(two_sum([1,2,3,4])).to eq([])
  end
  it 'doesn\'t return same index mutliple times' do
    expect(two_sum([0,3,5])).to eq([])
  end
  it 'works with zeroes' do
    expect(two_sum([0,2,0,5])).to eq([[0,2]])
  end
end

describe '#my_transpose' do
  it 'returns empty array when input is empty' do
    expect(my_transpose([])).to eq([])
  end

  it 'works with matrix of empty rows' do
    expect(my_transpose([[],[],[]])).to eq([])
  end


  it 'works with square matricess' do
    expect(my_transpose([[1,2,3],[4,5,6],[7,8,9]])).to eq([[1,4,7],[2,5,8],[3,6,9]])
  end

  it 'works with rectangular matrices' do
    expect(my_transpose([[1,2,3],[4,5,6]])).to eq([[1,4],[2,5],[3,6]])
  end
end

describe '#stock_picker' do
  it 'returns empty array when elements are the same' do
    expect(stock_picker([1,1,1,1,1])).to eq([])
  end

  it 'returns empty array when input is empty' do
    expect(stock_picker([])).to eq([])
  end

  it 'finds max and min indices' do
    expect(stock_picker([1,3,5,7,9]).sort).to eq([0,4])
  end

  it 'finds them in the correct order' do
    expect(stock_picker([9,4,1,7,2])).to eq([2,3])
  end
end
