# Splitting Field of Polynomial over Rational
#
#   by Shin-ichiro Hara
#
# Version 1.11 (2002.02.23)

require "algebra/polynomial"
require "algebra/polynomial-factor"
require "algebra/algebraic-extension-field"

module Algebra
  module SplittingField
    def decompose(pre_facts = nil, var_obj = "a", no_sq = false)
      poly = self
      # poly may have duplicate roots
      ext_field = poly.ground

      polys = pre_facts ? pre_facts.dup : poly.factorize
      roots = []
      #roots == addelems + cmpelems, as set.
      #the difference is ordering.
      addelems = []
      cmpelems = []
      fac = Factors.new
      
      while fn = polys.shift
        f, n = fn #f: irreducible, n: duplication
        if f.deg <= 1
          fac.push [f, n]
	   roots.concat([-f[0]/f[1]] * n) unless f[1].zero?
	   cmpelems.concat([-f[0]/f[1]] * n) unless f[1].zero?
        else
          if !no_sq && f.deg == 2
            newF, r, r0 = Algebra.QuadraticExtensionField(ext_field, &f)
            roots.concat([r, r0] * n)

            addelems.push r
            cmpelems.concat([r] * (n-1))
            cmpelems.concat([r0] * n)

            px, x = Algebra.Polynomial(newF, "x")
            fac.push [x - r, n]
            fac.push [x - r0, n]
            q = f.convert_to(px) / (x - r) / (x - r0) #scalar
          else
            newF = Algebra.AlgebraicExtensionField(ext_field, var_obj) {|v|
              f.evaluate(v)
            }
            r = newF.var
            
            roots.concat([r] * n)
            addelems.push r
            cmpelems.concat([r] * (n-1))
            
            px, x = Algebra.Polynomial(newF, "x")
            fac.push [x - r, n]
            q = f.convert_to(px) / (x - r)
          end

          polys_new = (q.factorize) ** n
          polys.each do |g, m|
            g0 = g.convert_to(px)
            fc = g0.factorize
            polys_new.concat fc ** m
          end
	  
          ext_field = newF
          polys = polys_new
          var_obj = /^[a-qs-z]\d*$/ =~ var_obj ? var_obj.succ : var_obj + "_"
        end
      end
      
      mods = if ext_field <= Algebra::AlgebraicExtensionField
	       ext_field.def_polys
	     else
	       []
	     end

      proots = addelems+cmpelems

      [ext_field, mods, fac, roots, proots]
    end

    def splitting_field(pre_facts = nil, var_obj = "a", no_sq = false)
      var_obj ||= "a"
      poly = self
      field, def_polys, fac, roots, proots =
	poly.decompose(pre_facts, var_obj, no_sq)
      roots = roots.collect{|r| field.regulate(r)}
      proots = proots.collect{|r| field.regulate(r)}

      Struct.new(:poly, :field, :roots, :def_polys, :proots)[
	poly, field, roots, def_polys, proots
      ]
    end
  end

  #for backward compatibility
  def MinimalDecompositionField(f, *a); f.decompose(*a); end
  module_function :MinimalDecompositionField
end
