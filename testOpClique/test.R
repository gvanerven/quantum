#Making matrices
#V = matrix(c(1,0,1,0,1,1,1,1,1), nrow = 3, ncol = 3)
#T2 = matrix(c(0,0,0,0,1,0,0,0,1), nrow = 3, ncol = 3)
#Each line in matrix() is a column in the defined matrix
ckM = matrix(c(0,1,1,1,1,
               0,0,0,0,0,
               0,0,0,0,0,
               0,0,0,0,0,
               0,0,0,0,0), nrow = 5, ncol = 5)

v5.e0.k0 = matrix(c(1,0,0,0,0,
                    0,1,0,0,0,
                    0,0,1,0,0,
                    0,0,0,1,0,
                    0,0,0,0,1), nrow = 5, ncol = 5)

v5.e8.k0 = matrix(c(1,0,0,0,1,
                    0,1,1,1,1,
                    0,1,1,1,1,
                    0,1,1,1,1,
                    1,1,1,1,1), nrow = 5, ncol = 5)

#!ck | v5.e8.k0
#xor(!ck, !ck | v5.e8.k0)

v5.e8.k0.v0 = c(1,0,0,0,1)
v5.e8.k0.v1 = c(0,1,1,1,1)
v5.e8.k0.v2 = c(0,1,1,1,1)
v5.e8.k0.v3 = c(0,1,1,1,1)
v5.e8.k0.v4 = c(1,1,1,1,1)

#Normal operation: using all vertices
v5.e8.k0.v0 & v5.e8.k0.v1 & v5.e8.k0.v2 & v5.e8.k0.v3 & v5.e8.k0.v4
#FALSE FALSE FALSE FALSE  TRUE
#Only vertices in clique
v5.e8.k0.v1 & v5.e8.k0.v2 & v5.e8.k0.v3 & v5.e8.k0.v4
#FALSE  TRUE  TRUE  TRUE  TRUE

#Using a operation before the AND
(0 + (1 * v5.e8.k0.v0)) & v5.e8.k0.v1 & v5.e8.k0.v2 & v5.e8.k0.v3 & v5.e8.k0.v4
#FALSE FALSE FALSE FALSE  TRUE
#Output equivalent to using all vertices
(1 + (0 * v5.e8.k0.v0)) & v5.e8.k0.v1 & v5.e8.k0.v2 & v5.e8.k0.v3 & v5.e8.k0.v4
#FALSE  TRUE  TRUE  TRUE  TRUE
#Output equivalent to remove the first vertice
#Defining alphas
a0 = 0
a1 = 1
a2 = 1
a3 = 1
a4 = 1
ck = c(a0,a1,a2,a3,a4)

########
#u = ((as.integer(!a0) + (a0 * v5.e8.k0.v0)) & 
#      (as.integer(!a1) + (a1 * v5.e8.k0.v1)) & 
#      (as.integer(!a2) + (a2 * v5.e8.k0.v2)) & 
#      (as.integer(!a3) + (a3 * v5.e8.k0.v3)) & 
#      (as.integer(!a4) + (a4 * v5.e8.k0.v4)))

#u = ((!a0 | (a0 & v5.e8.k0.v0)) & 
#      (!a1 | (a1 & v5.e8.k0.v1)) & 
#      (!a2 | (a2 & v5.e8.k0.v2)) & 
#      (!a3 | (a3 & v5.e8.k0.v3)) & 
#      (!a4 | (a4 & v5.e8.k0.v4)))
# !a | (a & x) = (!a | a) & (!a | x) = !a | x

#u = ((!a0 | v5.e8.k0.v0) & 
#      (!a1 | v5.e8.k0.v1) & 
#      (!a2 | v5.e8.k0.v2) & 
#      (!a3 | v5.e8.k0.v3) & 
#      (!a4 | v5.e8.k0.v4))

#(C XOR A^B) XOR A = ¬A v B with C only equals to 1
u = (xor(xor(1, a0 & v5.e8.k0.v0), a0) &
     xor(xor(1, a1 & v5.e8.k0.v1), a1) &
     xor(xor(1, a2 & v5.e8.k0.v2), a2) &
     xor(xor(1, a3 & v5.e8.k0.v3), a3) &
     xor(xor(1, a4 & v5.e8.k0.v4), a4))

#Operation harder to using in cascade and generate a final result
#ck & u
#Using ¬P XOR Q to check if the selected vertices in input (ck) is the same of output
#targetOutput = xor(!ck, u)
#Problem with input (0,0,1,1,1). As a1 is part of a bigger clique, seting it to 1 makes
#with the other vertices include it and output the same as an output with a1. The result
#makes with that algorithm only output true when the combination is a maximum clique.

target = xor(u[1], !a0) &
  xor(u[2], !a1) &
  xor(u[3], !a2) &
  xor(u[4], !a3) &
  xor(u[5], !a4)

#target = TRUE
#for(t in targetOutput){
#  target = target & t
#}
target
#######

a0 = 0
a1 = 0
a2 = 0
a3 = 0
a4 = 1
ck = c(a0,a1,a2,a3,a4)

v5.e8.k0.v0 = c(1,0,0,0,0)
v5.e8.k0.v1 = c(0,1,0,0,0)
v5.e8.k0.v2 = c(0,0,1,0,0)
v5.e8.k0.v3 = c(0,0,0,1,0)
v5.e8.k0.v4 = c(0,0,0,0,1)

a0 = 1
a1 = 0
a2 = 0
a3 = 0
a4 = 0
ck = c(a0,a1,a2,a3,a4)

v5.e8.k0.v0 = c(1,0,0,1,0)
v5.e8.k0.v1 = c(0,1,0,0,0)
v5.e8.k0.v2 = c(0,0,1,0,0)
v5.e8.k0.v3 = c(1,0,0,1,0)
v5.e8.k0.v4 = c(0,0,0,0,1)

a0 = 1
a1 = 0
a2 = 0
a3 = 1
a4 = 0
ck = c(a0,a1,a2,a3,a4)