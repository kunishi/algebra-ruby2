#################################################
#                                               #
#  This is test script for 'localized-ring.rb'  #
#                                               #
#################################################
require "algebra/localized-ring.rb"
require "algebra/polynomial"
require "algebra/rational"
require "algebra/algebraic-extension-field"
include Algebra

Q = LocalizedRing(Integer)
a = Q.new(3, 5)
b = Q.new(5, 3)
p [a + b, a - b, a * b, a / b, a + 3, 1 + a]

Z13 = ResidueClassRing(Integer, 13)

Z13x = Polynomial(Z13, "x")
x = Z13x.var
QZ13x = LocalizedRing(Z13x)
a = QZ13x[x**2 + x + 1, x**2 - 1]
b = QZ13x[x + 1, x**2 + 3*x + 2]
p a + b
p( (a + b) ** 4)
puts

Rx = Polynomial(Rational, "x")
#  Rx = Polynomial(Z13, "x")
x = Rx.var
QRx = LocalizedRing(Rx)
x = QRx[x]
a = (x**2 + 1)/(x**3 + x + 1)
QRxy = Polynomial(QRx, "y")
y = QRxy.var
AFF = ResidueClassRing(QRxy, y**3 + a*y + 1)
y = AFF[y]
p( (y+x) ** 3 )

F = RationalFunctionField(Rational, "x")
x = F.var
p ( 1 / (x**2 - 1) - 1 / (x**3 - 1) )

require "mathn"
S = AlgebraicExtensionField(Rational, "a") {|a| a**2 - 2}
QSx = RationalFunctionField(S, "x")
x, a = QSx.var, S.var
p( (a/4*x + 1/2)/(x**2 + a*x + 1) + (-a/4*x + 1/2)/(x**2 - a*x + 1) )
