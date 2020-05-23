# Implementiere die Methode #gruppiere, so dass sie auf Arrays, Reihen usw. aufgerufen werden kann.
module Enumerable
    def gruppiere()
        ret = {}
        
        self.each { |item| 
            key = yield item
            
            if ret[key] == nil
                tmp = []
                tmp << item
                ret[key] = tmp
            else
                ret[key] << item
            end
        }

        ret
    end
end

puts [1, 2, 3, 4].gruppiere { |i| i % 2 == 0 } # Result: {false=>[1, 3], true=>[2, 4]}