NB. operator class file

coclass 'Operator'

create =: 3 : 0
name =: >0{y
matrix =: >1{y
anc =. >2{y
if. (#anc)=0 do.
 ancestors =: name
else.
 ancestors =: anc
end.
)

str =: 3 : 0
(<('Operator:  ', name__y)),:<('Ancestors: ',ancestors__y)
)

printMatrix =: monad define
matrix__y
)

addAncestor =: 3 : 0
other=.>0{y
new_name=.>1{y
nAnc =. ancestors,ancestors__other
op=.conew 'Operator'
create__op new_name;(0 0$0);nAnc
op
)

matrixFromAncestors =: 3 : 0
NB. Sets the matrix of this operator by its ancestors taken from a set
NB. iset - a dictionary of labels to operators for the instruction set
NB. identity - the identity to start multiplication with
matr=.matrix__y NB. identity matrix passed as argument
for_ancestor. ancestors do.
 matr=.matr +.* getMfromA ancestor
end.
matr
)

multiply =: dyad define
NB. multiplication between operators.
NB. returns operator
nm=.matrix__x +/ .* matrix__y
anc=.ancestors__x,ancestors__y
op=.conew 'Operator'
create__op '';nm;anc
op
)

str_z_ =: str_Operator_
printMatrix_z_ =: printMatrix_Operator_
addAncestor_z_ =: addAncestor_Operator_
matrixFromAncestors_z_ =: matrixFromAncestors_Operator_
multiply_z_ =: multiply_Operator_


