#задание 5
print "Определить порядковый номер даты в году \n"
puts "Введите год"
year = gets.chomp.to_i
puts "Введите месяц"
month = gets.chomp.to_i
puts "Введите число"
day = gets.chomp.to_i

#количество дней в месяце
month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
#определяем високосный год
month_days[1] = 29 if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
sum_month_day = 0
month_days[0..month - 2].each { |month_day| sum_month_day += month_day }

puts "date_number: #{sum_month_day + day}"

