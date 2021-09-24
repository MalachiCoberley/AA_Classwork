def my_min(list)
  min = list.first
  list.each_with_index do |el1, i1|
    list.each_with_index do |el2, i2|
      
    end
  end
  min
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
p my_min(list)

# min = el1 if list.all? { |el2, i2| el1 < el2 && i1 != i2 }