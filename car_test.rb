require_relative "./car"
require "minitest/autorun"

class CarTest < Minitest::Test
    def setup 
        @car = Car.new("Ford", "Fiesta")
    end

    def test_print_info
        assert_equal "Ford Fiesta", @car.print_info
    end
end