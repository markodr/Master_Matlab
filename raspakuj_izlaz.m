function [ broj ] = raspakuj_izlaz( vektor )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if vektor == [0;0;0;0;0;0;0;0;0]
    broj=0;
elseif vektor == [1;0;0;0;0;0;0;0;0]
    broj=1;
elseif vektor == [0;1;0;0;0;0;0;0;0]
    broj=2;
elseif vektor == [0;0;1;0;0;0;0;0;0]
    broj=3; 
elseif vektor == [0;0;0;1;0;0;0;0;0]
    broj=4; 
elseif vektor == [0;0;0;0;1;0;0;0;0]
    broj=5; 
elseif vektor == [0;0;0;0;0;1;0;0;0]
    broj=6;
elseif vektor == [0;0;0;0;0;0;1;0;0]
    broj=7; 
elseif vektor == [0;0;0;0;0;0;0;1;0]
    broj=8; 
elseif vektor == [0;0;0;0;0;0;0;0;1]
    broj=9; 
    
    
    
    
    
else
    broj=NaN;

end

