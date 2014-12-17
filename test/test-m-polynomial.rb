###############################################
#                                             #
#  This is test script for 'm-polynomial.rb'  #
#                                             #
# date: 2003.06.01                            #
#                                             #
###############################################
require "assert"
require "algebra/rational.rb"
require "algebra/m-polynomial.rb"
include Algebra

Foo = MPolynomial(Integer)
f = Foo[MIndex[1,1]=>1, MIndex[1,3]=>4, MIndex[]=>9]
g = Foo[MIndex[1,1]=>1, MIndex[1,3]=>4, MIndex[]=>9,
  MIndex[0,2,3]=>6, MIndex[2,3]=>-1, MIndex[2]=>-5,MIndex[0,1]=>7]
$DEBUG = true
puts f, g, f*g
$DEBUG = false
puts

require "mathn"

P0 = Algebra.MPolynomial(Rational)
x, y = P0.vars("xy")

P0.with_ord(:lex) do
  assert((x*y**2 -x).divmod(x*y - 1, y**2 - 1), [[y, 0], -x + y])
  assert((x*y**2 -x).divmod(x*y - 1, y**2 - 1), [[y, 0], -x + y])
end

P0.with_ord(:lex) do
  assert((x+y**2).divmod(x+y), [[1], y**2 - y])
end

P0.with_ord(:lex, [1,0]) do
  assert((x+y**2).divmod(x+y), [[y - x], x**2 + x])
end

P0.with_ord(:lex, nil) do
  assert((x*y+y**2).divmod(x + y**2), [[y], -y**3 + y**2])
end

P0.with_ord(:grlex, nil) do
  assert((x*y+y**2).divmod(x + y**2), [[1], x*y - x])
end

P = MPolynomial(Rational)
x, y, z = P.vars("xyz")
f = x**2*y + x*y**2 + y*2 + z**3
g = x*y-z**3
h = y*2-6*z

assert(f.derivate(x), 2*x*y + y**2)
assert(f.derivate(y), x**2 + 2*x*y + 2)
assert(f.derivate("x"), 2*x*y + y**2)

P.set_ord(:lex)
#puts "LEX:"
#puts "(#{f}).divmod([#{g}, #{h}]) =>"
fgh = f.divmod(g, h)
assert(fgh, [[x + y, 1/2*z**3 + 1], x*z**3 + 3*z**4 + z**3 + 6*z])
#puts

P.method_cash_clear(f, g, h)
P.set_ord(:grlex)
#puts "GRLEX:"
#puts "(#{f}).divmod([#{g}, #{h}]) =>"
fgh = f.divmod(g, h)
###assert(fgh , [[-1, 1], x**2*y + x*y**2 + x*y + 6*z])
assert(fgh , [[-1, 1/2*x**2 + 1/2*x*y + 3/2*x*z + 1/2*x + 1], 3*x**2*z + 9*x*z**2 + 3*x*z + 6*z])
#puts

P.method_cash_clear(f, g, h)
P.set_ord(:grevlex)
#puts "GREVLEX:"
#puts "(#{f}).divmod([#{g}, #{h}]) =>"
fgh = f.divmod(g, h)
assert(fgh, [[-1, 1/2*x**2 + 1/2*x*y + 3/2*x*z + 1/2*x + 1], 3*x**2*z + 9*x*z**2 + 3*x*z + 6*z] )
#puts

P.variables.clear
z, y, x = P.vars("zyx")
f = x**2*y + x*y**2 + y*2 + z**3
g = x*y-z**3
h = y*2-6*z
#puts "GREVLEX: order z, y, x"
#puts "(#{f}).divmod([#{g}, #{h}]) =>"
fgh = f.divmod(g, h)
assert(fgh , [[-1, 0], y**2*x + y*x**2 + y*x + 2*y])
#puts

Q = MPolynomial(Integer)
x, y, z = Q.vars('xyz')
f = x * y * z
assert(f.sub(y, y-1), x*(y-1)*z)
f = (x - y)*(y - z - 1)
assert f.sub(y, z+1), 0
