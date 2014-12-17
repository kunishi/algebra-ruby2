require "algebra"
#intersection
p Set[0, 1, 2, 4] & Set[1, 3, 5] == Set[1]
p Set[0, 1, 2, 4] & Set[7, 3, 5] == Set.phi

#union
p Set[0, 1, 2, 4] | Set[1, 3, 5] == Set[0, 1, 2, 3, 4, 5]

#membership
p Set[1, 3, 2].has?(1)

#inclusion
p Set[3, 2, 1, 3] < Set[3, 1, 4, 2, 0]
