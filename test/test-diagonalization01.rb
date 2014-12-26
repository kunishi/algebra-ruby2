require "test/unit"
require "algebra"
require "stringio"

class TestDiagonalization01 < Test::Unit::TestCase
  def capture_stdout(&block)
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    fake.string
  end

  def test_diagonalization01
    capital_m = SquareMatrix(Rational, 3)
    a = capital_m[[1,-1,-1], [-1,1,-1], [2,1,-1]]
    expected =
              [
                "1/1, -1/1, -1/1", "\n",
                "-1/1, 1/1, -1/1", "\n",
                "2/1, 1/1, -1/1", "\n"
              ].join
    assert_equal(expected, capture_stdout { a.display })
    # puts "A = "; a.display; puts
    #A =
    #  1,  -1,  -1
    # -1,   1,  -1
    #  2,   1,  -1

    e = a.diagonalize
    assert_equal("t^3 - t^2 + t - 6/1", "#{e.chpoly}")
    assert_equal("(t - 2/1)(t^2 + t + 3/1)", "#{e.facts}")

    # puts "Charactoristic Poly.: #{e.chpoly} => #{e.facts}";puts
    #Charactoristic Poly.: t^3 - t^2 + t - 6 => (t - 2)(t^2 + t + 3)

    # TODO: which one is correct?
    # puts "Algebraic Numbers:"
    e.roots.each do |po, rs|
      assert_equal("r(-11/4) - 1/2, -r(-11/4) - 1/2", rs.join(', '))
      assert_equal("t^2 + t + 3/1", "#{po}")
      # puts "#{rs.join(', ')} : roots of #{po} == 0"
    end
    #Algebraic Numbers:
    #a, -a - 1 : roots of t^2 + t + 3 == 0

    puts "EigenSpaces: "
    evs = e.evalues.uniq
    assert_equal(2, evs[0])
    assert_equal("[4/1, -5/1, 1/1]", e.espaces[evs[0]].map { |v| v.to_s }.join(', '))
    assert_equal("r(-11/4) - 1/2", "#{evs[1]}")
    assert_equal("[1/3r(-11/4) + 1/6, 1/3r(-11/4) + 1/6, 1/1]", e.espaces[evs[1]].map { |v| v.to_s }.join(', '))
    assert_equal("-r(-11/4) - 1/2", "#{evs[2]}")
    assert_equal("[-1/3r(-11/4) + 1/6, -1/3r(-11/4) + 1/6, 1/1]", e.espaces[evs[2]].map { |v| v.to_s }.join(', '))
    # e.evalues.uniq.each do |ev|
    #   puts "W_{#{ev}} = <#{e.espaces[ev].join(', ')}>"
    # end; puts
    #EigenSpaces:
    #W_{2} = <[4, -5, 1]>
    #W_{a} = <[1/3a + 1/3, 1/3a + 1/3, 1]>
    #W_{-a - 1} = <[-1/3a, -1/3a, 1]>

    expected = [
      "4/1, 1/3r(-11/4) + 1/6, -1/3r(-11/4) + 1/6", "\n",
      "-5/1, 1/3r(-11/4) + 1/6, -1/3r(-11/4) + 1/6", "\n",
      "1/1, 1/1, 1/1", "\n"
    ].join
    assert_equal(expected, capture_stdout { e.tmatrix.display })

    expected =
      [
        "2/1,   0,   0", "\n",
        "  0, r(-11/4) - 1/2,   0", "\n",
        "  0,   0, -r(-11/4) - 1/2", "\n"
      ].join
    assert_equal(expected, capture_stdout { (e.tmatrix.inverse * a * e.tmatrix).display })
    # puts "Trans. Matrix:"
    # puts "P ="
    # e.tmatrix.display; puts
    # puts "P^-1 * A * P = "; (e.tmatrix.inverse * a * e.tmatrix).display; puts
    #P =
    #  4, 1/3a + 1/3, -1/3a
    # -5, 1/3a + 1/3, -1/3a
    #  1,   1,   1
    #
    #P^-1 * A * P =
    #  2,   0,   0
    #  0,   a,   0
    #  0,   0, -a - 1
  end
end
