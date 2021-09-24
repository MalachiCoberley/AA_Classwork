#phase 1
# def my_min(list)
#   list.each_with_index do |el1, i1|
#     return el1 if list.none? { |el2| el2 < el1 }
#   end
# end
#time complexity is O(n^2)

#phase 2
def my_min(list)
  min = list.first
  list.each do |el|
    min = el if el < min
  end
  min
end
#time complexity is O(n)

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min(list)

#phase 1
# def largest_contiguous_subsum(list)
#   subarrays = []
#   list.each.with_index do |el1, i|
#     list.each.with_index do |el2, j|
#       subarrays << list[i..j] if i <= j
#     end
#   end
#   subarrays.map(&:sum).max
# end

#phase 2
def largest_contiguous_subsum(list)
  # hash = Hash.new(0)
  # max_sum = 0
  # list.each_with_index do |el, i|
  #   hash[i] = el
  # end
  # hash.each do |idx, num|
  #   curr_sum = 0

  #   curr_sum += num if 

  # end

  max_sum = 0
  i = 0
  while i < list.size
    curr_sum = list[0..i].take(i).sum #take from front
    max_sum = curr_sum if curr_sum > max_sum

    curr_sum = list[i..-1].take(i).sum #take from front
    max_sum = curr_sum if curr_sum > max_sum

    curr_sum = list[0..i].drop(i).sum #drop from back
    max_sum = curr_sum if curr_sum > max_sum

    curr_sum = list[i..-1].drop(i).sum #drop from back
    max_sum = curr_sum if curr_sum > max_sum

    curr_sum = list[i..-i].take(i).sum #take from front
    max_sum = curr_sum if curr_sum > max_sum

    curr_sum = list[i..-i].drop(i).sum #drop from back
    max_sum = curr_sum if curr_sum > max_sum

    i += 1
  end
  max_sum
end

# list = [5, 3, -7, -3, 3, 4, 5, -8]
list = [2, 3, -6, 7, -6, 7]
p largest_contiguous_subsum(list)