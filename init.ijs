NB. Solovay-Kitaev Theorem

load 'math/mt'

self_adjoint_operators=:0$''

TOLERANCE=: 1e_15
TOLERANCE2=: 1e_14

PI=: 1p1
PI_HALF=: PI%2
THREE_PI_HALF=: 1.5*PI
TWO_PI=:2p1

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

mm=:+/ .*

eigvals=:monad define
0{ggevlnn_mt_ y ,: idmat_mt_ */$y
)

trace=:monad define
+/(<0 1) |: y
)

adj=:monad define 
_10&o.|:y
)

kron=:dyad define
(x *&$ y) ($,) 0 2 1 3 |: x */ y
)

norm=: monad define
%:+/*:y
)

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

matrixDirectSum=: dyad define
xr=.0{$x
xc=.1{$x
yr=.0{$y
yc=.1{$y
m1=.(x,(yr,xc)$0)
m2=.((xr,yc)$0),y
m1,.m2
)

matrixExpDiag=: monad define
($y) diag ^(<0 1) |: y
)

matrixExp=: monad define
geexp_mt_ y
)

getMfromA =: monad define
pos=.1 + I. iset_dict = <y
t=.(pos{iset_dict)
matrix__t
)
