=begin
  # sample-splitting-field01.rb

  require "algebra"
  
  PQ = Polynomial(Rational, "x")
  x = PQ.var
  f = x**4 + 2
  p f #=> x^4 + 2
  field, modulus, facts = f.decompose
  p modulus #=> [a^4 + 2, b^2 + a^2]
  p facts #=> (x - a)(x + a)(x - b)(x + b)
  
  fp = Polynomial(field, "x")
  x = fp.var
  facts = Factors.new(facts.collect{|g, n| [g.evaluate(x), n]})
  p facts.pi == f.convert_to(fp) #=> true
((<_|CONTENTS>))
=end
