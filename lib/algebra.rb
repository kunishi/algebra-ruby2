#
#  algebra
#                                                    by Shin-ichiro HARA
#  
#  Version 0.04 (2003.06.19)
#

require "algebra/auto-require"
#autoload :Rational, "algebra/rational"
require "algebra/rational"
#require "algebra/ruby-version"

module Algebra
  autoload :AlgebraicEquation, "algebra/algebraic-equation"
  autoload :Polynomial, "algebra/polynomial"  # class Polynomial
  autoload :MPolynomial, "algebra/m-polynomial"
  autoload :ResidueClassRing, "algebra/residue-class-ring"
  autoload :AlgebraicExtensionField, "algebra/algebraic-extension-field"
  autoload :LocalizedRing, "algebra/localized-ring"
  autoload :MatrixAlgebra, "algebra/matrix-algebra"
  autoload :SquareMatrix, "algebra/matrix-algebra"
  autoload :AlgebraicExtensionField, "algebra/algebraic-extension-field"

  autoload :Set, "algebra/finite-set"
  autoload :Map, "algebra/finite-map"
  autoload :PermutationGroup, "algebra/permutation-group"
  autoload :Permutation, "algebra/permutation-group"
end
include Algebra

auto_req_init
auto_req :Polynomial, "algebra/polynomial" # function Polyomial
auto_req :MPolynomial, "algebra/m-polynomial"

auto_req :ResidueClassRing, "algebra/residue-class-ring"
auto_req :AlgebraicExtensionField, "algebra/algebraic-extension-field"
auto_req :QuadraticExtensionField, "algebra/algebraic-extension-field"
auto_req :Sqrt, "algebra/algebraic-extension-field"
auto_req :Root, "algebra/algebraic-extension-field"

auto_req :LocalizedRing, "algebra/localized-ring"
auto_req :RationalFunctionField, "algebra/localized-ring"
auto_req :MRationalFunctionField, "algebra/localized-ring"

auto_req :MatrixAlgebra, "algebra/matrix-algebra"
auto_req :SquareMatrix, "algebra/matrix-algebra"
auto_req :Vector, "algebra/matrix-algebra"
auto_req :Covector, "algebra/matrix-algebra"

#for backward compatibility
auto_req :MinimalDecompositionField, "algebra/splitting-field"
