# require "algebra/euclidian-ring"
require 'algebra/array-supplement'

module Algebra
  module ChineseRemainderTheorem
    # return coeffs s.t. coeffs.inner_product(ary) == c
    # entries of c and ary must be euclidian ring
    def decompose_on_factors(c, ary)
      f1, *fs = ary
      k, *coeffs = f1.gcd_ext_all(*fs)
      q, r = c.divmod(k)
      unless r.zero?
        print 'c = '
        p c
        print 'k = '
        p k
        print 'ary = '
        p ary
        raise "#{c} is not expressed by parameters"
      end
      d1, *ds = coeffs.collect { |x| x * q }
      [d1] + ds # this is ok
    end

    def decompose_on_cofactors_modp(c, ary, cofacts)
      # c: Polynomial/Zp
      # ary: Array of Polynomial/Zp
      # cofacts: cofacts of ary
      # OutPut: coeff.inner_product(cofacts of ary) == c

      pf = c.ground
      prime = c.ground.char
      coeffs = ary.collect(&:zero)
      d1, *ds = decompose_on_factors(c, cofacts)
      # normalize
      ds_new = []
      ds.each_with_index do |d, i|
        fq, fr = d.divmod(ary[i + 1])
        d1 += fq * ary[0]
        ds_new << fr
      end
      coeffs = [d1] + ds_new

      #    p c == coeffs.inner_product(cofacts)
      coeffs
    end

    def decomp_on_cofactors_over_p_adic_int_first(c, ary, prime, cofacts)
      pf = Polynomial.reduction(Integer, prime, 'x')
      ary_Zp = ary.collect { |f| pf.reduce(f) }
      cofacts_Zp = cofacts.collect { |f| pf.reduce(f) }
      c_zp = pf.reduce(c)

      d1, *ds = decompose_on_factors(c_zp, cofacts_Zp)

      # normalize
      ds_new = []
      ds.each_with_index do |d, i|
        fq, fr = d.divmod(ary_Zp[i + 1])
        d1 += fq * ary_Zp[0]
        ds_new << fr
      end
      coeffs = [d1] + ds_new
      ring = c.class
      coeffs.collect { |f| lifting(f, ring) }
    end

    def lifting(f, ring)
      f.project(ring) { |c, _i| c.lift }
    end

    private :decomp_on_cofactors_over_p_adic_int_first, :lifting

    def mk_cofacts(ary)
      tot = ary.first.unity
      ary.each { |f|; tot *= f; }
      cofacts = []
      ary.each { |f|; cofacts.push tot / f; }
      cofacts
    end

    def decompose_on_cofactors_p_adic(c, ary, cofacts, prime, k)
      # c: Polynomial/Intger
      # ary: Array of Polynomial/Integer
      # OutPut: coeff.inner_product(cofacts of ary) === c mod prime**k

      raise if ary.find { |f| (f.lc % prime).zero? }
      #    cofacts = mk_cofacts(ary)
      coeffs = ary.collect(&:zero)
      0.upto k - 1 do |j|
        e = prime**j
        c1 = (c - coeffs.inner_product(cofacts)) / e
        coeffs1 = decomp_on_cofactors_over_p_adic_int_first(c1,
                                                            ary, prime, cofacts)
        coeffs.each_index do |i|
          coeffs[i] += coeffs1[i] * e
        end
      end
      #    p c - coeffs.inner_product(cofacts)
      coeffs
    end
  end
end

if $PROGRAM_NAME == __FILE__
  CRT = ChineseRemainderTheorem
  include CRT
  require 'algebra/polynomial'
  require 'algebra/residue-class-ring'
  require 'algebra/polynomial-factor'
  Zp = ResidueClassRing(Integer, 5)
  P = Polynomial(Zp, 'x')
  x = P.var
  a = x + 1
  b = x + 2
  c = x + 3
  #  ary = [b*c, c*a, a*b]
  ary = [a, b, c]
  f = a * b * c
  #  coeffs =  decompose_on_factors(P.unity, ary)
  coeffs =  decompose_on_cofactors_modp(P.unity, ary, mk_cofacts(ary))
  p cofacts = mk_cofacts(ary)
  p coeffs
  p coeffs.inner_product(cofacts)

  exit
  PZ = Polynomial(Integer, 'x')
  x = PZ.var
  a = (x + 1)**2
  b = (x + 2)**3
  c = (x + 3)**1
  ary = [a, b, c]
  p decompose_on_cofactors_over_p_adic_int(PZ.unity, ary, mk_cofacts(ary),
                                           11, 2)
end
