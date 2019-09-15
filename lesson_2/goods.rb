#задание 6
good_purchase = {}
i = 1
loop do
  puts "Введите Наименование товара #{i} (Введите СТОП для окончания ввода)"
  good_name = gets.chomp
  break if good_name == "СТОП"

  puts "Введите Стоимость за ед. товара и Кол-во товара ЧЕРЕЗ ЗАПЯТУЮ"
  good_attr = gets.chomp.split(",")
  good_price = good_attr[0].to_f
  good_amount = good_attr[1].to_f

  good_purchase[good_name] = {good_price: good_price, good_amount: good_amount, good_total: good_price * good_amount}
  i += 1
end
total_price = 0
good_purchase.each_value { |value| total_price += value[:good_total] }

puts good_purchase
puts "total_price: #{total_price}"
