module Powers
  def **(n)
    if n == 0
      return unity
    end

    if n > 0
      m = self
    else
      n = -n
      m = self.inverse
    end

    z = x = m
    n -= 1
    while (n & 1 != 0 and z *= x; (n >>= 1) != 0)
      x = x * x
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
