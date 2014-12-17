=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::MPolynomial>))
/
((<Algebra::MPolynomial::Monomial>))
/
((<Algebra::MPolynomialFactorization>))
/
((<Algebra::Groebner>))

= Algebra::MPolynomial
((*(���ϐ��������N���X)*))

���ϐ��̑�������\�����܂��B���ۂ̃N���X�𐶐�����ɂ͊��w�肵�āA
�N���X���\�b�h((<::create>))���邢�͊֐�((<Algebra.MPolynomial>))()��
�p���܂��B

== �t�@�C����:
* ((|m-polynomial.rb|))

== �X�[�p�[�N���X:

* ((|Object|))

== �C���N���[�h���Ă��郂�W���[��:

* ((|Enumerable|))
* ((|Comparable|))
* ((<Algebra::Groebner>))

== �֘A����֐�:

--- Algebra.MPolynomial(ring [, obj0 [, obj1 [, ...]]])
    ((<::create(ring [, obj0[, obj1[, ...]]])>))�ɓ����B

== �N���X���\�b�h:

--- ::create(ring [, obj0 [, obj1 [, ...]]])
    ((|ring|))�ŕ\�������N���X���W���Ƃ��鑽�ϐ���������
    �N���X�𐶐����܂��B
    
    �I�u�W�F�N�g(({obj0, obj1, ...}))�ŕϐ���o�^���A�߂�l�ł���
    ���ϐ��������N���X�� Algebra::MPolynomial �N���X�̃T�u�N���X�ł��B
    
    �I�u�W�F�N�g(({obj0, obj1, ...}))�͕ϐ��̋�ʂ�
    ���i((|to_s|))�̒l�j�ɗ��p����邾���ł��B

    ���̃T�u�N���X�ɂ̓N���X���\�b�h�Ƃ���((|ground|))��
    ((|vars|))����`����A���ꂼ��A�W����((|ring|))�A�ϐ�
    �̔z���Ԃ��܂��B    
    
    �o�^���ꂽ�I�u�W�F�N�g (({obj0, obj1, ...})) �ŕ\�������
    �����ϐ���(({var(obj0)})), (({var(obj1)})),...
    �œ��邱�Ƃ��ł��܂��B���Ȃ킿(({vars == [var(obj0), var(obj1), ...]}))
    �ł��B
    
    �e�ϐ��̑召�֌W��(({obj0 > obj1 > ...}))�ƂȂ�܂��B�e�P����
    �̏�����((<::set_ord>))�Ŏw�肵�܂��B


    ��: �������W���Ƃ��鑽�����̐���
      require "m-polynomial"
      P = Algebra::MPolynomial.create(Integer, "x", "y", "z")
      x, y, z = P.vars
      p((-x + y + z)*(x + y - z)*(x - y + z))
      #=> -x^3 + x^2y + x^2z + xy^2 - 2xyz + xz^2 - y^3 + y^2z + yz^2 - z^3
      p P.ground #=> integer

--- ::vars([obj0 [, obj1 [, ...]]])
    ((*������1���Ȃ��Ƃ�*))�A���ɓo�^����Ă���S�Ă̕ϐ���
    �z��Ƃ��ĕԂ��܂��B
    
    ��:
      P = Algebra.MPolynomial(Integer, "x", "y", "z")
      p P.vars #=> [x, y, z]
    
    ((*����������1�ŕ�����ł���Ƃ�*))�A��������u�p��1��+�����̗�v
    �ɕ������A����ŕ\�������ϐ���o�^���܂��B�I�u�W�F�N�g����
    �ɓo�^����Ă���ΐV���ȓo�^�͂��܂���B�߂�l�͂��ꂼ��̃I
    �u�W�F�N�g�ɑΉ�����ϐ��̔z��ł��B
    
    ��: 
      P = Algebra.MPolynomial(Integer)
      x, y, z, w = P.vars("a0b10cd")
      p P.vars #=> [a0, b10, c, d]
      p [x, y, z, w] #=> [a0, b10, c, d]

    ((*����ȊO�̂Ƃ�*))�A�����ł���I�u�W�F�N�g
    (({obj0, obj1, ...})) �ŕ\�������ϐ�
    ��o�^���܂��B�I�u�W�F�N�g�����ɓo�^����Ă���ΐV���ȓo�^
    �͂��܂���B�߂�l��(({obj0, obj1, ...}))�ɑΉ�����ϐ�
    �̔z��ł��B

    ��:
      P = Algebra.MPolynomial(Integer)
      p P.vars("x", "y", "z") #=> [x, y, z]

--- ::mvar([obj0 [, obj1 [, ...]]])

    ((*������1���Ȃ��Ƃ�*))�A���ɓo�^����Ă���S�Ă̕ϐ���
    �z��Ƃ��ĕԂ��܂��B

    ((*����ȊO�̂Ƃ�*))�A�����ł���I�u�W�F�N�g
    (({obj0, obj1, ...})) �ŕ\�������ϐ�
    ��o�^���܂��B�I�u�W�F�N�g�����ɓo�^����Ă���ΐV���ȓo�^
    �͂��܂���B�߂�l�� (({obj0, obj1, ...})) �ɑΉ�����ϐ�
    �̔z��ł��B

--- ::to_ary
    (({[self, *vars]})) ��Ԃ��܂��B

    ��: �������ƕϐ��𓯎��ɒ�`����B
      P, x, y, z, w = Algebra.MPolynomial(Integer, "a", "b", "c", "d")

--- ::var(obj)
    ((|obj|)) �œo�^���ꂽ�I�u�W�F�N�g�ɂ���ĕ\�������ϐ���Ԃ��܂��B
    
    ��: 
      P = Algebra.MPolynomial(Integer, "X", "Y", "Z")
      x, y, z = P.vars
      P.var("Y") == y #=> true

--- ::variables
    ���ɓo�^����Ă���ϐ���\������I�u�W�F�N�g�̔z���Ԃ��܂��B

--- ::indeterminate(obj)
    ((<::var>)) �Ɠ����ł��B

--- ::zero?
    �댳�ł���Ƃ��^��Ԃ��܂��B

--- ::zero
    �댳��Ԃ��܂��B
    
--- ::unity
    �P�ʌ���Ԃ��܂��B

--- ::set_ord(ord [, v_ord])
    ((|ord|)) �ɒP�����������V���{���Ŏw�肵�܂��B�����Ƃ��ĉ\�Ȏw��
    �� (({:lex})) (����������(�f�t�H���g))�A(({:grlex})) (�����t������
    ������)�A(({:grevlex})) (�����t���t����������)��3�ł��B
    
    �e�ϐ��Ԃ̏����͓o�^���ꂽ���i��ɓo�^�����قǑ傫���j��
    �Ȃ�܂��B((|v_ord|)) �ɔz���^���Ă��̏��Ԃ�ύX���鎖��
    �ł��܂��B
    
    ��: (({x, y, z = P.var("xyz")})) �Ƃ����Ƃ��̏���
      require "m-polynomial"
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2

      P.set_ord(:lex)
      p f #=> -5x^3 + 7x^2z^2 + 4xy^2z + 4z^2

      f.method_cash_clear
      P.set_ord(:grlex)
      p f #=> 7x^2z^2 + 4xy^2z - 5x^3 + 4z^2

      f.method_cash_clear
      P.set_ord(:grevlex)
      p f #=> 4xy^2z + 7x^2z^2 - 5x^3 + 4z^2

      f.method_cash_clear
      P.set_ord(:lex, [2, 1, 0]) # z > y > x
      p f #=> 7x^2z^2 + 4z^2 + 4xy^2z - 5x^3

#    ((<::with_ord>)) ���Q�Ƃ��Ă��������B

--- ::order=(x)
    ((<::set_ord(x)>)) �Ɠ����ł��B

#--- ::order=(obj)
#    ((<::set_ord(obj)>)) �Ɠ����ł��B

--- ::get_ord
    �P��������(:lex, :grlex, :grevlex)��Ԃ��܂��B

--- ::ord
    ((<::get_ord>)) �Ɠ����ł��B

#--- ::order
#    ((<::get_ord>)) �Ɠ����ł��B

--- ::with_ord(ord [, v_ord[ [, array_of_polys]])
    ((|ord|)) ��P���������A((|v_ord|)) ��ϐ��̏����̕ϊ��z��Ƃ��āA
    �u���b�N�����s���܂��B
    �u���b�N�𔲂���ƈȑO�̏����ɖ߂�܂��B
    �������̔z�� ((|array_of_polys|)) ���^������΁A�����ɑ΂���
    ((<method_cash_clear>)) �����s����Ă���A�u���b�N�����s����܂��B
    (���̃u���b�N�̓X���b�h�Z�[�t�ł͂���܂���B)

    ��:
      require "m-polynomial"
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2

      P.with_ord(:lex, nil, [f]) do
        p f    #=> -5x^3 + 7x^2z^2 + 4xy^2z + 4z^2
        p f.lt #=> -5x^3
      end

      P.with_ord(:grlex, nil, [f]) do
        p f    #=> 7x^2z^2 + 4xy^2z - 5x^3 + 4z^2
        p f.lt #=> 7x^2z^2
      end

      P.with_ord(:grevlex, nil, [f]) do
        p f    #=> 4xy^2z + 7x^2z^2 - 5x^3 + 4z^2
        p f.lt #=> 4xy^2z
      end

      P.with_ord(:lex, [2, 1, 0], [f]) do # z > y > x
        p f    #=> 7x^2z^2 + 4z^2 + 4xy^2z - 5x^3
        p f.lt #=> 7x^2z^2
      end

    ((<::set_ord>)) ���Q�Ƃ��Ă��������B

--- ::monomial(ind[, c])
    multi-degree ((|ind|)) �ŁA�W���� ((|c|)) �̒P������Ԃ��܂��B
    �i�������A((<Algebra::MPolynomial::Monomial>)) �� extend
    ����Ă��Ȃ��B�j
    ((|c|)) ���ȗ������΁A�P�ʌ��Ƃ݂Ȃ���܂��B

#--- ::const(x)
#--- ::regulate(x)
#--- ::[](*x)
#--- ::method_cash_clear(*m)

== ���\�b�h:

--- monomial(ind[, c])
    ((<::monomial>)) �Ɠ����B

#--- each
#--- keys
#--- values
#--- [](ind)
#--- []=(ind, c)
#--- constant_coeff
#--- include?
#--- compact!
#--- rt!

--- constant?
    �萔(0����)�ł���Ƃ��A�^��Ԃ��܂��B

--- monomial?
    �P�����ł���Ƃ��A�^��Ԃ��܂��B

--- zero?
    ��ł���Ƃ��A�^��Ԃ��܂��B    

--- zero
    �댳��Ԃ��܂��B
    
--- unity
    �P�ʌ���Ԃ��܂��B

--- method_cash_clear
    ���̃��C�u�����́A�����v�Z���J��Ԃ����Ȃ��悤�Ɍ��ʂ�ۑ�
    ���Ă��܂����A������N���A���܂��B���̑���͒P���������̕�
    �X�Ȃǂ��s������ɕK�v�ɂȂ�܂��B
    
    ���ʂ��ۑ�����Ă��郁�\�b�h�́A
    ((<lc>)), ((<lm>)), ((<lt>)), ((<rt>)), ((<multideg>))
    �ł��B
    
    ��:
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2
      P.set_ord(:lex)
      p f.lt #=> -5x^3
      P.set_ord(:grlex)
      p f.lt #=> -5x^3
      f.method_cash_clear
      p f.lt #=> 7x^2z^2

--- ==(other)
    �������Ƃ��^��Ԃ��܂��B

--- <=>(other)
    �召�֌W�����߂܂��B

--- +(other)
    �a���v�Z���܂��B

--- -(other)
    �����v�Z���܂��B

--- *(other)
    �ς��v�Z���܂��B

--- **(n)
    ((|n|)) ����v�Z���܂��B

--- /(other)
    ((|other|)) ���A�萔(0����)�ł���Ƃ��A�����v�Z���܂��B

--- divmod(f0 [, f1 [,...]])
    ������ (({f0, f1,...})) �ɂ�銄��Z�����A���̔z��Ə�]���v�Z���܂��B

      P = Algebra.MPolynomial(Integer)
      x, y = P.vars("xy")
      f = x**2*y + x*y**2 + y**2
      f0 = x*y - 1
      f1 = y**2 - 1
      p f.divmod(f0, f1) #=> [[x + y, 1], x + y + 1]
      p f % [f0, f1]     #=> x + y + 1

--- %(others)
    ((|others|)) �𑽍����̔z��Ƃ����Ƃ��A����ɂ�銄��Z�̏�]��Ԃ��܂��B
    ����� (({divmod(*others)[1]})) �Ɠ����ł��B

--- multideg
    �i���d�j������Ԃ��܂��B
    
    ��: (lex �I�[�_�[��)
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.multideg #=> [3, 1]

--- totdeg
    �����i���d�����̘a�j��Ԃ��܂��B

    ��: (lex �I�[�_�[��)
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.totdeg   #=> 4

--- deg
    multideg �Ɠ����ł��B

--- lc
    �擪�W��(leading coeffcient)��Ԃ��܂��B

    ��: (lex �I�[�_�[��)
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.lc       #=> -5

--- lm
    �擪�P����(leading monomial)��Ԃ��܂��B
    ���̖߂�l��((<Algebra::MPolynomial::Monomial>))�Ƃ������W���[����
    extend ����܂��B

    ��: (lex �I�[�_�[��)
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.lm       #=> x^3y

--- lt
    �擪��(leading term)��Ԃ��܂��B(({lc * lm}))�Ɠ������l�������܂��B

    ��: (lex �I�[�_�[��)
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.lt       #=> -5x^3y

--- rt
    �c�]��(rest term)��Ԃ��܂��B(({self - lt}))�Ɠ������l�������܂��B

    ��: (lex �I�[�_�[��)
      f = 4*x*y**2*z + 4*z**2 - 5*x**3*y + 7*x**2*z**2
      p f.rt       #=> 4*z**2 - 5*x**3*y + 7*x**2*z**2

--- to_s
    ������\���𓾂܂��B�\���`����ς���ɂ�((|display_type|))��p���܂��B
    ((|display_type|))�ɗ^������l�� ((|:norm|))(�f�t�H���g), ((|:code|))
    �ł��B
    
    ��:
      P = Algebra.MPolynomial(Integer)
      x, y, z = P.vars("xyz")
      f = -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2
      p f #=> -5x^3 + 7x^2z^2 + 4xy^2z + 4z^2
      P.display_type = :code
      p f #=> -5*x**3 + 7*x**2*z**2 + 4*x*y**2*z + 4*z**2

--- map_to(ring[, vs]){|c, ind| ... }
    �������Ɋ܂܂��e�P�����ɂ��āA
    multi-degree �� ((|ind|))�A�W���� ((|c|)) �ɑ�����A
    ... ��]�����āA((|ring|)) ��Řa��������l��
    �Ԃ��܂��B((|vs|)) ���ȗ������� ((<::vars>)) �̒l���p����
    ��܂��B
    (({f}))��(({P}))��̑������Ȃ�A
    (({f.map_to(P) {|c, ind| c * P.monomial(ind)}})) �� (({f}))�ƈ�v���܂��B

--- project(ring[, vs]){|c, ind| ... }
    �������Ɋ܂܂��e�P�����ɂ��āA
    multi-degree �� ((|ind|))�A�W���� ((|c|)) �ɑ�����A
    ... ��]������((|ind|))���̒P�����Ɋ|���āA
    ((|ring|)) ��Řa��������l��
    �Ԃ��܂��B((|vs|)) ���ȗ������� ((<::vars>)) �̒l���p����
    ��܂��B

    (({f}))��(({P}))��̑������Ȃ�A
    (({f.map_to(P) {|c, ind| c}})) �� (({f}))�ƈ�v���܂��B

    (({project(ring){|c, ind| f(c, ind)}})) �� (({map_to(ring){|c, ind| f(c, ind) * self.class.monomial(ind)}}))�Ɉ�v���܂��B
    
    ��:
      require "m-polynomial"
      require "rational"
      P = Algebra::MPolynomial(Integer, "x", "y", "z")
      x, y, z = P.vars
      f = x**2 + 2*x*y - z**3
      PQ = Algebra::MPolynomial(Rational, "x", "y", "z")
      p f.project(PQ) {|c, ind| Rational(c) / (ind[0] + 1)}
                        #=> 1/3x^2 + xy - z^3
      p f.convert_to(PQ)      #=> x^2 + 2xy - z^3

--- evaluate(obj0[, [obj1, [obj2,..]]])
    �e�ϐ��� ((|obj0, obj1, obj2,...|)) ���������l��Ԃ��܂��B
    ((<project>))(({(ground, [obj0, obj1, obj2,..]){|c, ind| c}}))
    �̒l�ƈ�v���܂��B

    ��:
      require "m-polynomial"
      P = Algebra::MPolynomial(Integer, "x", "y", "z")
      x, y, z = P.vars
      f = x**2 + 2*x*y - z**3
      p f.evaluate(1, -1, -1) #=> 0 (in Integer)
      p f.evaluate(y, z, x)   #=> -x^3 + y^2 + 2yz (in P)

--- call(obj0[, [obj1, [obj2,..]]])
    ((<evaluate>))�Ɠ����ł��B

--- sub(var, value)
    �ϐ� ((|var|)) �� ((|value|)) ���������l��Ԃ��܂��B

    ��:
      require "m-polynomial"
      P = Algebra::MPolynomial(Integer)
      x, y, z = P.vars("x", "y", "z")
      f = (x - y)*(y - z - 1)
      p f.sub(y, z+1)    #=> 0

--- convert_to(ring)
    �e����((|ring|))��ŕ]�����܂��B((<project>))(({(ring){|c, ind| c}}))��
    �l�ƈ�v���܂��B

--- derivate(var)
    ((<var>))�ł̕Δ�����Ԃ��܂��B
    
= Algebra::MPolynomial::Monomial
(�P�����̐������W�߂����W���[��)

((<lt>)), ((<lm>)) �̖߂�l�ł��鑽�����ɂ͂��̃��W���[����extend����܂��B

== ���\�b�h:

#--- ind
#--- coeff
#--- <=>(other)
--- divide?(other)
    �P���� ((|other|)) �Ŋ���؂��Ƃ��^��Ԃ��܂��B

--- /(other)
    �P���� ((|other|)) �Ŋ���؂�܂��B

--- prime_to?(other)
    �P���� ((|other|)) �Ƒf�ȂƂ��^��Ԃ��܂��B

--- lcm(other)
    �P���� ((|other|)) �Ƃ̍ŏ����{���ł���P������Ԃ��܂��B

--- divide_or?(other0, other1)
    ((|divide?(other0.lcm(other1))|)) �Ɠ����l��Ԃ��܂��B


= Algebra::MPolynomialFactorization
((*(�����������W���[��)*))

�������������邽�߂̃��W���[���ł��B

== �t�@�C����:
((|m-polynomial-factor.rb|))

== ���\�b�h:
--- factorize
    �����������܂��B
    
    ���������\�ȌW����
    * Integer
    * Rational
    * �f��

    �ł��B


= Algebra::Groebner
(�O���u�i���v�Z���W���[��)

== �t�@�C����:
* ((|groebner-basis.rb|))
* ((|groebner-basis-coeff.rb|))

== �N���X���\�b�h:

--- Groebner.basis(f)
    ���̔z�� ((|f|)) ����Ȗ�O���u�i�������A�z��Ƃ��ĕԂ��܂��B
    ((<Groebner.basis(Groebner.minimal_basis(Groebner.basis_159A(f)))>))
    �Ɠ����ł��B

    ��:
      require "m-polynomial"
      require "rational"
      P = Algebra.MPolynomial(Rational)
      P.set_ord :grevlex
      x, y, z = P.vars("xyz")
      f1 = x**2 + y**2 + z**2 -1
      f2 = x**2 + z**2 - y
      f3 = x - z
      b = Groebner.basis([f1, f2, f3])
      p b #=> [y^2 + y - 1, z^2 - 1/2y, x - z]

--- Groebner.basis_159A(f)
    ���̔z�� ((|f|)) ����O���u�i�������z��Ƃ��ĕԂ��܂��B

--- Groebner.minimal_basis(f)
    �O���u�i���̔z�� ((|f|)) ����ɏ��O���u�i���̔z������Ԃ��܂��B

--- Groebner.reduced_basis(f)
    �ɏ��O���u�i���̔z�� ((|f|)) ����Ȗ�O���u�i���̔z������Ԃ��܂��B

--- Groebner.basis_coeff(f)
    ���̔z�� ((|f|)) ����Ȗ�O���u�i���̔z��ƁA�e���𐶐�
    ���邽�߂̌W����Ԃ��܂��B
    
    ��:
      require "m-polynomial"
      require "rational"
      P = Algebra.MPolynomial(Rational)
      P.set_ord :grevlex
      x, y, z = P.vars("xyz")
      f1 = x**2 + y**2 + z**2 -1
      f2 = x**2 + z**2 - y
      f3 = x - z
      fs = [f1, f2, f3]
      c, b = Groebner.basis_coeff(fs)
      p b #=> [y^2 + y - 1, z^2 - 1/2y, x - z]
      p c #=> [[1, -1, 0], [0, 1/2, -1/2x - 1/2z], [0, 0, 1]]
      for i in 0..2
        p c[i].inner_product(fs) == b[i] #=> true
      end

--- Groebner.basis?(f)
    ((|f|)) ���O���u�i���̔z�񂩔ۂ���Ԃ��܂��B
    
--- Groebner.minimal_basis?(f)
    ((|f|)) ���ɏ��O���u�i���̔z�񂩔ۂ���Ԃ��܂��B
    
--- Groebner.reduced_basis?(f)
    ((|f|)) ���ɏ��O���u�i���̔z�񂩔ۂ���Ԃ��܂��B
    
== ���\�b�h:
--- S_pair(other)
    ((|other|)) �Ƃ� S-pair �����܂��B
    
    ��:
      (x**2*y + y**2 + z**2 -1).S_pair(x**2*z + z**2 - y)
        #=> y^2z + y^2 - yz^2 + z^3 - z

--- divmod_s(f1[, f2[, f3...]])
    ��� (({f1, f2, f3, ...})) �Ŋ��������i�e���̌W���̔z��j
    �Ɨ]�� (({[[q1, q2, q3, ...], r]})) ��Ԃ��܂��B
    
    ��x (({f1, f2, f3, ...})) ���O���u�i���ɕϊ����Ă���
    ����Z���s���̂ŁA(({divmod(f1, f2, ...).last == 0})) �� ((|self|)) ��
    �C�f�A�� (({(f1, f2, ...)})) �ɑ����邱�Ƃ͓��l�ł��B
    
    ��:
      require "m-polynomial"
      require "rational"
      P = Algebra.MPolynomial(Rational)
      P.set_ord :grevlex
      x, y, z = P.vars("xyz")
      f1 = x**2 + y**2 + z**2 -1
      f2 = x**2 + z**2 - y
      f3 = x - z
      fs = [f1, f2, f3]
      f = x**3 + y**3 + z**3
      c, r = f.divmod_s(*fs)
      p r #=> yz + 2y - 1
      p c #=> [y - 1, -y + z + 1, x^2]
      p f == c.inner_product(fs) + r #=> true

--- div_cg(f, cg)
    ���̔z�� ((|f|)) ���� ((<Groebner.basis_coeff>))(f)
    �ŋ��߂��l ((|cg|)) ��p����((|self|)) ����� ((|f|)) ��
    ���������i�e���̌W���̔z��j�Ɨ]�� (({[q, r]})) ��Ԃ��܂��B
    ((<divmod_s>))(f) ��
    (({div_cg(f, Groebner.basis_coeff(f))})) ��Ԃ��Ă��܂��B

=end
