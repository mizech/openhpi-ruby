module MethodForward
   
    def forward(method_name, to:)
        p method(to).owner
        # p self.respond_to?(:secret)
        # p self.instance_methods.include?(to)
  
        if self.respond_to?(method_name) == true
          raise ArgumentError.new("Method already exists.")
        end
        
        # if respond_to?(to) == false
        #   raise ArgumentError.new("Method does not exist.")
        # end
      
        # define_method("#{method_name}") { |args|
        #   send(to)
        #  }
    end
end
