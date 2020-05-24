# 374174279‎ michael.zech@hotmail.de
require_relative "rmod.rb"

class Student < Human
    include VisitsUniversity
  end
  
  tina = Student.new
  tina.extend ReceivesHonorsDegree
  
  ancestors = tina.class.ancestors
  puts ancestors




