########################################################################
#                                                                      #
#   finite-set.rb                                                      #
#                                                                      #
########################################################################
=begin
[((<index-ja|URL:index-ja.html>))] 
[((<finite-map-ja|URL:finite-map-ja.html>))] 
((<Algebra::Set>))
/
((<Enumerable>))

= Algebra::Set
((*�W���̃N���X*))

�W����\������N���X�ł��B�Q�̏W�� ((|s|)), ((|t|)) �Ɋւ��āA
((|s|)) �� ((|t|)) �Ɋ܂܂�鎖�� ((<all?>)) ���g���āA

  s.all?{|x| t.member?(x)}

�ŕ\������܂��B

== �t�@�C����:
* ((|finite-set.rb|))

== �X�[�p�[�N���X:
* ((|Object|))

== �C���N���[�h���Ă��郂�W���[��:

* ((|Enumerable|))

== �N���X���\�b�h:

--- ::[]([obj0, [obj1, [obj2, ...]]])
    �����̗񂩂� ((|Set|)) �I�u�W�F�N�g�𐶐����܂��B
    
    ��: �S�� {"a", [1, 2], 0} �𐶐�����B
      require "finite-set"
      p Algebra::Set[0, "a", [1, 2]]
      p Algebra::Set.new(0, "a", [1, 2])
      p Algebra::Set.new_a([0, "a", [1, 2]])
      p Algebra::Set.new_h({0=>true, "a"=>true, [1, 2]=>true})
    
--- ::new([obj0, [obj1, [obj2, ...]]])
    �����̗񂩂� ((|Set|)) �I�u�W�F�N�g�𐶐����܂��B

--- ::new_a(a)
    �z�� ((|a|)) ���� ((|Set|)) �I�u�W�F�N�g�𐶐����܂��B

--- ::new_h(h)
    ((|Hash|)) ���� ((|Set|)) �I�u�W�F�N�g�𐶐����܂��B

--- self.empty_set
    ��W���𐶐�����B

--- ::phi
--- ::null
    ((<::empty_set>)) �̃G�C���A�X�ł��B


--- ::singleton(x)
    ((|x|)) �ꌳ�݂̂ō\�������W���𐶐����܂��B

== ���\�b�h:

--- empty_set
    ��W���𐶐�����B

--- phi
--- null
    ((<empty_set>)) �̃G�C���A�X�ł��B

--- empty?
    ��W���ł���Ƃ��^��Ԃ��܂��B

--- phi?
--- empty_set?
--- null?
    ((<empty?>)) �̃G�C���A�X�ł��B

--- singleton(x)
    ((|x|)) �ꌳ�݂̂ō\�������W���𐶐����܂��B

--- singleton?
    �ꌳ�݂̂ō\�������W���ł���Ƃ��^��Ԃ��܂��B

--- size
    �W���̑傫����Ԃ��܂��B

--- each
    �W���̊e�v�f�Ɋւ��ČJ��Ԃ��܂��B�J��Ԃ��̏��Ԃ͕s��ł��B

    ��: 
      require "finite-set"
      include Algebra
      Set[0, 1, 2].each do |x|
        p x #=> 1, 0, 2
      end

--- separate
    �W���̊e�v�f���u���b�N�p�����[�^�ɓn���A�u���b�N�̒l��^�ɂ���
    ���̂ō\�������W����Ԃ��܂��B

    ��: 
      require "finite-set"
      include Algebra
      p Set[0, 1, 2, 3].separate{|x| x % 2 == 0} #=> {2, 0}

--- select_s
--- find_all_s
    ((<separate>)) �̃G�C���A�X�ł��B

--- map_s
    �W���̊e�v�f���u���b�N�p�����[�^�ɓn���A�u���b�N�̒l�ɂ����
    �\�������W����Ԃ��܂��B

    ��: 
      require "finite-set"
      include Algebra
      p Set[0, 1, 2, 3].map_s{|x| x % 2 + 1} #=> {2, 1}

--- pick
    �W���̗v�f�����I��Œl�Ƃ��܂��B�ǂ̗v�f���I�΂�邩��
    �s��ł��B��W���ɑ΂��Ă� ((|nil|)) ��Ԃ��܂��B

--- shift
    �W���̗v�f�����I��Ŏ��o���l�Ƃ��܂��B�ǂ̗v�f���I�΂��
    ���͕s��ł��B

    ��: 
      require "finite-set"
      include Algebra
      s = Set[0, 1, 2, 3]
      p s.shift #=> 2
      p s #=> {0, 1, 3}

--- dup
    �W���̕�����Ԃ��܂��B�i������ Hash �̕����ɂ��܂��B�j

--- append!(x)
    �W���ɗv�f ((|x|)) ��t�������܂��B�Ԃ�l�� ((|self|)) �ł��B

--- push
--- <<
    ((|append!|)) �̃G�C���A�X�ł��B

--- append(x)
    �W���ɗv�f ((|x|)) ��t��������������Ԃ��܂��B

--- concat(other)
    �W���ɕʂ̏W�� ((|other|)) �̗v�f��t�������܂��B
    �i((|+|)) �̔j��łł��B�j

--- rehash
    ������ ((|Hash|)) �I�u�W�F�N�g�� ((|rehash|)) ���܂��B

--- eql?(other)
    �W�� ((|other|)) �Ɠ������Ƃ��A�^��Ԃ��܂��B
    (({ self >= other and self <= other})) �Ɠ��l�ł��B

--- ==
    ((<eql?>)) �̃G�C���A�X�ł��B

--- hash
    ���g�� ((|Hash|)) ���邢�� ((|Set|)) �̗v�f�ƂȂ�Ƃ��ɗ��p�����
    �n�b�V���l�֐��ł��B

--- include?(x)
    �W���� ((|x|)) ��v�f�Ƃ��Ă���Ƃ��A�^��Ԃ��܂��B

--- member?
--- has?
--- contains?
    ((<include?>)) �̃G�C���A�X�ł��B

--- superset?(other)
    �W�������̏W�� ((|other|)) ���܂���Ƃ��^��Ԃ��܂��B
    (({other.all{|x| member?(x)}})) �Ɠ��l�ł��B

--- >=
--- incl?
    (({superset?})) �̃G�C���A�X�ł��B

--- subset?(other)
    �W�������̏W�� ((|other|)) �̕����W���ł���Ƃ��^��Ԃ��܂��B
    (({self.all{|x| other.member?(x)}})) �Ɠ��l�ł��B

--- <=
--- part_of?
    ((|subset?|)) �̃G�C���A�X�ł��B

--- <(other)
    ((|self|)) �� ((|other|)) �̐^�����W���̎��^��Ԃ��܂��B

--- >(other)
    ((|self|)) �� ((|other|)) ��^�Ɋ܂ގ��^��Ԃ��܂��B

--- union([other])
    ((|self|)) �� ((|other|)) �̍����W����Ԃ��܂��B
    ((|other|)) ���ȗ����ꂽ�ꍇ�A���g���W���̏W���Ƃ݂Ȃ��A�S�Ă�
    �v�f�̍�����Ԃ��܂��B
    
    ��:
      require "finite-set"
      include Algebra
      p Set[0, 2, 4].cup Set[1, 3] #=> {0, 1, 2, 3, 4}
      s = Set[*(0...15).to_a]
      s2 = s.separate{|x| x % 2 == 0}
      s3 = s.separate{|x| x % 3 == 0}
      s5 = s.separate{|x| x % 5 == 0}
      p Set[s2, s3, s5].union #=> {1, 7, 11, 13}

--- |
--- +
--- cup
    ((|union|)) �̃G�C���A�X�ł��B

--- intersection([other])
    ((|self|)) �� ((|other|)) �̌����̏W����Ԃ��܂��B
    ((|other|)) ���ȗ����ꂽ�ꍇ�A���g���W���̏W���Ƃ݂Ȃ��A�S�Ă�
    �v�f�̋��ʕ�����Ԃ��܂��B

    ��:
      require "finite-set"
      include Algebra
      p Set[0, 2, 4].cap(Set[4, 2, 0]) #=> {0, 2, 4}
      s = Set[*(0..30).to_a]
      s2 = s.separate{|x| x % 2 == 0}
      s3 = s.separate{|x| x % 3 == 0}
      s5 = s.separate{|x| x % 5 == 0}
      p Set[s2, s3, s5].cap #=> {0, 30}

--- &
--- cap
    ((|intersection|)) �̃G�C���A�X�ł��B


--- difference(other)
    ((|self|)) ���� ((|other|)) �Ɋ܂܂��v�f����菜�������̂�Ԃ��܂��B

--- -
    ((|difference|)) �̃G�C���A�X�ł��B


--- each_pair
    �W������قȂ�Q�̗v�f�����o���āA�u���b�N�p�����[�^��
    ������ČJ��Ԃ��܂��B

    ��: 
      require "finite-set"
      include Algebra
      s = Set.phi
      Set[0, 1, 2].each_pair do |x, y|
        s.push [x, y]
      end
      p s == Set[[0, 1], [0, 2], [1, 2]] #=> true

--- each_member(n)
    �W������قȂ� ((|n|)) �̗v�f�����o���āA�u���b�N�p�����[�^��
    ������ČJ��Ԃ��܂��B

    ��: 
      require "finite-set"
      include Algebra
      s = Set.phi
      Set[0, 1, 2].each_member(2) do |x, y|
        s.push [x, y]
      end
      p s == Set[[0, 1], [0, 2], [1, 2]] #=> true

--- each_subset
    �W���̑S�Ă̕����W�����u���b�N�p�����[�^�ɑ�����ČJ��Ԃ��܂��B

    ��: 
      require "finite-set"
      include Algebra
      s = Set.phi
      Set[0, 1, 2].each_subset do |t|
        s.append! t
      end
      p s.size = 2**3 #=> true

--- each_non_trivial_subset
    �W���̋�W���łȂ��^�����W�����u���b�N�p�����[�^�ɑ�����ČJ��Ԃ��܂��B

--- power_set
    �W���̑S�Ă̕����W���̏W����Ԃ��܂��B

--- each_product(other)
    ((|self|)) �� ((|other|)) �̑S�Ă̗v�f ((|x|)), ((|y|)) ��
    ���āA�J��Ԃ��܂��B

   ��:
      require "finite-set"
      include Algebra
      Set[0, 1].each_prodct(Set[0, 1]) do |x, y|
        p [x, y] #=> [0,0], [0,1], [1,0], [1,1]
      end

--- product(other)
    ((|self|)) �� ((|other|)) �̐ϏW����Ԃ��܂��B�ϏW���̊e��
    �͔z�� (({[x, y]})) �ł��B�u���b�N���^����ꂽ���́A�u���b�N
    ��]�������l�ō\�������W����Ԃ��܂��B

    ��: 
      require "finite-set"
      include Algebra
      p Set[0, 1].product(Set[0, 1]) #=> {[0,0], [0,1], [1,0], [1,1]}
      p Set[0, 1].product(Set[0, 1]){|x, y| x + 2*y} #=> {0, 1, 2, 3]

--- *
    ((<product>)) �̃G�C���A�X�ł��B

--- equiv_class([equiv])
    �W���𓯒l�֌W�Ŋ��������W����Ԃ��܂��B���l�֌W�̗^�����͎��̂R�ʂ肠��܂��B
    
    (1) �u���b�N�̕]���l��^�ɂ��铯�l�֌W
          require "finite-set"
          include Algebra
          s = Set[0, 1, 2, 3, 4, 5]
          p s.equiv_class{|a, b| (a - b) % 3 == 0} #=> {{0, 3}, {1, 4}, {2, 5}}
    (2) �����ɗ^����ꂽ�I�u�W�F�N�g�ɑ΂��郁�\�b�h ((|call(x, y)|)) 
        �̐^�U�l�ɂ�铯�l�֌W
          require "finite-set"
          include Algebra
          o = Object.new
          def o.call(x, y)
            (x - y) % 3 == 0
          end
          s = Set[0, 1, 2, 3, 4, 5]
          p s.equiv_class(o) #=> {{0, 3}, {1, 4}, {2, 5}}
    (3) �����ɗ^����ꂽ ((|Symbol|)) �ɉ��������\�b�h�ɂ�铯�l�֌W
          require "finite-set"
          include Algebra
          s = Set[0, 1, 2, 3, 4, 5]
          def q(x, y)
            (x - y) % 3 == 0
          end
          p s.equiv_class(:q) #=> {{0, 3}, {1, 4}, {2, 5}}

--- /
    ((<equiv_class>)) �̃G�C���A�X�ł��B

--- to_a
    �W����z��ɂ��ĕԂ��܂��B�v�f�̕��т̏��͕s��ł��B

--- to_ary
    ((<to_a>)) �̃G�C���A�X�ł��B

--- sort
    ((<to_a>)) �̒l���\�[�g���ĕԂ��܂��B

--- power(other)
    ((|other|)) ���� ((|self|)) �ւ̎ʑ��S�Ă̏W����Ԃ��܂��B
    �ʑ��� ((<Map|URL:finite-map-ja.html>)) �̌��Ƃ��ĕ\������܂��B
 
    ��: 
      require "finite-map"
      include Algebra
      a = Set[0, 1, 2, 3]
      b = Set[0, 1, 2]
      s = 
      p( (a ** b).size )      #=> 4 ** 3 = 64
      p b.surjections(a).size #=> S(3, 4) = 36
      p a.injections(b).size  #=> 4P3 = 24

--- **
    ((<power>)) �̃G�C���A�X�ł��B

--- identity_map
    �����ւ̍P���ʑ���Ԃ��܂��B

--- surjections(other)
    ((|other|)) ���� ((|self|)) �ւ̑S�ˑS�Ă̏W����Ԃ��܂��B

#--- injections0(other)

--- injections(other)
    ((|other|)) ���� ((|self|)) �ւ̒P�ˑS�Ă̏W����Ԃ��܂��B


--- bijections(other)
    ((|other|)) ���� ((|self|)) �ւ̑S�P�ˑS�Ă̏W����Ԃ��܂��B


#--- monotonic_series #what is this?

= Enumerable

== �t�@�C����:
* ((|finite-set.rb|))

== ���\�b�h:

--- any?
    �u���b�N��^�ɂ���v�f������Ƃ��A�^��Ԃ��܂��B
    ((|Enumerable#find|)) �̕ʖ��ł��B(built-in of ruby-1.8)

--- all?
    �S�Ă̗v�f�ɂ��ău���b�N���^�ł���Ƃ��A�^��Ԃ��܂��B

      !any?{|x| !yield(x)}

    �ƒ�`����Ă��܂��B(built-in of ruby-1.8)

=end

