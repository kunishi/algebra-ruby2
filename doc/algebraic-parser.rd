=begin
[((<index|URL:index.html>))] 
= Algebra::AlgebraicParser
((*(Class of Evaluation of Algebraic Expression)*))

== File Name:
* ((|algebraic-parser.rb|))

== SuperClass:

* ((|Object|))

== Included Module:

none.

== Class Methods:
--- Algebra::AlgebraicParser.eval(string, ring)
    Calculates the ((|string|)) on ((|ring|)).

== Methods:

none.

== Specification:

=== Evaluation

The value of variable is obtained by the class method 
((|indeterminate|)) of ((|ring|)). The value of numeral is 
the return value of the class method ((|indeterminate|)) of
((|ring.ground|)).

      require "algebraic-parser"
      class A
        def self.indeterminate(str)
          case str
          when "x"; 7
          when "y"; 11
          end
        end
        def A.ground
          Integer
        end
      end
      p Algebra::AlgebraicParser.eval("x * y - x^2 + x/8", A)
          #=> 7*11 - 7**2 + 7/8 = 28
      
((|indeterminate|)) of ((|Integer|)) is defined as following:
    
        def Integer.indeterminate(x)
          eval(x)
        end

in algebra-supplement.rb which is required by algebraic-parser.rb
      
=== Identifier
Identifier is "a alphabet + some digits". For example,

        "a13bc04def0"
      
is interpreted as

        "a13 * b * c04 * d * e * f0".


=== Operations
The order of strength of operations:

  ;               intermediate evaluation
  +, -            sum, difference
  +, -            unary +, unary -
  *, /            product, quotient
  (juxtaposition) product
  **, ^           power

=== Example:
In ((|Algebra::Polynomial|)) and ((|Algebra::MPolynomial|)), 
((|indeterminate|))
and((|ground|)) are defined suitably. So we can obtain the
value of strings as following:

      require "algebraic-parser"
      require "rational"
      require "m-polynomial"
      F = Algebra::MPolynomial(Rational)
      p Algebra::AlgebraicParser.eval("- (2*y)**3 + x", F) #=> -8y^3 + x

In ((|Algebra::MPolynomial|)), ((|indeterminate|)) resists the objects 
representing
variables in order that they appear. So we may set the order, using `;'.

      F.variables.clear
      p Algebra::AlgebraicParser.eval("x; y; - (2*y)**3 + x", F) #=> x - 8y^3

=end


