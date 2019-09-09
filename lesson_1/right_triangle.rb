puts "Введите стороны треугольника ABC, м"
tr_sides = Array.new
print "A: "
tr_sides[0] = gets.chomp.to_f
print "B: "
tr_sides[1] = gets.chomp.to_f
print "C: "
tr_sides[2] = gets.chomp.to_f

tr_sides = tr_sides.sort { |s_min, s_max| s_max <=> s_min }

if tr_sides[0] ** 2 == tr_sides[1] ** 2 + tr_sides[2] ** 2
  puts "Прямоугольный треугольник"
elsif tr_sides[0] == tr_sides[1] && tr_sides[0] == tr_sides[2]
  puts "Равносторонний треугольник"
elsif tr_sides[0] == tr_sides[1] || tr_sides[0] == tr_sides[2] || tr_sides[1] == tr_sides[2]
  puts "Равнобедренный треугольник"
else
  puts "Треугольник"
end