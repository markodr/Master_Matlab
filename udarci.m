function [ pikovi ] = udarci(treshold,signal_1,signal_2,signal_3,signal_4)
%Trazimo odnos prvog signala u odnosu na sve 
%   

odnos=[];
for i=1:length(signal_1)
    odnos(i,1)=i;
    odnos(i,2)=signal_1(i)/signal_2(i);
    odnos(i,3)=signal_1(i)/signal_3(i);
    odnos(i,4)=signal_1(i)/signal_4(i);
end

pikovi=[];
v=1;
% Trazimo kada je jedna osa veca od ostale 3
for i=1:length(odnos)
    
         if (odnos(i,2)>1) && (odnos(i,3)>treshold)
            pikovi(v)=i;
            v=v+1;
         end
end
 
end

