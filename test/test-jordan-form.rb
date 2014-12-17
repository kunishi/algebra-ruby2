require "rubyunit"
require "algebra/rational"
class Rational; def inspect; to_s; end;end
#class Rational < Numeric;def inspect; to_s; end;end
require "algebra/linear-algebra"
require "algebra/matrix-algebra-triplet"
require "algebra/elementary-divisor"
require "algebra/jordan-form"
require "algebra/algebraic-equation"
#include Algebra

# "Jordan Hyouzyunkei I & Isa, Tokudai Syuppan Kai # pp.96-97
A = [
  [#0
    [4, 1, 1, 1],
    [1, 5, 3, -1],
    [-1, -2, 1, -1],
    [-1, -1, -1, 2]
  ],
  [#1
    [-3, -3, 4, 2],
    [5, 1, -4, -6],
    [4, -1, -2, -5],
    [-5, -3, 4, 4]
  ],
  [#2
    [3, -1, 3],
    [-1, 3, 3],
    [1, -1, 5]
  ],
  [#3
    [-1, 1, 2, -1],
    [-5, 3, 4, -2],
    [3, -1, 0, 1],
    [5, -2, -2, 3]
  ],
  [#4
    [1, 2, 0, 0],
    [0, 1, 2, 0],
    [0, 0, 1, 2],
    [0, 0, 0, 1]
  ],
  [#5
    [3, 0, 2, 1],
    [0, 3, 0, 2],
    [0, 0, 3, 0],
    [0, 0, 0, 3]
  ],
  [#6
    [1, 0, 0, 0],
    [2, 1, 0, 0],
    [0, 2, 1, 0],
    [0, 0, 2, 1]
  ],
  [#7
    [2, 0, 0, 0],
    [0, 2, 0, 0],
    [0, 0, 2, 0],
    [5, 0, 0, 2]
  ],
  [#8
    [0, 0, 8],
    [1, 0, 4],
    [0, 1, -2]
  ],

  #### Original
  [#9
    [1, 1, 0],
    [1, 1, 1],
    [0, 1, 1]
  ],
  [#10
    [1, 0, 8],
    [1, 1, 4],
    [0, 1, -2]
  ],
  [#11 288sec.
    [0, 0, 1, 0],
    [1, 1, 1, 1],
    [1, 1, 1, 1],
    [0, 1, 1, 1]
  ],
]
Ai = (0...A.size).to_a

class TestJordanForm < Runit
  PR = Algebra.Polynomial(Rational, "x")
  def test_jordan_form0
    puts
    Ai.each do |i|; m = A[i]
#    Ai[0..9].each do |i|; m = A[i]
      puts "##{i}"
      _test_jordan_form(m)
    end
  end

  def _test_jordan_form(a)
    m = Algebra.SquareMatrix(Rational, a.size)[*a]
    m.display; puts
    asr = Algebra.SquareMatrix(PR, a.size)
   
    me = m._char_matrix(asr).to_quint.e_diagonalize
    elem_divs = me.body.diag
    
    p elem_divs; puts
    me.body.display;puts

    facts = Algebra::ElementaryDivisor.factorize(elem_divs)
    dl = facts.last
    field, modulus, facts, roots, elms =dl.pi.decompose(dl)
    p [facts, roots, elms]

    pfield = Algebra.Polynomial(field, "x")
    pfm_alg = Algebra.SquareMatrix(pfield, a.size)

    jm = Algebra::JordanForm.construct(elem_divs, facts, field, pfield) 
    jme = jm._char_matrix(pfm_alg).to_quint.e_diagonalize

    mebody = pfm_alg.convert_from(me.body)
    meright = pfm_alg.convert_from(me.right)
    meleft = pfm_alg.convert_from(me.left)

    assert_equal(mebody, jme.body)

    sR = (meright * jme.righti).i2o.evaluateR(jm)
    tL = (jme.lefti * meleft).i2o.evaluateL(jm)

    m = m.convert_to(jm.class)

    k = tL * m * sR

    k.display;puts
    assert_equal(k, jm)
  end

  def test_jordan_form
    puts
    Ai[0..0].each do |i|; a = A[i]
      puts "##{i}"
      m = Algebra.SquareMatrix(Rational, a.size)[*a]
      m.display; puts

      jf, p, q, field, modulus  = Algebra::JordanForm.decompose(m)
      print "extension = "
      p modulus
      jf.display; puts

      print "P =\n"; p.display; puts
      print "P^-1 =\n"; q.display; puts

      m = m.convert_to(jf.class)
      assert_equal(jf, p * m * q)
    end
  end
end

Tests(TestJordanForm)
