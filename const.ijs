invsq2=: %%:2
invpi4=: 0.25p1

SX=: conew 'Operator'
SY=: conew 'Operator'
SZ=: conew 'Operator'
I=: conew 'Operator'
H=: conew 'Operator'
T=: conew 'Operator'
Td=: conew 'Operator'


create__SX 'SX';(2 2$0 1 1 0);'SX' 
create__I 'I';(2 2$1 0 0 1);'I'
create__H 'H';(2 2$invsq2*(1 1 1 _1));'H'
create__SY 'SY';(2 2$0 0j_1 0j1 0);'SY'
create__SZ 'SZ';(2 2$1 0 0 _1);'SZ' 
create__T 'T';(2 2$1,0,0,invpi4);'T'
create__Td 'Td';(%.(2 2$1,0,0,invpi4));'Td'

iset_dict=:((<'H'),H),(<'I'),I