#
#  algebra
#                                                    by Shin-ichiro HARA
#
#  Version 0.04 (2003.06.19)
#

require 'algebra/auto-require'
require 'algebra/rational'

module Algebra
  require 'algebra/algebraic-equation'
  require 'algebra/polynomial' # class Polynomial
  require 'algebra/m-polynomial'
  require 'algebra/residue-class-ring'
  require 'algebra/algebraic-extension-field'
  require 'algebra/localized-ring'
  require 'algebra/matrix-algebra'

  require 'algebra/finite-set'
  require 'algebra/finite-map'
  require 'algebra/permutation-group'
end
include Algebra

require 'algebra/polynomial' # function Polyomial
require 'algebra/m-polynomial'

require 'algebra/residue-class-ring'
require 'algebra/algebraic-extension-field'
require 'algebra/localized-ring'
require 'algebra/matrix-algebra'

# for backward compatibility
require 'algebra/splitting-field'
