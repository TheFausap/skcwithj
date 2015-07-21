NB. simplification engine for operators
NB. there are some default rules and
NB. custom ones---user defined

substr =: (];.0~ ,.)~"1   NB. x is (start,len), y is string to take from

intdiv =: dyad define
x <.@% y
)

doubleOpSimp=: dyad define
NB. Q * Q = I
if. (x=a:) +. y=a: do.
 '0';x;y
else.
 x=.>x
 y=.>y
 if. (#x)=#y do.
  for_k. doubleOpId do.
   if. (x=k) *. y=k do.
    '1';'I'
   else.
    '0';x;y
   end.
  end.
 else.
  '0';x;y
 end.
end.
)

identSimp=: dyad define
NB. this works on a couple of operators
NB. Q * I = Q
if. (x=a:) +. y=a: do.
 '0';x;y
else.
 x=.>x
 y=.>y
 if. (x='I') do.
  '1';y
 elseif. y='I' do.
  '1';x
 elseif. y=y do.
  '0';x;y
 end.
end.
)

generalSimp=: dyad define
NB. (op1 * op2 * ... * opn) = I
NB. this works with only one operator
B=.(,>y)-.' '
A=.(,>x)-.' '
lA=.#A
lB=.#y
smoutput x
smoutput y
smoutput A
if. (#y) >: lA do.
 seq=.i.2+(#y) intdiv lA
 for_k. seq do.
  if. A = (k,lA) substr B do.
   f1=.(k$0),(lA$1),(lB-k+8)$0
   f2=.(k{.y)
   f3=.(<'I'),(lA-1)$a:
   f4=.(_1*(lB-k+8)){.y
   f11=.f2,f3,f4
   '1';(f1 } y,:f11)-.a:
   break.
  else.
   '0';y
  end.
 end.  
else.
 '0';y
end.
)

adjointSimp=: dyad define
NB. Q * Qd = I
NB. it's atomic. it works only on a couple of operators
if. (x=a:) +. y=a: do.
 '0';x;y
else.
 x=.>x
 y=.>y
 lA=.#x
 lB=.#y
 if. ((lA = lB+1) +. (lB = lA+1)) do.
  posA=.'d' E. x
  posB=.'d' E. y
  IposA=.I. posA
  IposB=.I. posB
  if. (+/posA) ~: 0 do. 
   if. (IposA=lA-1) *. (lB=lA-1) do. 
    if. y=}:x do.
    '1';'I'
    end.
   else.
    '0';x;y
   end.
  elseif. (+/posB) ~: 0 do. 
   if. (IposB=lB-1) *. (lA=lB-1) do. 
    if. x=}:y do.
    '1';'I'
    end.
   else.
    '0';x;y
   end.
  elseif. posA=posA do.
   '0';x;y
  end.
 else.
  '0';x;y
 end.
end.
)

simpRules=:doubleOpSimp`identSimp`adjointSimp
doubleOpId=:1$'H'
generalOpId=:'TTTTTTTT';'TdTdTdTdTdTdTdTd'

simpl=: monad define
NB. applies the rules
len=.(#y)-1
seq=.i.len
done=.0
exit=.0
for_j. seq do.
 for_k. i.#simpRules do.
  res=. (j{y) (simpRules@.k) (j+1){y
  done=.".>0{res
  if. done=1 do.
   y=.(1{res) j } y
   y=.a: (j+1) } y
NB.   smoutput 'IN';y
   exit=.done
   break.
  end.
NB.  smoutput 'NO';y
 end.
end.
if. exit=1 do.
 y=.simpl y-.a:
end.
y-.a:
)

simplify=:monad define
y=.simpl M. y
for_k. generalOpId do.
 y=.}.k generalSimp y
end.
simpl M. y
)
