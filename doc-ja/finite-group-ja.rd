########################################################################
#                                                                      #
#   lib/finite-group.rb                                                #
#                                                                      #
########################################################################
=begin
[((<index-ja|URL:index-ja.html>))] 
((<Algebra::OperatorDomain>))
/
((<Algebra::Set>))
/
((<Algebra::Group>))
/
((<Algebra::QuotientGroup>))

= Algebra::OperatorDomain

�Q����p����W���̐������W�߂����W���[���ł��B
((<Group>)) �N���X���C���N���[�h���Ă��܂��B

== �t�@�C����:
* ((|finite-group.rb|))

== ���\�b�h:

--- right_act(other)
    ((|self|)) �� ((|other|)) �̐ς�Ԃ��܂��B���Ȃ킿 ((|self|))
    �̌� ((|x|)) �� ((|other|)) �̌� ((|y|)) �ɑ΂��� (({x * y})) ��
    �`�̌��̏W���i((|Set|))�j��Ԃ��܂��B

--- act
    ((<right_act>)) �̃G�C���A�X�ł��B

--- left_act(other)
    ((|self|)) �� ((|other|)) �̐ς�Ԃ��܂��B���Ȃ킿 ((|self|))
    �̌� ((|x|)) �� ((|other|)) �̌� ((|y|)) �ɑ΂��� (({y * x})) ��
    �`�̌��̏W���i((|Set|))�j��Ԃ��܂��B

--- right_quotient(other)
    ((|self|)) �� ((|other|)) �Ŋ������E��]�ނ̏W���i((|Set|))�j
    ��Ԃ��܂��B

--- quotient
--- right_coset
--- coset
    ((<right_quotient>)) �̃G�C���A�X�ł��B

--- left_quotient(other)
    ((|self|)) �� ((|other|)) �Ŋ���������]�ނ̏W���i((|Set|))�j
    ��Ԃ��܂��B

--- left_coset
    ((<left_quotient>)) �̃G�C���A�X�ł��B

--- right_representatives(other)
    �E��]�� ((<right_quotient>)) ����������\���̏W����Ԃ��܂��B

--- representatives
    ((<right_representatives>)) �̃G�C���A�X�ł��B

--- left_representatives(other)
    ����]�� ((<left_quotient>)) ����������\���̏W����Ԃ��܂��B

--- right_orbit!(other)
    ((|self|)) �� ((|other|)) ���J��Ԃ��E�����p�����čL���܂��B
    ��p�� ((|*|)) �ɂ��܂��B

--- orbit!
    ((<right_orbit!>)) �̃G�C���A�X�ł��B

--- left_orbit!(other)
    ((|self|)) �� ((|other|)) ���J��Ԃ��������p�����čL���܂��B
    ��p�� ((|*|)) �ɂ��܂��B
    

= Algebra::Set

== �t�@�C����:
* ((|finite-group.rb|))
  �����ł� ((|finite-set.rb|)) �Œ�`���ꂽ ((<Set|URL:finite-set.html>))
  �ɕt��������ׂ����\�b�h���`���Ă��܂��B

