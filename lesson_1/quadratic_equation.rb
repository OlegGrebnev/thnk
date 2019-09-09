puts "Введите коэффициенты квадратного уравнения ax**2 + bx + c = 0"
arr = Array.new
print "a: "
arr[0] = gets.chomp.to_f
print "b: "
arr[1] = gets.chomp.to_f
print "c: "
arr[2] = gets.chomp.to_f
#вычисляем дискриминант
discr = arr[1] ** 2 - 4 * arr[0] * arr[2]
#вычисляем корни уравнения
if discr > 0
  puts "D = #{arr[1] ** 2 - 4 * arr[0] * arr[2]}, x1 = #{((-1)*arr[1] + Math.sqrt(discr)) / (2 * arr[0])}, x2 = #{(-arr[1] - Math.sqrt(discr)) / (2 * arr[0])}"
elsif discr == 0
  puts "D = #{arr[1] ** 2 - 4 * arr[0] * arr[2]}, x1 = x2 = #{(-1)*arr[1] / (2 * arr[0])}"
else
  puts "Корней нет"
end
