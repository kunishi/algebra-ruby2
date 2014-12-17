require "algebra"

def show(f, mod = 0)
  if mod > 0
    zp = ResidueClassRing(Integer, mod)
    pzp = Polynomial(zp, f.variable)
    f = f.convert_to(pzp)
  end
  fact = f.factorize
  printf "mod %2d: %-15s  =>  %s\n", mod, f, fact
end

Px = Polynomial(Integer, "x")
x = Px.var
f = x**4 + 10*x**2 + 1
#f = x**4 - 10*x**2 + 1
show(f)
Primes.new.each do |mod|
  break if mod > 100
  show(f, mod)
end

#mod  0: x^4 + 10x^2 + 1  =>  x^4 + 10x^2 + 1
#mod  2: x^4 + 1          =>  (x + 1)^4
#mod  3: x^4 + x^2 + 1    =>  (x + 2)^2(x + 1)^2
#mod  5: x^4 + 1          =>  (x^2 + 3)(x^2 + 2)
#mod  7: x^4 + 3x^2 + 1   =>  (x^2 + 4x + 6)(x^2 + 3x + 6)
#mod 11: x^4 - x^2 + 1    =>  (x^2 + 5x + 1)(x^2 + 6x + 1)
#mod 13: x^4 + 10x^2 + 1  =>  (x^2 - x + 12)(x^2 + x + 12)
#mod 17: x^4 + 10x^2 + 1  =>  (x^2 + 3x + 1)(x^2 + 14x + 1)
#mod 19: x^4 + 10x^2 + 1  =>  (x + 17)(x + 10)(x + 9)(x + 2)
#mod 23: x^4 + 10x^2 + 1  =>  (x^2 + 6)(x^2 + 4)
#mod 29: x^4 + 10x^2 + 1  =>  (x^2 + 21)(x^2 + 18)
#mod 31: x^4 + 10x^2 + 1  =>  (x^2 + 22x + 30)(x^2 + 9x + 30)
#mod 37: x^4 + 10x^2 + 1  =>  (x^2 + 32x + 36)(x^2 + 5x + 36)
#mod 41: x^4 + 10x^2 + 1  =>  (x^2 + 19x + 1)(x^2 + 22x + 1)
#mod 43: x^4 + 10x^2 + 1  =>  (x + 40)(x + 29)(x + 14)(x + 3)
#mod 47: x^4 + 10x^2 + 1  =>  (x^2 + 32)(x^2 + 25)
#mod 53: x^4 + 10x^2 + 1  =>  (x^2 + 41)(x^2 + 22)
#mod 59: x^4 + 10x^2 + 1  =>  (x^2 + 13x + 1)(x^2 + 46x + 1)
#mod 61: x^4 + 10x^2 + 1  =>  (x^2 + 54x + 60)(x^2 + 7x + 60)
#mod 67: x^4 + 10x^2 + 1  =>  (x + 55)(x + 39)(x + 28)(x + 12)
#mod 71: x^4 + 10x^2 + 1  =>  (x^2 + 43)(x^2 + 38)
#mod 73: x^4 + 10x^2 + 1  =>  (x + 68)(x + 44)(x + 29)(x + 5)
#mod 79: x^4 + 10x^2 + 1  =>  (x^2 + 64x + 78)(x^2 + 15x + 78)
#mod 83: x^4 + 10x^2 + 1  =>  (x^2 + 18x + 1)(x^2 + 65x + 1)
#mod 89: x^4 + 10x^2 + 1  =>  (x^2 + 9x + 1)(x^2 + 80x + 1)
#mod 97: x^4 + 10x^2 + 1  =>  (x + 88)(x + 54)(x + 43)(x + 9)
