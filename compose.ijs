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