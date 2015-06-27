def bsearch(arr, num)
  mid = arr.size/2

  return nil if arr.empty?
  # return arr.index_of(num) if arr.size == 1 && arr.include?(num)
  pointer = arr[mid]
  left = arr[0...mid]
  right = arr[mid + 1 .. -1]

  if pointer == num
    mid
  elsif num < pointer
    bsearch(left, num)
  else
    temp = bsearch(right, num)
    return nil if temp.nil?
    mid + 1 + temp
  end
end

if __FILE__ == $PROGRAM_NAME
puts bsearch([1, 2, 3], 1) # => 0
puts bsearch([2, 3, 4, 5], 3) # => 1
puts bsearch([2, 4, 6, 8, 10], 6) # => 2
puts bsearch([1, 3, 4, 5, 9], 5) # => 3
puts bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
end
