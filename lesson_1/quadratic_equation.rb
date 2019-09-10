puts "Введите коэффициенты квадратного уравнения ax**2 + bx + c = 0"
print "a: "
a = gets.chomp.to_f
print "b: "
b = gets.chomp.to_f
print "c: "
c = gets.chomp.to_f
#вычисляем дискриминант
discr = b ** 2 - 4 * a * c
sqrt_discr = Math.sqrt(discr)
#вычисляем корни уравнения
if discr > 0
  puts "D = #{discr}"
  puts "x1 = #{((-1) * b + sqrt_discr) / (2 * a)}"
  puts "x2 = #{((-1) * b - sqrt_discr) / (2 * a)}"
elsif discr == 0
  puts "D = #{discr}"
  puts "x1 = x2 = #{(-1) * b / (2 * a)}"
else
  puts "Корней нет"
end
