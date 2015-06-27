# def make_change(cash, coins)
#   return [] if cash == 0 || coins.empty?
#   number = cash / coins.first
#   cash = cash % coins.first
#   change = make_change( cash, coins.drop(1) )
#   number.times { change.unshift(coins.first) }
#
#   change
# end

# def make_change(cash, coins)
#   return [] if cash == 0
#   return [] if coins.empty?
#
#   cash -= coins.first unless coins.empty?
#
#   if cash < coins.first
#     change = make_change(cash, coins.select {|x| x <= cash} )
#   else
#     change = make_change(cash, coins)
#   end
#
#   change << coins.first
#
# end

def make_change(cash, coins)
  least_coins = nil
  # puts cash
  # p coins

  coins.each do |coin|
    return [] if cash == 0

    unless coin > cash
      new_cash = cash - coin
      change = make_change(new_cash, coins)

    # if cash < coin
    #   change = make_change(cash, [coin] )
    # else
    #   change = make_change(cash, [coin] )
    # end

      change << coin
      least_coins ||= change
      least_coins = change if change.length < least_coins.length
    end
  end

  least_coins
end
if __FILE__ == $PROGRAM_NAME
  # p make_change(21, [10,7,1])
  p make_change(14, [10, 7, 1])
end
