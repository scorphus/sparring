puts 'Method names are symbols! Look:'
p 'Ruby'.methods.grep /case/

p :foo
p :bar

p :foo.methods

p :foo == 'foo'
p :foo.equal? 'foo'

p :baz.to_s
