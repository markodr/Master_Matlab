function [ vektor ] = pakuj_izlaz( broj )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
if broj==0
    vektor=[0;0;0;0;0;0;0;0;0];
end
if broj==1
    vektor=[1;0;0;0;0;0;0;0;0];
end
if broj==2
    vektor=[0;1;0;0;0;0;0;0;0];
end
if broj==3
    vektor=[0;0;1;0;0;0;0;0;0];
end
if broj==4
    vektor=[0;0;0;1;0;0;0;0;0];
end
if broj==5
    vektor=[0;0;0;0;1;0;0;0;0];
end
if broj==6
    vektor=[0;0;0;0;0;1;0;0;0];
end
if broj==7
    vektor=[0;0;0;0;0;0;1;0;0]; 
end
if broj==8
    vektor=[0;0;0;0;0;0;0;1;0];
end
if broj==9
    vektor=[0;0;0;0;0;0;0;0;1];
end


end

