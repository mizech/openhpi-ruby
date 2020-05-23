class Car
    include Rmod

    FUEL = 50
    attr_accessor :vendor

    def initialize(vendor, model)
        @vendor = vendor
        @model = model
    end

    def print_info() 
        puts "#{@vendor} #{@model}"
    end
end