# Jordan Canonical Forms
#
#   by Shin-ichiro Hara
#
# Version 1.00 (2001.11.01)
require "algebra/matrix-algebra"

module Algebra
  class MatrixAlgebra
    def jordan_form
      Algebra::JordanForm.decompose(self).first
    end
    def jordan_form_info
      Algebra::JordanForm.decompose(self)
    end
  end

  class JordanForm
    def initialize(body)
      @body = body
    end

    def to_matrix(ring = Integer)
      mat = nil
      @body.each do |x, n|
	if mat
	  mat = mat.dsum(jordan_block_u(ring, x, n))
	else
	  mat = jordan_block_u(ring, x, n)
	end
      end
      mat
    end

    alias to_matrix_u to_matrix

    def to_matrix_l
      to_matrix_u.transpose
    end

    def jordan_block_u(ring, x, n)
      a = Algebra.SquareMatrix(ring, n)
      a.matrix{|i, j|
	if i == j
	  x
	elsif i == j-1
	  ring.unity
	else
	  ring.zero
	end
      }
    end

    def jordan_block_l(ring, x, n)
      jordan_block_u(ring, x, n).transpose
    end

    def self.construct(elem_divs, facts, field, pfield)
      a = []
      elem_divs.each do |e|
	facts.each do |f, n|
          next if f.deg.zero? || n.zero?
	  f = f.convert_to(pfield)
	  g = e.convert_to(pfield)

	  raise "insufficient decomposition" unless f.deg <= 1
	  k = 0
	  while true
	    q, r = g.divmod f
	    break unless r.zero?
	    g = q
	    k += 1
	  end
	  a.push [-f[0], k] if k > 0
	end
      end
      Algebra::JordanForm.new(a).to_matrix(field)
    end
    
    def self.decompose(m)
      base_ring = m.ground
      base_pring = Algebra.Polynomial(base_ring, "x")
      base_alg = Algebra.SquareMatrix(base_pring, m.size)

      me = m._char_matrix(base_alg).to_quint.e_diagonalize
      elem_divs = me.body.diag
      
      facts = Algebra::ElementaryDivisor.factorize(elem_divs)
      dl = facts.last
      field, modulus, facts, roots, elms = dl.pi.decompose(dl)
      
      pfield = Algebra.Polynomial(field, "x")
      pfm_alg = Algebra.SquareMatrix(pfield, m.size)
      
      jm = Algebra::JordanForm.construct(elem_divs, facts, field, pfield) 
      jme = jm._char_matrix(pfm_alg).to_quint.e_diagonalize
      
      mebody = pfm_alg.convert_from(me.body)
      meright = pfm_alg.convert_from(me.right)
      meleft = pfm_alg.convert_from(me.left)
      
      sR = (meright * jme.righti).i2o.evaluateR(jm)
      tL = (jme.lefti * meleft).i2o.evaluateL(jm)
      
      [jm, tL, sR, field, modulus]
    end
  end
end

if $0 == __FILE__
  j = Algebra::JordanForm.new([[2, 3], [-1, 2]])
  j.to_matrix.display
end
