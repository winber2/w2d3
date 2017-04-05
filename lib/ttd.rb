def remove_dups(arr)
  result = []
  arr.each do |el|
    result << el unless result.include?(el)
  end
  result
end

def two_sum(arr)
  result = []
  (0...arr.length).each do |i|
    (i + 1...arr.length).each do |j|
      result << [i,j] if arr[i] + arr[j] == 0
    end
  end
  result
end

def my_transpose(arr)
  return [] if arr.empty?
  row_count = arr.length
  col_count = arr.first.length
  result = Array.new(col_count) {Array.new(row_count)}
  (0...row_count).each do |i|
    (0...col_count).each do |j|
      result[j][i] = arr[i][j]
    end
  end
  result
end

def stock_picker(prices)
  return [] if prices.all? {|x| x == prices.first}
  result = []
  (0...prices.length).each do |i|
    (i + 1...prices.length).each do |j|
      if result.empty? || prices[j] - prices[i] > prices[result[1]] - prices[result[0]]
        result = [i,j]
      end
    end
  end
  result
end
