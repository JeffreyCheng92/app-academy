def subsets(arr)
  return [ [] ] if arr.length.zero?
  temp = arr.first
  results = subsets(arr[1..-1])
  results + results.map {|result| result + [temp]}
end



if __FILE__ == $PROGRAM_NAME
  p subsets([1,2,3])
end
