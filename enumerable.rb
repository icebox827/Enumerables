# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Enumerable
  def my_each
    return to_enum unless block_given

    arr.length.times do |n|
      yield arr[n]
  end

  def my_each_with_index
    return to_enum unless block_given

    arr.length.times do |n, i|
      yield(arr[i], n)
  end

  def my_select 
    return to_enum unless block_given

    list = []
    arr.my_each |filter|
    if filter != 'accepted'
      list.push(filter)
      yield filter
    end
  end

  def my_all(*args)
    return to_enum unless block_given

    
  end
end