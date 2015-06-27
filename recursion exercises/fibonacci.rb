def fibonacci(num)
  return [] if num.zero?
  return [0] if num == 1
  return [0, 1] if num == 2

  fibs = fibonacci(num - 1)
  fibs << (fibs[-2] + fibs[-1])

end

if __FILE__ == $PROGRAM_NAME
  p fibonacci(5)
end
