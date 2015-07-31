NB. Module for composing / constructing matrices from a given basis
NB. Either random or non-random, unitary or hermitian

getRandomHermitian=:monad define
d=.>0{y
components=.2}.y
values=.rand #components
values=.values % norm values
keys=._1 }."1 components
components=.values ;"0 1 keys
matr=.values * >{:"1 (2}.y)
matr=.+/matr
components;matr
)

expHermitian2Unitary=: dyad define
NB. x =: angle;matrix_H
NB. y =: basis
matrixU=.>1{x
mVmW=.y diagonalize matrixU
matrixV=.>0{mVmW
matrixW=.>1{mVmW
angle=.>0{x
angle=._1*_11 o. angle
Udiag =. matrixExpDiag angle*matrixW
matrixV mm Udiag mm %. matrixV
)


