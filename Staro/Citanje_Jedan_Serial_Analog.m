clear all
clc
close all
[Rezultati] = textread('Udarac 1.txt','%f');


% SAMO DOK NE POMNOZIM U KONTROLERU
Rezultati=Rezultati.*3.3;
%figure;
%plot(Rezultati);



data_1=[];
data_2=[];
data_3=[];
v=1;
k=1;

for i=1:length(Rezultati)
    if v==1
        data_1(k)=Rezultati(i);
        k=k+1;
    end
    if v==2
        data_2(k)=Rezultati(i);
        k=k+1;
    end
    if v==3
        data_3(k)=Rezultati(i);
        k=k+1;
    end
    
    v=v+1;
    
    if v>=4
        v=1;
    end
    
end






% sada lepo pakujem signal
signal_1=[];
v=1;
for i=1:length(data_1)
    if data_1(i) ~= 0
       signal_1(v)= data_1(i);
       v=v+1;
    end
end


signal_2=[];
v=1;
for i=1:length(data_2)
    if data_2(i) ~= 0
       signal_2(v)= data_2(i);
       v=v+1;
    end
end
    


signal_3=[];
v=1;
for i=1:length(data_3)
    if data_3(i) ~= 0
       signal_3(v)= data_3(i);
       v=v+1;
    end
end


% Treba da ih normalizujem na pravu duzinu
duzine=[];
duzine(1) = length(signal_1);
duzine(2) = length(signal_2);
duzine(3) = length(signal_3);

minimalna_duzna=min(duzine);

signal_1 = signal_1(1,1:minimalna_duzna);
signal_2 = signal_2(1,1:minimalna_duzna);
signal_3 = signal_3(1,1:minimalna_duzna);


figure;
hold on;
legend('show');
title('Pojedinacni signali')
plot(signal_1);
plot(signal_2);
plot(signal_3);
legend('A2 - Xa', 'A1 - Ya', 'A0 - Za')
hold off;


% % % % komplet=[];
% % % % % Ukupan sada intezitet
% % % % for i=1:length(signal_1)
% % % %     komplet(i)=abs(signal_1(i)) + abs(signal_2(i)) + abs(signal_3(i));
% % % % end
% % % % 
% % % % figure;
% % % % legend('show');
% % % % plot(komplet);
% % % % legend('|Xa|+|Ya|+|Za|')
% % % % 
% % % % title('Zbir apsolutnih vrednosti 3 ose ');
% % % % 


% Pojedinacni inteziteti

int_1=0;
int_2=0;
int_3=0;

for i=1:length(signal_1)
    int_1=int_1+abs(signal_1(i));
end
fprintf('\nUkupan intezitet ax = %f',int_1);

for i=1:length(signal_2)
    int_2=int_2+abs(signal_2(i));
end
fprintf('\nUkupan intezitet ay = %f',int_2);

for i=1:length(signal_3)
    int_3=int_3+abs(signal_3(i));
end
fprintf('\nUkupan intezitet az = %f',int_3);
