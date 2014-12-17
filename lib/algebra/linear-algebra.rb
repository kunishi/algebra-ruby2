# Linear Algebra
#
#   by Shin-ichiro Hara
#
# Version 1.00 (2001.11.01)

require "algebra/matrix-algebra"
require "algebra/gaussian-elimination"
require "algebra/polynomial"
require "algebra/polynomial-factor"
require "algebra/algebraic-equation"
require "algebra/jordan-form"

module Algebra

module Orthogonalization
  def orthogonalize
    orth_basis = []
    vectors.each_with_index do |b, i|
      orth_basis.push b
      if i > 0
	orth_basis[0...i].each do |f|
	  orth_basis[i] -= b.inner_product(f) / f.norm2 * f
#	  orth_basis[i] = f.norm2*orth_basis[i] - b.inner_product(f)*f #also
	end
      end
    end
    self.class.collect_column{|j| orth_basis[j]}
  end

  def normalize
    k = ground
    orth_basis = []
    vectors.each do |b|
      k, n = Sqrt(k, b.norm2)
      orth_basis.push Vector(k, size) ** b / n
    end
    Algebra.SquareMatrix(k, size).collect_column{|j| orth_basis[j]}
  end
end

class MatrixAlgebra
  include Orthogonalization
  auto_req_init
  auto_req :e_diagonalize, "algebra/elementary-divisor"
  auto_req :elementary_divisor, "algebra/elementary-divisor"
end

class SquareMatrix < MatrixAlgebra
  def self.symmetric(*a)
    k = size*(size+1)/2
    raise "the size of #{a.inspect} must be <= #{k}" if a.size > k
    matrix{ |i, j|
      d = (i - j).abs
      a[(i < j ? i : j) + (2*size+1-d)*d/2 ] || ground.zero
    }
  end

  EigenSystem = Struct.new("EigenSystem",
                           :extfield,
                           :roots,
                           :tmatrix,
                           :evalues,
                           :addelms,
                           :evectors,
                           :espaces,
                           :chpoly,
                           :facts)

  def diagonalize
    chp = char_polynomial(Algebra.Polynomial(ground, "t"))

    facts = chp.factorize
    mdf, mods, fas, roots, proots = chp.decompose(facts)
    nu = Algebra.SquareMatrix(mdf, size)

    espaces = {}
    evalues = []
    evectors = []
    roots0 = []
    k = 0
    facts.each do |f, n|
      dim = f.deg
      if dim <= 0 # 0 might be occurred
	next
      elsif dim == 1
	evs =  [-f[0]/f[1]]
      else
	evs = roots[k, dim]#.reverse
	roots0.push [f, evs]
      end
      k += dim

      evs.each do |evalue|
	ks = nu.const(evalue) - self
	kb = ks.kernel_basis
	espaces[evalue] = kb

	kb.each do |v|
	  evalues.push evalue
	  evectors.push v
	end
      end
    end

    raise "can't Diagonalize" if evalues.size < size
    ttype = Algebra.SquareMatrix(mdf, size)
    r = ttype.collect_column{|i| evectors[i]}
#    :extfield, :roots, :tmatrix, :evalues, :addelms, :evectors, 
#                   :espaces, :chpoly, :facts
    e = EigenSystem.new(mdf, roots0, r, evalues, proots, evectors,
                    espaces, chp, facts)
    def e.to_ary; to_a; end
    e
  end

  def solve_eigen_value_problem
    puts "A = "; display; puts
    
    e = diagonalize
    puts "Charactoristic Poly.: #{e.chpoly} => #{e.facts}"; puts
    puts "Algebraic Numbers:"
    e.roots.each do |po, rs|
      puts "#{rs.join(', ')} : roots of #{po} == 0"
    end; puts
    
    puts "EigenSpaces: "
    e.evalues.uniq.each do |ev|
      puts "W_{#{ev}} = <#{e.espaces[ev].join(', ')}>"
    end; puts
    
    puts "Trans. Matrix:"
    puts "P ="
    e.tmatrix.display; puts
    
    puts "P^-1 * A * P = "; (e.tmatrix.inverse * self * e.tmatrix).display; puts
  end
end
end

if __FILE__ == $0
end
