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

  def my_all?(*args)
    return to_enum unless block_given

    speech = true

    if !block_given?
      my_each{ |argument| speech = false unless argument }
    elsif !args[0].nil?
      my_each{ |argument| speech = false unless args[0] === argument }
    else 
      my_each{ |argument| speech = false unless yield argument }
    end
  end

  def my_any?(*args)
    return to_enum unless block_given
    
    speech = false

    if !block_given?
      my_each{ |argument| speech = true unless argument }
    elsif !args[0].nil?
      my_each{ |argument| speech = true unless args[0] === argument }
    else 
      my_each{ |argument| speech = true unless yield argument }
    end
  end 

  def my_none(*args)
    return to_enum unless block_given

    speech = true

    if !block_given?
      my_each{ |argument| speech = false if yield argument }
    elsif !args[0].nil?
      my_each{ |argument| speech = false unless args[0] === argument }
    else 
      my_each{ |argument| speech = false unless argument }
    end    
  end

  def my_count(num )
    return to_enum unless block_given

    counter = 0

    self.my_each { |i| counter += 1 if arg == i}
    counter
  end

  
end