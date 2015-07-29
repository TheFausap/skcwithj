NB. basis handling
getStandardVectorBasis=: monad define
mm=.(y,y)$1,y#0
(,:@<)"1 mm
)

ttt=:monad define
ll=.1+i.y
ll1=.((y*y),2)$,ll,"0/"0 1 ll
ff=.(0{"1 ll1) ~: 1{"1 ll1
ff#ll1
)

Ejk=: dyad define
NB. internal function for the hermitian basis
d=.>1{y
j=.x
k=.>0{y
m=.(d,d)$d#0
m=.1 (<j,k)}m
m
)

Fkj=: dyad define
NB. internal function for the hermitian basis
k=.x-1
j=.y-1
if. k<j do.
 (k Ejk j;d) + (j Ejk k;d)
elseif. k>j do.
 0j_1 * (j Ejk k;d) - (k Ejk j;d)
end.
)

idmat=:monad define
(y,y)$1,y#0
)

Hkd=:dyad define
NB. internal function for the hermitian basis
k=.x
d=.y
if. k = 1 do.
 idmat d
elseif. k = d do.
 (%:2%d*d-1)*(1 Hkd d-1) matrixDirectSum (1 1$(1-d))
elseif. k<d do.
 (k Hkd d-1) matrixDirectSum (1 1$0)
end.
)

getHermitianBasis=: monad define
NB. generates an hermitian basis (traceless) 
NB. for the specified dimension
m1=.(1+i.y) Hkd"0 M. y
d=:y
NB.l1=.((1+i.y) ~:/ (1+i.y))#(1+i.y)
NB.dissect 'l1,|."1 l1'
l2=.ttt d
m2=.(0{"1 l2) Fkj"0 (1{"1 l2)
res1=.((1+i.y);"0 y);"1 2 m1
res1=.'h';"1 res1
res2=.((0{"1 l2);"0 (1{"1 l2));"1 2 m2
res2=.'f';"1 res2
d;res1,res2
)

XW=:monad define
NB. internal functions for GenPaul
NB. defines the X matrix (skew matrix)
m1=.(y,y)$0
m1=.1 (<0,y-1)}m1
pos=.(y+1)*(1+i.y-1)
m1=.1 (pos-1)},m1
(y,y)$m1
)

ZW=:monad define
NB. internal functions for GenPaul
NB. defines the Z matrix (clock matrix)
jdot=._11&o.
re=.9&o.
im=.11&o.
om=._12&o. x: 2p1%y
coef=.om ^ i.y
m1=.coef * =@i.y
m1=.(jdot@im)^:(1e_10&>@|@re)"0 ,m1
m1=.re^:(1e_10&>@|@im)"0 m1
(y,y)$m1 
)

GenPaul=: dyad define
NB. Generates a Generalized Pauli matrix
j=.1{x
k=.y
d=.0{x
Z=.ZW d
X=.XW d
if. (j=0) *. k=0 do.
 =@i. d
elseif. j=0 do. 
 Z mm^:(k-1) Z
elseif. k=0 do. 
 X mm^:(j-1) X
elseif. (j>0) +. k>0 do.
 (X mm^:(j-1) X) mm Z mm^:(k-1) Z 
end.
)

getUnitaryBasis=: monad define
NB. generates an unitary basis for the specified dimension
l1=.i.y
d=.y
NB.res=.(d,l1) GenPaul"0 / l1
res=.(d,l1) GenPaul / l1
d;((i.d) ;"0/ (i.d));"1 2 res
)

hsInnerProduct=: dyad define
A=.|:_10&o. x
trace A mm y
)

cart3dtoh2=: monad define
NB. returns a basis
n=.norm y
y=.y%n

xc=.0{y
yc=.1{y
zc=.2{y

c1=.'h';(2;2);zc
c2=.'f';(1;2);xc
c3=.'f';(2;1);yc
c1,c2,:c3
)



