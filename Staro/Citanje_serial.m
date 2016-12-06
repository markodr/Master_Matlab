clear all
clc
close all
[Rezultati] = textread('sekvenca.txt','%f');

data_1=[];
data_2=[];
data_3=[];
data_4=[];
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
    if v==4
        data_4(k)=Rezultati(i);
        k=k+1;
    end
    v=v+1;
    
    if v>=5
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


signal_4=[];
v=1;
for i=1:length(data_4)
    if data_4(i) ~= 0
       signal_4(v)= data_4(i);
       v=v+1;
    end
end


figure;
hold on;
legend('show');
title('Pojedinacni acc')
plot(signal_1);
plot(signal_2);
plot(signal_3);
plot(signal_4);
legend('ACC 1', 'ACC 2', 'ACC 3', 'ACC 4')



% Deo koji izvlaci segmente

% Samo definisem ose da imaju logicka imena
prozor=20; % Ovo je perioda signala, podrazumeva se jedan udarac po periodi
prosirenje=5; % Ovo je da se prosiri pedioda za ANN posto su jako brze promene sa ACC
prag=4; % Treshold kojim gledam da li su aktivirani senzori

signal_1=signal_1';
signal_2=signal_2';
signal_3=signal_3';
signal_4=signal_4';

% OVEDE JE JEBENA GRESKA smanjiti da signali imaju istu duzinu
%zbir_inteziteta=[signal_1;signal_2;signal_3;signal_4];
zbir_inteziteta=signal_1+signal_2+signal_3+signal_4;

%%
osa=(1:length(zbir_inteziteta));
osa=osa';
figure;
plot(osa,zbir_inteziteta);

% Izvlacim vrednosti na x osi koji su sve senzori presli treshold
pocetak=1;
ukupno=1;
tresholdi=[];
tr=1; % VIDETI STA JE OVO

fprintf('\nOdbirci koji su presli treshold\n')
%

for i=1:length(osa) 
    if zbir_inteziteta(i)>=prag
            fprintf('%d odbirak : %d\n',ukupno,osa(i));
            ukupno=ukupno+1;
            tresholdi(tr)=osa(i);
            tr=tr+1;
    end       
        
end


%% Pretpostavljam da za vreme trajanja periode
% moze biti aktiviran samo jedan senzor

fprintf('\nIzvlacenje pocetka i kraja signala FALI POSLEDNJI UDARAC \n')
figure;
hold on;
index=1;
%udarac=[];
for i=1:length(tresholdi)
    for v=1:length(tresholdi)
        
        if abs ( tresholdi(v)-tresholdi(i)>=prozor )
            pocetak = tresholdi(i)-prosirenje;
            kraj = tresholdi(v-1)+prosirenje;
            fprintf('Pocetk : %d, Kraj : %d\n',pocetak,kraj)

            
            final_osa = osa(pocetak:kraj);
            
            kraj_intezitet_1 = signal_1 (pocetak:kraj);
            kraj_intezitet_2 = signal_2 (pocetak:kraj);
            kraj_intezitet_3 = signal_3 (pocetak:kraj);
            kraj_intezitet_4 = signal_4 (pocetak:kraj);            
            
            data=[final_osa,kraj_intezitet_1,kraj_intezitet_2,kraj_intezitet_3,kraj_intezitet_4];
            ime_fajla=strcat('signal',num2str(index));
            strcat(ime_fajla,'mat');
            save(ime_fajla,'data');
            
            plot(final_osa,kraj_intezitet_1,'r'); % 1
            plot(final_osa,kraj_intezitet_2,'g'); % 2
            plot(final_osa,kraj_intezitet_3,'b'); % 3
            plot(final_osa,kraj_intezitet_4,'c'); % 4
             
            i=v;
            index=index+1;
            
        end
    end
break;
end
