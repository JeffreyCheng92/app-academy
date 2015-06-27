class Array
  def my_each(&blk)
    index = 0

    while index < length
      blk.call self[index]
      index += 1
    end

  end

  def my_map(&blk)
    index = 0
    mapped = []
    while index < length
      temp = blk.call self[index]
      mapped << temp
      index += 1
    end

    mapped
  end

  def my_select(&blk)
    index = 0
    selected = []
    while index < length
      selected << self[index] if blk.call self[index]
      index += 1
    end

    selected
  end

  def my_inject(&blk)
    index = 1
    accum = self.first
    while index < length
      accum = blk.call(accum, self[index])
      index += 1
    end

    accum
  end

  def my_sort!(&blk)
    sorted = false
    until sorted
      sorted = true
      self.each_index do |i|
        j = i + 1
        break if j >= self.length
        if blk.call(self[i], self[j]) ==  1
          self[i], self[j] = self[j], self[i]
          sorted = false
        end
      end
    end

    self
  end

  def my_sort(&blk)
    array = self.dup
    array.my_sort!(&blk)
  end

end

if __FILE__ == $PROGRAM_NAME
  a = (0..20).to_a.shuffle
  p a.my_sort { |a, b| a <=> b }
end
