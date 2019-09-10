puts "Введите стороны треугольника ABC, м"
tr_sides = []
print "A: "
tr_sides[0] = gets.chomp.to_f
print "B: "
tr_sides[1] = gets.chomp.to_f
print "C: "
tr_sides[2] = gets.chomp.to_f

a, b, c = tr_sides.sort #{ |s_min, s_max| s_max <=> s_min } я тут хотел отсортировать DESC, но можно и без этого. Спасибо!

if c ** 2 == a ** 2 + b ** 2
  puts "Прямоугольный треугольник"
elsif a == b && a == c
  puts "Равносторонний треугольник"
elsif a == b || a == c || b == c
  puts "Равнобедренный треугольник"
else
  puts "Треугольник"
end
