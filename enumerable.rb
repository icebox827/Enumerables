# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = to_a
    arr.length.times do |n|
      yield (arr[n])
      self
    end
    arr
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    arr = to_a
    counter = 0
    while counter < arr.length
      yield(arr[counter], counter)
      counter += 1
    end
    arr
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    list = []

    arr.my_each | filter |
      if filter != 'accepted'
        list.push(filter)
        yield filter
      end
  end

  def my_all?(args = nil)
    if block_given?
      my_each { |element| return false if yield(element) == false }
      return true
    elsif arg.nil?
      my_each { |element| return false if n.nil? || element == false }
    elsif !arg.nil? && (arg.is_a? Class)
      my_each { |element| return false if element.class != args }
    elsif !arg.nil? && arg.instance_of?(Regexp)
      my_each { |element| return false unless arg.match(element) }
    else
      my_each { |element| return false if element != args }
    end
    true
  end

  def my_any?(args = nil)
    if block_given?
      my_each { |element| return true if yield(element) }
      false
    elsif arg.nil?
      my_each { |element| return true if n.nil? || element == true }
    elsif !arg.nil? && (arg.is_a? Class)
      my_each { |element| return true if element.instance_of?(args) }
    elsif !arg.nil? && arg.instance_of?(Regexp)
      my_each { |element| return true if arg.match(element) }
    else
      my_each { |element| return true if element == args }
    end
    false
  end

  def my_none(*args)
    return to_enum unless block_given?

    speech = true

    if !block_given?
      my_each { |argument| speech = false if yield argument }
    elsif !args[0].nil?
      my_each { |argument| speech = false unless args[0] == argument }
    else
      my_each { |argument| speech = false unless argument }
    end
  end

  def my_count(num)
    return to_enum unless block_given?

    count = 0

    my_each { |i| count += 1 if num == i }
    count
  end

  def my_map(proc_ = nil)
    return to_enum unless block_given?

    list_arr = []

    if proc_.nil?
      my_each { |element| list_arr.push(yield(element)) }
    else
      my_each { |element| list_arr.push(proc_.call(element)) }
    end
    list_arr
  end

  def my_inject(acc = 0)
    return to_enum unless block_given?

    my_each { acc = yield(acc, i) }
    acc
  end

  def multiply_els(arr)
    arr.my_inject(:*)
  end
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
