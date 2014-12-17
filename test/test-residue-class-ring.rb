#####################################################
#                                                   #
#  This is test script for 'residue-class-ring.rb'  #
#                                                   #
#####################################################
require "algebra/residue-class-ring.rb"
include Algebra
Z13 = ResidueClassRing.create(Integer, 13)

a, b, c, d, e, f, g = Z13
p [e + c, e - c, e * c, e * 2001, 3 + c, 1/c, 1/c * c,
  d / d, b * 1 / b] #=> [6, 2, 8, 9, 5, 7, 1, 1, 1]
p( (1...13).collect{|i|  Z13[i]**12} )
        #=> [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

require 'algebra/polynomial'
require "algebra/rational"

Px = Polynomial(Rational, "x")
#  Px = Polynomial(Z13, "x")

x = Px.var
F = ResidueClassRing(Px, x**2 + x + 1)
x = F[x]
p( (x + 1)**100 )    #=> -x - 1

G = Polynomial(F, "y")
y = G.var

p( (x + y + 1)** 7 )
  #=> y^7 + (7x + 7)y^6 + 8xy^5 + 4y^4 + (4x + 4)y^3 + 5xy^2 + 7y + x + 1

H = ResidueClassRing(G, y**5 + x*y + 1)
y = H[y]

p( (x + y + 1)**7 )
  #=> 4y^4 + (3x + 4)y^3 + (5x + 6)y^2 + (x + 8)y + 6x + 1
p( 1/(x + y + 1)**7 )
  #=> (1798/3x + 1825/9)y^4 + (-74x + 5176/9)y^3 + 
  #     (-6886/9x - 5917/9)y^2 + (1826/3x - 3101/9)y + 2146/9x + 4702/9

#require 'polynomial'
#  A = Polynomial(Rational, "x")
Z7 = ResidueClassRing.create(Integer, 7)
A = Polynomial(Z7, "x")
x = A.var
B = Polynomial(A, "y")
y = B.var
C = Polynomial(B, "z")
z = C.var
D = Polynomial(C, "w")
w = D.var
p( (x+y+z+w)**7 ) #=> w^7 + z^7 + y^7 + x^7
