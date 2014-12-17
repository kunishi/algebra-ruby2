########################################################################
#                                                                      #
#   finite-map.rb                                                      #
#                                                                      #
########################################################################
=begin
[((<index-ja|URL:index-ja.html>))] 
[((<finite-set-ja|URL:finite-set-ja.html>))] 
((<Algebra::Map>))

= Algebra::Map
((*�ʑ��N���X*))

�ʑ���\������N���X�ł��B

== �t�@�C����:
* ((|finite-map.rb|))

== �X�[�p�[�N���X:
* ((|Set|))

== �C���N���[�h���Ă��郂�W���[��:

* ((|Powers|))

== �N���X���\�b�h:

--- ::[]([x0 => y0, [x1 => y1, [x2 => y2, ...]]])
    ((|x0|)) �̎� ((|y0|)), ((|x1|)) �̎� ((|y1|)), ((|x2|)) �̎� ((|y2|)),..
    �Ƃ����l�����ʑ���Ԃ��܂��B
    
    ��: 
      require "finite-map"
      include Algebra
      p Map[0 => 10, 1 => 11, 2 => 12]         #=> {0 => 10, 1 => 11, 2 => 12}
      p Map[{0 => 10, 1 => 11, 2 => 12}]       #=> {0 => 10, 1 => 11, 2 => 12}
      p Map.new(0 => 10, 1 => 11, 2 => 12)     #=> {0 => 10, 1 => 11, 2 => 12}
      p Map.new({0 => 10, 1 => 11, 2 => 12})   #=> {0 => 10, 1 => 11, 2 => 12}
      p Map.new_a([0, 10, 1, 11, 2, 12])       #=> {0 => 10, 1 => 11, 2 => 12}

--- ::new([x0 => y0, [x1 => y1, [x2 => y2, ...]]])
    ((|x0|)) �̎� ((|y0|)), ((|x1|)) �̎� ((|y1|)), ((|x2|)) �̎� ((|y|)),..
    �Ƃ����l�����ʑ���Ԃ��܂��B((<::[]>)) �Ɠ����ł��B

--- ::new_a(a)
    �z�� a �̋����Ԗڂ��`��̌��A��Ԗڂ�l��̌��Ƃ��Ē�`�����
    �ʑ��𐶐����܂��B

--- ::phi([t])
    ��ʑ��i��`�悪��W���ł���ʑ��j��Ԃ��܂��B�W�� ((|t|)) ��
    �����ɂ���ƁA������`�� ((<target>)) �ɂ��܂��B

    ��: 
      p Map.phi #=> {}
      p Map.phi(Set[0, 1]) #=> {}
      p Map.phi(Set[0, 1]).target #=> {0, 1}

--- ::empty_set
    ((<::phi>)) �̃G�C���A�X�ł��B

--- ::singleton(x, y)
    ������̌��ō\�������W�� (({{x}})) ��Œ�`���ꂽ ((|y|)) �Ƃ���
    �l�����֐���Ԃ��܂��B


== ���\�b�h:

--- target=(s)
    �ʑ��̒l��� ((|s|)) �ɐݒ肵�܂��B((<surjective?>)) �Ȃǂ�
    ���p����܂��B

--- codomain=(s)
    ((<target=>)) �̃G�C���A�X�ł��B

--- target
    �ʑ��̒l���Ԃ��܂��B

--- codomain
    ((<target>)) �̃G�C���A�X�ł��B

--- source
    �ʑ��̒�`���Ԃ��܂��B

    ��: 
      require "finite-map"
      include Algebra
      m = Map[0 => 10, 1 => 11, 2 => 12]
      p m.source #=> {0, 1, 2}
      p m.target #=> nil
      m.target = Set[10, 11, 12, 13]
      p m.target #=> {10, 11, 12, 13}

--- domain
    ((<source>)) �̃G�C���A�X�ł��B

--- phi([t])
    �l��� ((|t|)) �Ƃ����̎ʑ���Ԃ��܂��B

--- empty_set
--- null
    ((<phi>)) �̃G�C���A�X�ł��B

--- call(x)
    �ʑ��� ((|x|)) �ɂ�����l��Ԃ��܂��B

--- act
--- []
    ((<call>)) �̃G�C���A�X�ł��B

--- each
    ���ׂĂ� (({[����, ��]})) �ɂ��ČJ��Ԃ��C�e���[�^�ł��B

    ��: 
      require "finite-map"
      include Algebra
      Map[0 => 10, 1 => 11, 2 => 12].each do |x, y|
        p [x, y] #=> [1, 11], [0, 10], [2, 12]
      end

--- compose(other)
    ((|self|)) �� ((|other|)) �̍����ʑ���Ԃ��܂��B

    ��: 
      require "finite-map"
      include Algebra
      f = Map.new(0 => 10, 1 => 11, 2 => 12)
      g = Map.new(10 => 20, 11 => 21, 12 => 22)
      p g * f #=> {0 => 20, 1 => 21, 2 => 22}

--- *
    ((<compose>)) �̃G�C���A�X�ł��B

--- dup
    ���g�̕�����Ԃ��܂��B�l��̒l���Ԃ��܂��B

--- append!(x, y)
    ((|x|)) �� ((|y|)) �Ƃ����l�����悤�ɐݒ肵�܂��B

    ��: 
      require "finite-map"
      include Algebra
      m = Map[0 => 10, 1 => 11]
      m.append!(2, 12)
      p m #=> {0 => 10, 1 => 11, 2 => 12}

--- []=(x, y)
    ((<append!>)) �̃G�C���A�X�ł��B

--- append(x, y)
    ((<dup>)) �̌�A((<append!>))(x, y) �������̂�Ԃ��܂��B

--- include?(x)
    ((|x|)) ����`��Ɋ܂܂��Ƃ��^��Ԃ��܂��B

--- contains?(x)
    ((<include?>)) �̃G�C���A�X�ł��B

--- member?(a)
    ((|a|)) ��z�� (({[x, y]})) �Ƃ����Ƃ��A((|x|)) �ɂ�����l��
    ((|y|)) �ƂȂ�Ƃ��A�^��Ԃ��܂��B

    ��: 
      require "finite-map"
      include Algebra
      m = Map[0 => 10, 1 => 11]
      p m.include?(1)  #=> true
      p m.member?([1, 11]) #=> true

--- has?
    member? �̃G�C���A�X�ł��B

--- image([s])
    �ʑ��̑���Ԃ��܂��B��`��̕����W�� ((|s|)) ���^������΁A
    ((|s|)) �̑���Ԃ��܂��B

--- inv_image(s)
    �W�� ((|s|)) �̌�����Ԃ��܂��B

--- map_s
    �ʑ��̊e [����, ��] �̃y�A�ɂ��ČJ��Ԃ��A�u���b�N�œ���
    �l�̏W����Ԃ��܂��B

    ��: 
      require "finite-map"
      include Algebra
      p Map.new(0 => 10, 1 => 11, 2 => 12).map_s{|x, y| y - 2*x}
      #=> Set[10, 9, 8]

--- map_m
    �ʑ��̊e [����, ��] �̃y�A�ɂ��ČJ��Ԃ��A�u���b�N�œ���
    �l�̔z��ō\�������ʑ���Ԃ��܂��B

    ��: 
      require "finite-map"
      include Algebra
      p Map.new(0 => 10, 1 => 11, 2 => 12).map_m{|x, y| [y, x]}
      #=> {10 => 0, 11 => 1, 12 => 2}

--- inverse
    �t�ʑ���Ԃ��܂��B

--- inv_coset
    �e���ɋt���̏W����Ή�������ʑ���Ԃ��܂��B

    ��: 
      require "finite-map"
      include Algebra
      m = Map[0=>0, 1=>0, 2=>2, 3=>2, 4=>0]
      p m.inv_coset #=> {0=>{0, 1, 4}, 2=>{2, 3}}
      m.codomain = Set[0, 1, 2, 3]
      p m.inv_coset #=> {0=>{0, 1, 4}, 1=>{}, 2=>{2, 3}, 3=>{}}

--- indentity?
    �P���ʑ��ł���Ƃ��A�^��Ԃ��܂��B

--- surjective?
    �S�˂ł��鎞�A�^��Ԃ��܂��B���炩���� ((<target>)) ���w�肳���
    ����K�v������܂��B

--- injective?
    �P�˂ł��鎞�A�^��Ԃ��܂��B

--- bijective?
    �S�P�˂ł��鎞�A�^��Ԃ��܂��B���炩���� ((<target>)) ���w�肳���
    ����K�v������܂��B

=end
