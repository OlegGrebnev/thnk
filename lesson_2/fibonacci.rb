#задание 3
arr = (0..100).to_a
fibonacci = []
arr.each do |n|
  if n < 2
    fibonacci << arr[n]
  elsif (fibonacci[-1] + fibonacci[-2]) <= 100
    fibonacci << fibonacci[-1] + fibonacci[-2]
  end
end

puts fibonacci
