require_relative "./main"

class MyClass
    extend MethodForward
  
    forward :geheimnis, to: :secret
    
    def secret
      "very secret"
    end
  end
  
  # MyClass.new.geheimnis # => "very secret"
  MyClass.new
  