def exp(num, pow)
  return 1 if pow == 0
  num * exp(num, pow - 1)
end

def exp2(num, pow)
  return 1 if pow == 0
  return num if pow == 1

  if num.even?
    exp2(num, pow / 2) ** 2
  else
    num * (exp2(num, (pow - 1) /2) ** 2)
  end
end


p exp2(3,3)
