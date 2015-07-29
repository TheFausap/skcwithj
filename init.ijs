NB. Solovay-Kitaev Theorem

load 'math/lapack math/lapack/geev'
coinsert 'jlapack'
NB. exponential matrix
load 'math/mt' 

self_adjoint_operators=:0$''

TOLERANCE=: 1e_15
TOLERANCE2=: 1e_14

PI=: 1p1
PI_HALF=: PI%2
THREE_PI_HALF=: 1.5*PI
TWO_PI=:2p1

NB. generate random numbers between 0 and 1
NB. the argument specifies how many random numbers generate
rand=:(>:@? % 2147483647&[) @ $ & 2147483646

noMat=:0 0$0

daggerAndSimplify=: monad define
if. y +./@:E. self_adjoint_operators do.
 y
elseif. ({: y) = 'd' do.
 ((#y)-1){.y
elseif. y=y do.
 y,'d'
end.
)

NB. matrix multiplication
mm=:+/ .*

NB. matrix eigenvalues 
eigvals=:monad define
>1{geev y
)

NB. matrix trace
trace=:monad define
+/(<0 1) |: y
)

NB. matrix adjoint
adj=:monad define 
_10&o.|:y
)

NB. kronecker product
kron=:dyad define
(x *&$ y) ($,) 0 2 1 3 |: x */ y
)

NB. vector norm
norm=: monad define
%:+/*:y
)

NB. return a diagonal matrix with specified elements
NB. in the left argument
diag=: 4 : 0
 assert. (0=#$y) +. (<./x)=#y
 y ((#x) #&.> i.<./x)} x$0
)

NB. starting the converted python code

matrixify=: monad define
l=.(#y)%2
(l,l)$y
)

traceNorm=: monad define
yH=._10&o.|:y
%:trace (y mm yH)
)

operatorNorm=: monad define
eig=.eigvals y
{.>./|eig
)

traceDistance=: dyad define
prod=.(x-y) mm _10&o.|:x-y
eig=.eigvals y
%:+/*:eig
)

fowlerDistance=: dyad define
d=.0{$x
frac=.(d-|trace (adj x) mm y)%d
%:frac
)

listAsString=: monad define
if. (#y)=0 do.
 ''
else.
,/y
end.
)

tensorChain=: monad define
if. (#y)=0 do.
 'error: cannot chain an empty list'
else.
 kron/y
end.
)

vectorDistance=: dyad define
norm x-y
)

NB. returns the direct sum of two matrices
matrixDirectSum=: dyad define
xr=.0{$x
xc=.1{$x
yr=.0{$y
yc=.1{$y
m1=.(x,(yr,xc)$0)
m2=.((xr,yc)$0),y
m1,.m2
)

NB. returns a diagonal matrix with the elements
NB. equals to the exponential value of the diagonal
NB. elements of original matrix
matrixExpDiag=: monad define
($y) diag ^(<0 1) |: y
)

NB. returns a diagonal matrix with the elements
NB. equals to the natural log value of the diagonal
NB. elements of original matrix
getMatrixLogarithm=: monad define
($y) diag ^.(<0 1) |: y
)

NB. returns exp(A) where A is matrix
matrixExp=: monad define
geexp_mt_ y
)

NB. return the matrix from the ancestor string
NB. using the iset dictionary
getMfromA =: monad define
pos=.1 + I. iset_dict = <y
t=.(pos{iset_dict)
matrix__t
)

NB. returns the matrix V and matrix W
NB. according this schema : V * U * V^{-1} = W
NB. where U is the right argument and a basis is the left one.
diagonalize =: dyad define
d=.0{>0{x
matrixV=.>0{clean geev y
matrixW=.(%. matrixV) mm y mm matrixV
matrixV;clean matrixW
)