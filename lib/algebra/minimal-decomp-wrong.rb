  def PolyDecompose_incomplete(f, facts = f.factorize)
    # this is wrong algorithm
    vars = []
    var = "a"
    facts.each do |f, n|
      dim = f.deg
      next if dim <= 1
      dim.downto 1 do
	vars.unshift var
	var = var.succ
      end
    end
    
    pr = Algebra.MPolynomial(f.ground)
    vs = pr.vars(*vars)
    
    i = 0
    fs = []
    facts.each do |f, n|
      dim = f.deg
      if dim > 1
	sym = symmetric_product(vs[i, dim])
	fa = (1..dim).collect{|j| sym[j] - f[dim-j]*(-1)**j}
	fs.concat fa
	i += dim
      end
    end
    
    pr.sysvar(:basis, Groebner.basis(fs))
    pr.class_eval "
    def inverse
      qs, bs = Groebner.basis_coeff([self] + @@basis)
      unless bs == [1]
	raise self.to_s + \" can't be inverted.\"
      end
      qs[0][0]
    end
    "
    rs = Algebra.ResidueClassRing(pr, pr.basis)
    rs.sysvar(:vars, pr.vars.collect{|v| rs[v]})
    rs
  end

