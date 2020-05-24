module MethodForward
    def forward(method_name, to:)
        if self.respond_to?(method_name) == false
          raise ArgumentError.new("You messed up!")
        end
        
        if self.respond_to?(to) == false
          raise ArgumentError.new("You messed up!")
        end
      
        puts self.method(:method_name)
    end
end