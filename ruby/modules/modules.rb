module SampleModuleA
  class SampleClass
    attr_accessor :some_attr
  end
end

module SampleModuleB
  class SampleClass
    attr_accessor :another_attr
  end
end

foo = SampleModuleA::SampleClass.new  # works like a namespace thing
bar = SampleModuleB::SampleClass.new  # works like a namespace thing

foo.some_attr = 359
bar.another_attr = "359"

p foo
p bar


module SayMyName
  attr_accessor :name
  def initialize(name)
    @name = name
  end
  def print_name
    puts "Name: #{@name}"
  end
end

class Person
  include SayMyName  # module used as mixin
end

class Company
  include SayMyName  # module used as mixin
end

person = Person.new('John')
person.print_name

person = Company.new('Globo.com')
person.print_name
