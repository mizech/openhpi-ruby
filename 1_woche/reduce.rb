def reduce(list, acc) 
    list.each { |item| acc = yield(acc, item) }

    acc
end

list = [1, 2, 3, 4]
puts reduce([1, 2, 3, 4], 0) { |sum, element| sum + element }