#задание 3
f_value = 0
fibonacci = [0, 1]
while f_value <= 100
  f_value = fibonacci[-1] + fibonacci[-2]
  break if f_value > 100
  fibonacci << f_value
end

puts fibonacci
