##########################################
# Elementary Divisor
#    by Shin-ichiro HARA
#
#    Ver. 1.0 (2001.11.03)
#
##########################################

module Algebra
  class MatrixAlgebra
    def i2o
      mground = self.class.ground.ground
      r = if self.class <= Algebra::SquareMatrix
	    Algebra.SquareMatrix(mground, size)
	  else
	    Algebra.MatrixAlgebra(mground, rsize, csize)
	  end
      
      rx = Algebra.Polynomial(r, "x")
      x = rx.var
      s = 0
      (0..e_deg).each do |n|
	s += x**n * r.matrix{ |i, j| self[i, j][n] }
      end
      s
    end

    def e_deg
      max = -1
      each_ij do |i, j|
	if !self[i, j].zero? && (d = self[i, j].deg) > max
	  max = d
	end
      end
      max
    end
  end
  
  module ElementaryDivisor
    def e_inverse
      raise "not square matrix" unless rsize == csize
      size = rsize
      edm = to_triplet.e_diagonalize
      if edm.body[size-1, size-1].unity?
	edm.right * edm.left
      else
	puts "elementary divisor matrix:"; edm.body.display
	raise "not invertible"
      end
    end

    def elementary_divisor
      e_diagonalize.diag
    end

    def e_diagonalize
      dup.e_diagonalize!
    end
    
    def e_diagonalize!
      size = rsize < csize ? rsize : csize
      0.upto size-1 do |d|
	el_sweep!(d)
      end
      self
    end

    def el_sweep!(d)
      while true
	1 while horizontal_sweep!(d) or vertical_sweep!(d)
	if idx = sq_find_nondiv(d+1, self[d, d])
	  i, j = idx
	  mix_r!(d, i)
	else
	  break
	end
      end
      unless self[d, d].zero?
	#	row!(d)[d] = self[d, d].monic
	divide_r!(d, _coeff(self[d, d]))
      end
      self
    end

    def el_sweep_old!(d)
      while true
	sr = vertical_sweep!(d)
	sc = horizontal_sweep!(d)
	break unless sr or sc
	if idx = sq_find_nondiv(d+1, self[d, d])
	  i, j = idx
	  mix_r!(d, i)
	  redo
	end
      end
      unless self[d, d].zero?
#	row!(d)[d] = self[d, d].monic
	divide_r!(d, _coeff(self[d, d]))
      end
      self
    end

    def _coeff(sdd)
      if ground <= Algebra::Polynomial
	sdd.lc
      elsif ground.field?
	sdd
      elsif ground.euclidian?
	if ground <= Integer and sdd < 0
	  - ground.unity
	elsif sdd.unit?
	  sdd
	else
	  ground.unity
	end
      else
	ground.unity
      end
    end

    def sq_find_nondiv(d, x)
      (d...rsize).each do |i|
	(d...csize).each do |j|
	  unless (self[i, j] % x).zero?
	    return [i, j]
	  end
	end
      end
      nil
    end
    
    def vertical_sweep!(d)
      sw = false
      if self[d, d].zero? and i = ((d+1)...rsize).find{|i| !self[i, d].zero?}
	sswap_r!(d, i)
	sw = true
      end
      unless self[d, d].zero?
	(d+1...rsize).each do |i0|
	  unless self[i0, d].zero?
	    q = self[i0, d] / self[d, d]
	    sw = true
	    mix_r!(i0, d, -q)
# high speed but lost genericity (wo'nt work on triplet)
#	    r = row!(i0)
#	    (d...csize).each do |j0|; r[j0] -=  q * self[d, j0]; end
	    unless self[i0, d].zero?
	      sswap_r!(d, i0)
	      redo
	    end
	  end
	end
      end
      sw
    end

    def horizontal_sweep!(d)
      m = transpose
      if m.vertical_sweep!(d)
	replace m.transpose
	true
      else
	false
      end
    end

    def self.factorize(eds)
      prev = nil
      qeds = []
      eds.each do |f|
	if prev
	  qeds << f / prev
	else
	  qeds << f
	end
	prev = f
      end
      
      qeds_facts = qeds.collect{|f| f.factorize}
      result = []
      prev = nil
      qeds_facts.each do |fac|
	if prev
	  prev = prev * fac
	else
	  prev = fac
	end
	result << prev
      end
      result
    end
  end

  class MatrixAlgebra
    include ElementaryDivisor
  end
end
