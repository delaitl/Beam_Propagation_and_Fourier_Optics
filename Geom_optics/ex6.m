
% image formation trough 2 thin lenses

% distances are in cm
obj=-3; %position of the object plane
pos1=1; pos2=5; %position des 2 letnilles sur l'axe optique
f1=10; f2= -5; % focale des 2 letnilles

s1=obj-pos1; %-4 ici ok
[sp1, M1]=forma_img_lent(f1,s1)
sp1_abs=sp1+pos1 %sp1 dans le repaire absolu = sp1 + la position de la lentille
s2=sp1_abs-pos2
[sp2, M2]=forma_img_lent(f2,s2)
sp2_abs=sp2+pos2

M = M1*M2

%fonction qui sort l'abscise du plan image et la magnification laterale en
%fonction de la focale et la distane image (tout en cm)
function [sp M] = forma_img_lent(f,s)
 inv=1./f+1./s; sp=1./inv; M=sp./s;
end