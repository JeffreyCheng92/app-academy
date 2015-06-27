def deep_dup(array)

  return array.dup if array.all? {|x| x.class != Array}

  new_array = array.map { |x| x.is_a?(Array) ? deep_dup(x) : x }

end

if __FILE__ == $PROGRAM_NAME
  robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]

  robot_parts_clone = deep_dup(robot_parts)
  p robot_parts_clone

  robot_parts_clone[1] << "LEDS"
  p robot_parts
  p robot_parts_clone
end