== �C���N���[�h���Ă��郂�W���[��:

* ((|OperatorDomain|))

== ���\�b�h:

--- *
    ((<act>)) �̃G�C���A�X�ł��B

--- /
    ((<quotient>)) �̃G�C���A�X�ł��B

--- %
    ((<representatives>)) �̃G�C���A�X�ł��B

--- increasing_series([x])
    ((|x|)) ����n�܂鑝���̔z���Ԃ��܂��B����͎��̃R�[�h�Ɠ��l
    �ł��B

      def increasing_series(x = unit_group)
        a = []
        loop do
          a.push x
          if x >= (y = yield x)
            break
          end
          x = y
        end
        a
      end

--- decreasing_series([x])
    ((|x|)) ����n�܂錸���̔z���Ԃ��܂��B����͎��̃R�[�h�Ɠ��l
    �ł��B

      def decreasing_series(x = self)
        a = []
        loop do
          a.push x
          if x <= (y = yield x)
            break
          end
          x = y
        end
        a
      end

= Algebra::Group

== �t�@�C����:
* ((|finite-group.rb|))

== �X�[�p�[�N���X:
* ((|Set|))

== �N���X���\�b�h:

--- ::new(u, [g0, g1, ...]])
    ((|u|)) ��P�ʌ��Ƃ��A((|g0|)), ((|g1|)), ... �ō\�������Q��
    �Ԃ��܂��B

--- ::generate_strong(u, [g0, [g1, ...]])
    �P�ʌ��� ((|u|))�A���������� ((|g0|)), ((|g1|)), ... �Ƃ��āA
    ���������Q��Ԃ��܂��B

== ���\�b�h:

--- quotient_group(u)
    ���K�����Q ((|u|)) �ɂ���]�Q��Ԃ��܂��B

--- separate
    �u���b�N��^�Ƃ��錳����Ȃ镔���Q��Ԃ��܂��B

--- to_a
    �e�v�f��z��ɂ��ĕԂ��܂��B�ŏ��̗v�f�͒P�ʌ��ł��B

--- unity
    �P�ʌ���Ԃ��܂��B

--- unit_group
    �P�ʌ��Ő��������P�ʌQ��Ԃ��܂��B

--- semi_complete!
    ���݂̗v�f���|�����킹�Ĕ��Q���\�����܂��B

--- semi_complete
    ���݂̗v�f���|�����킹�Ĕ��Q���\�������̂�Ԃ��܂��B

--- complete!
    ���݂̗v�f���|�����킹�ČQ���\�����܂��B

--- complete
    ���݂̗v�f���|�����킹�ČQ���\�������̂�Ԃ��܂��B

--- closed?
    �Q�Ƃ��ĕ��Ă���Ƃ��^��Ԃ��܂��B

--- subgroups
    �S�Ă̕����Q�̏W����Ԃ��܂��B

--- centralizer(s)
    ((|self|)) �ɂ����� ((|s|)) �̒��S���Q��Ԃ��܂��B

--- center
    ((|self|)) �̒��S���Q��Ԃ��܂��B

--- center?(x)
    ((|self|)) �̒��Ō� ((|x|)) �����S�Ɋ܂܂�Ă���Ƃ��A�^��Ԃ��܂��B

--- normalizer(s)
    ((|self|)) �ɂ����� ((|s|)) �̐��K���Q��Ԃ��܂��B

--- normal?(s)
    ((|s|)) �� ((|self|)) �̐��K�����Q�ł���Ƃ��^��Ԃ��܂��B

--- normal_subgroups
    �S�Ă̐��K�����Q�̏W����Ԃ��܂��B

--- conjugacy_class(x)
    �� ((|x|)) �̋���ނ�Ԃ��܂�

--- conjugacy_classes
    ((|self|)) �̑S�Ă̋���ނ̏W����Ԃ��܂��B

--- simple?
    �P���Q�ł���Ƃ��A�^��Ԃ��܂��B

--- commutator([h])
    ((|self|)) �� ((|h|)) �Ƃ̌����q�Q��Ԃ��܂��B((|h|)) ���ȗ�
    ����� ((|self|)) ���p�����܂��B

--- D([n])
    ((|n|)) �Ԗڂ̌����q�Q��Ԃ��܂��B(({D(0) = �������g})),
    (({D(n+1) = [D[n], D[n]]})) �Œ�`����Ă��܂��B
    ((|n|)) ���ȗ������ 1 ���p�����܂��B

--- commutator_series
    (({[D(0), D(1), D(2),..., D(n)]})) �Ƃ����z���Ԃ��܂��B���̔z���
    (({D(n) == D(n+1)})) �ƂȂ� ((|n|)) �Œ�~���܂��B 

--- solvable?
    ���Q�ł���Ƃ��^��Ԃ��܂��B

--- K([n])
    (({K(0) = �������g})),
    (({K(n+1) = [self, K[n]]})) �Œ�`�����Q��Ԃ��܂��B
    ((|n|)) ���ȗ������ 1 ���p�����܂��B

--- descending_central_series
    �~���S��
    (({[K(0), K(1), K(2),..., K(n)]})) �Ƃ����z���Ԃ��܂��B���̔z���
    (({K(n) == K(n+1)})) �ƂȂ� ((|n|)) �Œ�~���܂��B 

--- Z([n])
    (({Z(0) = �P�ʌQ})),
    (({Z(n+1) = separate{|x| commutator(Set[x]) <= Z(n-1)}})) 
    �Œ�`�����Q��Ԃ��܂��B
    ((|n|)) ���ȗ������ 1 ���p�����܂��B

--- ascending_central_series
    �����S��
    (({[Z(0), Z(1), Z(2),..., Z(n)]})) �Ƃ����z���Ԃ��܂��B���̔z���
    (({Z(n) == Z(n+1)})) �ƂȂ� ((|n|)) �Œ�~���܂��B 

--- nilpotent?
    �p��Q�ł���Ƃ��^��Ԃ��܂��B

--- nilpotency_class
    �p��N���X��Ԃ��܂��B�p��Q�łȂ��Ƃ� ((|nil|)) ��Ԃ��܂��B


= Algebra::QuotientGroup

== �t�@�C����:
* ((|finite-group.rb|))

== �X�[�p�[�N���X:
* ((|Group|))

== �N���X���\�b�h:
--- new(u, [g0, [g1,...]])
    ((|self|)) �̐��K�����Q�� ((|u|)) �Ƃ��āA
    ((|u|)), ((|g0|)), ((|g1|)), .. ����]�ނƂ����]�Q��Ԃ��܂��B

== ���\�b�h:

--- inverse
    �t����Ԃ��܂�

--- inv
    ((<inverse>)) �̃G�C���A�X�ł��B

=end

