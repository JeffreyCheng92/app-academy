def eval_block(*args, &blk)
  return "NO BLOCK GIVEN!" if not block_given?
  p args
  blk.call(*args)
end

if __FILE__ == $PROGRAM_NAME
  puts eval_block(1,2,3,4,5) {|*args| args.inject(:+)}
  eval_block("Kerry", "Washington", 23) do |fname, lname, score|
    puts "#{lname}, #{fname} won #{score} votes."
  end
  puts eval_block(1, 2, 3)
end
