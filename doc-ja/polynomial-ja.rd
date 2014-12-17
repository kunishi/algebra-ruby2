=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::Polynomial>))
/
((<Algebra::PolynomialFactorization>))
/
((<Algebra::SplittingField>))
/
((<Algebra::Galois>))

= Algebra::Polynomial
((*(1�ϐ��������N���X)*))

1�ϐ��̑�������\�����܂��B���ۂ̃N���X�𐶐�����ɂ͊��w�肵�āA�N���X���\�b�h ((<::create>)) ���邢�͊֐� ((<Algebra.Polynomial>))() ��p���܂��B

== �t�@�C����:
* ((|polynomial.rb|))

== �X�[�p�[�N���X:

* ((|Object|))

== �C���N���[�h���Ă��郂�W���[��:

* ((|Enumerable|))
* ((|Comparable|))
* ((<Algebra::EuclidianRing|URL:euclidian-ring-ja.html>))
* ((<Algebra::PolynomialFactorization>))
* ((<Algebra::SplittingField>))
* ((<Algebra::Galois>))

== �֘A���郁�\�b�h:

--- Algebra.Polynomial(ring [, obj0 , obj1 [, ...]])
    ((<::create>))(ring, obj0[, obj1 [, ...]])> �ɓ����B

== �N���X���\�b�h:

--- ::create(ring, obj0[, obj1[, ...]])
    ((|ring|)) �ŕ\�������N���X���W���Ƃ��鑽�����N���X��
    �������܂��B
    
    (({obj0, obj1, ...})) �Ŏw�肳�ꂽ�I�u�W�F�N�g���ϐ���
    �\�����A���ꂪ�����Ȃ�΁A�ċA�I�ɑ�������̑���
    ���𐶐����܂��B

    ���̃��\�b�h�̖߂�l�� Polynomial �N���X�̃T�u�N���X
    �ł��B���̃T�u�N���X�ɂ̓N���X���\�b�h�Ƃ��� ((|ground|)) ��
    ((|var|))�A((|vars|)) ����`����A���ꂼ��A�W���� ((|ring|))�A
    ��ϐ��I�u�W�F�N�g�i�Ō�Ɏw�肳�ꂽ�ϐ��j�A�S�Ă̕ϐ��I
    �u�W�F�N�g��Ԃ��܂��B

    �I�u�W�F�N�g(({obj0, obj1, ...}))�͕ϐ��̖��i((|to_s|))�̒l�j
    �ɗ��p����邾���ł��B
        
    ��: �������W���Ƃ��鑽�����̐���
      require "polynomial"
      P = Algebra::Polynomial.create(Integer, "x")
      x = P.var
      p((x + 1)**100) #=> x^100 + 100x^99 + ... + 100x + 1
      p P.ground #=> integer


    ��: �������W���Ƃ��镡���ϐ��������̐���
      require "polynomial"
      P = Algebra::Polynomial.create(Integer, "x", "y", "z")
      x, y, z = P.vars
      p((-x + y + z)*(x + y - z)*(x - y + z))
      #=> -z^3 + (y + x)z^2 + (y^2 - 2xy + x^2)z - y^3 + xy^2 + x^2y - x^3
      p P.var #=> z
    
    ���̗�� (({P})) ��

      Algebra::Polynomial.create(
        Algebra::Polynomial.create(
          Algebra::Polynomial.create(
            Integer,
          "x"),
        "y"),
      "z")

    �Ɠ��l�ŁA�Ō�̕ϐ� ((|z|)) ����ϐ��ƂȂ�܂��B

--- ::var
    �������̕ϐ��i��ϐ��j��Ԃ��܂��B

--- ::vars
    �ċA�I�Ɋe�������̕ϐ����W�߂��z���Ԃ��܂��B

--- ::mvar
    ((<::vars>)) �Ɠ����ł��B

--- ::to_ary
    (({[self, *vars]})) ��Ԃ��܂��B

    ��: �������ƕϐ��𓯎��ɒ�`����B
      P, x, y, z = Algebra::Polynomial.create(Integer, "x", "y", "z")

--- ::variable
    �ϐ��i��ϐ��j��\������I�u�W�F�N�g��Ԃ��܂��B

--- ::variables
    �ċA�I�Ɋe�������̕ϐ���\������I�u�W�F�N�g��
    �W�߂��z���Ԃ��܂��B

--- ::indeterminate(obj)
    ((|obj|)) �ŕ\�������ϐ����ċA�I�ɒT���ĕԂ��܂��B

--- ::monomial([n])
    ((|n|)) ���̒P������Ԃ��܂��B
    
    ��:
      P = Algebra::Polynomial(Integer, "x")
      P.monomial(3) #=> x^3

--- ::const(c)
    �l ((|c|)) �̒萔����Ԃ��܂��B

    ��:
      P = Algebra::Polynomial(Integer, "x")
      P.const(3)      #=> 3
      P.const(3).type #=> P

--- ::zero
    �댳��Ԃ��܂��B
    
--- ::unity
    �P�ʌ���Ԃ��܂��B

#--- ::euclidian?

== ���\�b�h:

--- var
    ((<::var>)) �Ɠ����ł��B

--- variable
    ((<::variable>)) �Ɠ����ł��B

--- each(&b)
    �e���̌W�������p���ɌJ��Ԃ��܂��B
    
    ��:
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      (x**3 + 2*x**2 + 4).each do |c|
        p c #=> 4, 0, 2, 1
      end

--- reverse_each(&b)
    �e���̌W�����~�p���ɌJ��Ԃ��܂��B

    ��:
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      (x**3 + 2*x**2 + 4).reverse_each do |c|
        p c #=> 1, 2, 0, 4
      end

--- [](n)
    ((|n|)) ���̌W����Ԃ��܂��B

--- []=(n, v)
    ((|n|)) ���̌W����((|v|))�ɐݒ肵�܂��B

--- monomial
    ((<::monomial>)) �Ɠ����ł��B

--- monomial?
    �P�����ł���Ƃ��^��Ԃ��܂��B

--- zero?
    �댳�ł���Ƃ��^��Ԃ��܂��B

--- zero
    �댳��Ԃ��܂��B
    
--- unity
    �P�ʌ���Ԃ��܂��B

#--- variable=(bf)
#--- size
#--- compact!
#--- ground_div(n, d)

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
    �����v�Z���܂��B((<div>))�Ɠ����ł��B

--- divmod(other)
    ((|other|)) �Ŋ��������Ɨ]��̔z���Ԃ��܂��B

--- div(other)
    ((|other|)) �Ŋ���������Ԃ��܂��B(({divmod(other).first}))
    �ƈ�v���܂��B

--- %(other)
    ((|other|)) �Ŋ������]���Ԃ��܂��B(({divmod(other).last}))
    �ƈ�v���܂��B

--- divide?(other)
    ((|other|)) �Ŋ���؂��Ƃ��^��Ԃ��܂��B
    (({divmod(other).last == zero?}))�ƈ�v���܂��B

--- deg
    ������Ԃ��܂��B

    ��:
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      (5*x**3 + 2*x + 1).deg #=> 3

--- lc
    �擪�W��(leading coeffcient)��Ԃ��܂��B

    ��:
      (5*x**3 + 2*x + 1).lc #=> 5

--- lm
    �擪�P����(leading monomial)��Ԃ��܂��B

    ��:
      (5*x**3 + 2*x + 1).lm #=> x**3

--- lt
    �擪��(leading term)��Ԃ��܂��B(({lc * lm}))�Ɠ������l�������܂��B

    ��:
      (5*x**3 + 2*x + 1).lt #=> 5*x**3

--- rt
    �c�]��(rest term)��Ԃ��܂��B(({self - lt}))�Ɠ������l�������܂��B

    ��:
      (5*x**3 + 2*x + 1).rt #=> 2*x + 1

--- monic
    �ō����W����1�ɒ���������Ԃ��܂��B(({self / lc})) �Ɠ����l����
    ���܂��B

--- cont
    �W����(content(�S�Ă̌W���̍ő����)�j��Ԃ��܂��B

--- pp
    ���n�I����(primitive part)��Ԃ��܂��B(({self / cont}))��
    �����l�������܂��B

--- to_s
    ������\���𓾂܂��B�\���`����ς���ɂ� ((|display_type|)) ��p���܂��B
    ((|display_type|)) �ɗ^������l�� ((|:norm|))(�f�t�H���g), ((|:code|))
    �ł��B
    
    ��:
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      p 5*x**3 + 2*x + 1 #=>5x^3 + 2x + 1
      P.display_type = :code
      p 5*x**3 + 2*x + 1 #=> 5*x**3 + 2*x + 1

--- derivate
    ���������l��Ԃ��܂��B
    
    ��:
      (5*x**3 + 2*x + 1).derivate #=> 15*x**2 + 2

--- sylvester_matrix(other)
    ((|other|)) �Ƃ̃V���x�X�^�[�s���Ԃ��܂��B

--- resultant(other)
    ((|other|)) �Ƃ̏W�����Ԃ��܂��B�\��

--- project(ring[, obj]){|c, n| ... }
    �e�P�����ɂ��āA
    ������ ((|n|)) �ɁA�W�� ((|c|)) �ɑ���� ... ��]���������̂�
    ���̒P�����̒l�ɒu�������A((|ring|)) ��Řa��������l��
    �Ԃ��܂��B((|obj|)) ���ȗ������� (({ring.var})) ���p����
    ��܂��B
    
    ��:
      require "polynomial"
      require "rational"
      P = Algebra::Polynomial(Integer, "x")
      PQ = Algebra::Polynomial(Rational, "y")
      x = P.var
      f = 5*x**3 + 2*x + 1
      p f.convert_to(PQ) #=> 5y^3 + 2y + 1
      p f.project(PQ) {|c, n| Rational(c) / (n + 1)} #=> 5/4y^3 + y + 1

--- evaluate(obj)
    ��ϐ��� ((|obj|)) ���������l��Ԃ��܂��B
    (({ project(ground, obj){|c, n| c} })) �̒l�ƈ�v���܂��B

    ��:
      require "polynomial"
      P = Algebra::Polynomial(Integer, "x")
      x = P.var
      f = x**3 - 3*x**2 + 1
      p f.evaluate(-1)    #=> -3 (in Integer)
      p f.evaluate(x + 1) #=> x^3 - 3x - 1 (in P)

--- call(obj)
    ((<evaluate>))�Ɠ����ł��B

--- sub(var, value)
    �ϐ� ((|var|)) �� ((|value|)) ���������l��Ԃ��܂��B

    ��:
      require "polynomial"
      P = Algebra::Polynomial(Integer, "x", "y", "z")
      x, y, z = P.vars
      f = (x - y)*(y - z - 1)
      p f.sub(y, z+1)    #=> 0

--- convert_to(ring)
    �e����((|ring|))��ŕ]�����܂��B(({ project(ring){|c, n| c} }))��
    �l�ƈ�v���܂��B

= Algebra::PolynomialFactorization
((*(�����������W���[��)*))

�������������邽�߂̃��W���[���ł��B

== �t�@�C����:
((|polynomial-factor.rb|))

== ���\�b�h:

--- sqfree
    �����������܂��B

--- sqfree?
    �������Ȃ�^��Ԃ��܂��B

--- irreducible?
    ����Ȃ�^��Ԃ��܂��B

--- factorize
    �����������܂��B
    
    ���������\�ȌW����
    * Integer
    * Rational
    * �f��
    * �㐔�́iRational ��̗L�����g��j
    �ł��B


= Algebra::SplittingField
((*(����̃��W���[��)*))

�������̍ŏ�����̂����߂邽�߂̃��W���[��


== �t�@�C����:
* ((|splitting-field.rb|))


== ���\�b�h:


--- decompose([fac0])
    ���g�̍ŏ�����̂� ((|field|))�A�g��ɗv�������񑽍���
    �̔z��� ((|def_polys|))�A�ŏ�����̏��1�����̐ςɈ���������
    �����̂� ((|facts|))�A�������̍��̔z��� ((|roots|))�A
    ((|roots|)) ����b�̂ɓY�����������O�ɗ���悤�ɕ��בւ���
    �̔z��� ((|proots|)) �Ƃ��āA

      [field, def_polys, facts, roots, proots]

    ��Ԃ��܂��B��b�̏�̈������� ((|fac0|)) ��Y����ƍ������ɖ𗧂��܂��B
    �i((|facts|)) �̗v�f�� ((|fact0|)) �� ((|Algebra::Factors|)) �I�u�W�F�N�g
    �A((|field|)) ��
    ((<AlgebraicExtensionField|algebraic-extension-field.html>))
    �I�u�W�F�N�g�ł��B�������A���g���ꎟ���q�ɕ��������Ƃ���
    ((<groud>)) ���̂��̂�Ԃ��܂��B

    ��:
      require "algebra"
      PQ = Polynomial(Rational, "x")
      x = PQ.var
      f = x**5 - x**4 + 2*x - 2
      field, def_polys, facts, roots, proots = f.decompose
      p def_polys #=> [a^4 + 2, b^2 + a^2]
      p facts    #=> (x - 1)(x - a)(x + a)(x - b)(x + b)
      p roots    #=> [1, a, -a, b, -b]
      p proots   #=> [a, b, 1, -a, -b]
      fp = Polynomial(field, "x")
      x = fp.var
      facts1 = Factors.new(facts.collect{|g, n| [g.call(x), n]})
      p facts1.pi == f.convert_to(fp) #=> true

--- splitting_field([fac0]))
    ���g�̍ŏ�����̂̏���Ԃ��܂��B�Ԃ�l�̊e�t�B�[���h�̒l�͈ȉ�
    �̒ʂ�ł��Bpoly_exps �ȊO�� ((<decompose>)) �̈ȉ��̂��̂ɑ������܂��B

    poly, field, roots, proots, def_polys

    �������A((|roots|))�A((|proots|)) �̊e�v�f�� ((|field|)) ��
    �v�f�Ƃ��ĕϊ�����Ă��܂��B
    
    ��:
      require "algebra"
      PQ = Polynomial(Rational, "x")
      x = PQ.var
      f = x**5 - x**4 + 2*x - 2
      sf = f.splitting_field
      p sf.roots     #=> [1, a, -a, b, -b]
      p sf.proots     #=> [a, b, 1, -a, -b]
      p sf.def_polys #=> [a^4 + 2, b^2 + a^2]

= Algebra::Galois
((*(�K���A�Q)*))

�������̃K���A�Q�����߂邽�߂̃��W���[��

== �t�@�C����:
* ((|galois-group.rb|))

== �C���N���[�h���Ă��郂�W���[��:
* �Ȃ�

== �֘A���郁�\�b�h:

--- GaloisGroup.galois_group(poly)
    ((<galois_group>)) �Ɠ���

== ���W���[�����\�b�h:
* �Ȃ�

== ���\�b�h:

--- galois_group
    �������̃K���A�Q��Ԃ��܂��B�Q�͊e���� 
    ((<PermutationGroup|permutation-group.html>)) �ł��� 
    ((<FiniteGroup|finite-group.html>)) �I�u�W�F�N�g�Ƃ��ĕ\������܂��B

    ��:
      require "rational"
      require "polynomial"

      P = Algebra.Polynomial(Rational, "x")
      x = P.var
      p( (x**3 - 3*x + 1).galois_group.to_a )
      #=>[[0, 1, 2], [1, 2, 0], [2, 0, 1]]

      (x**3 - x + 1).galois_group.each do |g|
        p g
      end
      #=> [0, 1, 2]
      #   [1, 0, 2]
      #   [2, 0, 1]
      #   [0, 2, 1]
      #   [1, 2, 0]
      #   [2, 1, 0]

=end
