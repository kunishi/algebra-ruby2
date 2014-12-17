########################################################################
#                                                                      #
#   lib/permutation-group.rb                                           #
#                                                                      #
########################################################################
=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::PermutationGroup>))
/
((<Algebra::Permutation>))

= Algebra::PermutationGroup
�u���Q�̃N���X�ł��B�v�f�Ƃ��� ((<Permutation>)) �̃C���X�^���X
���w�肳��Ă���Ƃ��܂��B


== �t�@�C����:
* ((|permutation-group.rb|))

== �X�[�p�[�N���X:
* ((|Group|))

== �N���X���\�b�h:

--- ::new(u, [g0, [g1, ...]])
    ((|u|)) ��P�ʌ��Ƃ��A((|g0|)), ((|g1|)), ... �ō\�������Q��
    �Ԃ��܂��B

--- ::unit_group(d)
    ������ ((|d|)) �̒P�ʌQ��Ԃ��܂��B

--- ::unity(n)
    ������ ((|n|)) �̒P�ʌ���Ԃ��܂��B

--- ::perm(a)
    �z�� ((|a|)) �ŕ\�����u����Ԃ��܂��B

--- ::symmetric(n)
    ((|n|)) ���̑Ώ̌Q��Ԃ��܂��B

--- ::alternate(n)
    ((|n|)) ���̌��Q��Ԃ��܂��B

= Algebra::Permutation
�u����\������N���X�ł��B


== �t�@�C����:
* ((|permutation-group.rb|))

== �X�[�p�[�N���X:
* ((|Object|))

== �C���N���[�h���Ă��郂�W���[��:

* ((|Enumerable|))
* ((|Powers|))

== �N���X���\�b�h:

--- ::new(x)
    ((|x|)) �Ƃ����z��ŕ\�������u���𐶐����܂��B

--- ::[]([n0, [n1, [n2, ..., ]]])
    (({[n0, n1, n2, ..., ]})) �Ƃ����u���𐶐����܂��B
    ��
      a = Permutation[1, 2, 0]
      p a**2 #=> [2, 0, 1]
      p a**3 #=> [0, 1, 2]

--- ::unity(d)
    ((|d|)) ���̒P�ʌ���Ԃ��܂��B

--- ::cyclic2perm(c, n)
    ((|c|)) �Ƃ�������u����\���z��̔z�񂩂�A((<Permutation>))
    �I�u�W�F�N�g�𐶐����܂��B((|n|)) �͎����ł��B
    ((<decompose_cyclic>)) �̋t�ł��B

    ��: 
      Permutation.cyclic2perm([[1,6,5,4], [2,3]], 7) #=> [0, 6, 3, 2, 1, 4, 5]
      Permutation[0, 6, 3, 2, 1, 4, 5].decompose_cyclic #=> [[1,6,5,4], [2,3]]

== ���\�b�h:
--- unity
    �P�ʌ���Ԃ��܂��B

--- perm
    �z��\����Ԃ��܂��B

--- degree
    ������Ԃ��܂��B

--- size
    ((<degree>)) �̃G�C���A�X�ł��B

--- each
    �u���̊e���ɂ��ČJ��Ԃ��܂��B

--- eql?(other)
    ((|other|)) �Ɠ������Ƃ��^��Ԃ��܂��B

--- ==
    ((|eql?|)) �̃G�C���A�X�ł��B

--- hash
    �n�b�V���l��Ԃ��܂��B

--- [](i)
    ((|i|)) �̒u�����Ԃ��܂��B

--- call
    ((<[]>)) �̃G�C���A�X�ł��B

--- index(i)
    ((|i|)) �̒u������Ԃ��܂��B

--- right_act(other)
    ((|other|)) �ɉE���炩���܂��B���Ȃ킿
    (({(g.right_act(h))[x] == h[g[x]]})) ���������܂��B

--- *
    ((<right_act>)) �̃G�C���A�X�ł��B

--- left_act(other)
    ((|other|)) �ɍ����炩�炩���܂��B���Ȃ킿
    (({(g.left_act(h))[x] == g[h[x]]})) ���������܂��B

--- inverse
    �t����Ԃ��܂��B

--- inv
    ((|inverse|)) �̃G�C���A�X�ł��B

--- sign
    ������Ԃ��܂��B

--- conjugate(g)
    ((|g|)) �ɂ�鋤�� (({g * self * g.inv})) ��Ԃ��܂��B

--- decompose_cyclic
    �z��ɂ�鏄��\���̔z���Ԃ��܂��B
    ((<::cyclic2perm(c, n)>)) �̋t�ł��B

--- to_map
    ((<Map|URL:finite-map-ja.html>)) �I�u�W�F�N�g�����܂��B

--- decompose_transposition
    �݊��̔z��ɕ����������̂�Ԃ��܂��B

=end

