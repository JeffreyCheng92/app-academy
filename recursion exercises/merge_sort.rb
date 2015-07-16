def merge_sort(arr)
  return arr if arr.size <= 1
  mid = arr.size/2
  left = arr[0...mid]
  right = arr[mid..-1]

  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  results = []

  until left.length == 0 || right.length == 0
    if left[0] <= right[0]
      results << left.shift
    else
      results << right.shift
    end
  end
  results + left + right

end

if __FILE__ == $PROGRAM_NAME
  a = (0..10).to_a.shuffle
  #p a
  p merge_sort(a)
end
