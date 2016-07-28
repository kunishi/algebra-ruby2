module Algebra
  module Powers
    def **(n)
      return unity if n == 0

      if n > 0
        m = self
      else
        n = -n
        m = inverse
      end

      z = x = m
      n -= 1
      while n & 1 != 0 && (z *= x); (n >>= 1) != 0
                                    x *= x
      end
      z

      #    if n == 1
      #      m
      #    else
      #      q , r = n.divmod 2
      #      x = m ** q
      #      x = x * x
      #      x = x * m if r > 0
      #      x
      #    end
    end
  end
end
