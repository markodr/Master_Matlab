close all;
clear all;

%M = csvread('C:\Users\Nenad Jovicic ETF\Documents\Dragoslavic\30.08.2016_08.54.16.zgz', 0, 0);%test1 - OK
M = csvread('/Users/Shared/punchb/30.08.2016_08.53.19.zgz', 0, 0);%test1 - OK

siz=size(M(:,1));
M(:,1)=1:siz(1);

figure;%TL - senzor na poziciji 1
subplot(6,1,1);
plot(M(:,1), M(:,2));%accx
subplot(6,1,2);
plot(M(:,1), M(:,3));%accy
subplot(6,1,3);
plot(M(:,1), M(:,4));%accz
subplot(6,1,4);
plot(M(:,1), M(:,5));%gyrox
subplot(6,1,5);
plot(M(:,1), M(:,6));%gyroy
subplot(6,1,6);
plot(M(:,1), M(:,7));%gyroz

ACCALL_1=M(:,2).^2+M(:,3).^2+M(:,4).^2;
%%
figure;%FL - senzor na poziciji 2
subplot(6,1,1);
plot(M(:,1), M(:,20));
subplot(6,1,2);
plot(M(:,1), M(:,21));
subplot(6,1,3);
plot(M(:,1), M(:,22));
subplot(6,1,4);
plot(M(:,1), M(:,23));
subplot(6,1,5);
plot(M(:,1), M(:,24));
subplot(6,1,6);
plot(M(:,1), M(:,25));

ACCALL_2=M(:,20).^2+M(:,21).^2+M(:,22).^2;
%%
figure;%SL - senzor na poziciji 3
subplot(6,1,1);
plot(M(:,1), M(:,11));
subplot(6,1,2);
plot(M(:,1), M(:,12));
subplot(6,1,3);
plot(M(:,1), M(:,13));
subplot(6,1,4);
plot(M(:,1), M(:,14));
subplot(6,1,5);
plot(M(:,1), M(:,15));
subplot(6,1,6);
plot(M(:,1), M(:,16));

ACCALL_3=M(:,11).^2+M(:,12).^2+M(:,13).^2;
%%
figure;%FR - senzor na poziciji 4
subplot(6,1,1);
plot(M(:,1), M(:,47));
subplot(6,1,2);
plot(M(:,1), M(:,48));
subplot(6,1,3);
plot(M(:,1), M(:,49));
subplot(6,1,4);
plot(M(:,1), M(:,50));
subplot(6,1,5);
plot(M(:,1), M(:,51));
subplot(6,1,6);
plot(M(:,1), M(:,52));

ACCALL_4=M(:,47).^2+M(:,48).^2+M(:,49).^2;
%%
figure;%zbir svih akcelarometara
subplot(4,1,1);
plot(M(:,1), ACCALL_1, 'r');
subplot(4,1,2);
plot(M(:,1), ACCALL_2, 'g');
subplot(4,1,3);
plot(M(:,1), ACCALL_3, 'b');
subplot(4,1,4);
plot(M(:,1), ACCALL_4, 'c');


%%


% ACCALL_1_cs=cumsum(ACCALL_1-mean(ACCALL_1));
% figure;%zbir svih akcelarometara u razlicitim bojama
% plot(M(:,1), ACCALL_1_cs, 'r');
% hold;

%segmentacija udarca
ACCALL_1234=ACCALL_1+ACCALL_2+ACCALL_3+ACCALL_4;
threshold=10000000;
totalsample=size(M);
punchseg=zeros(totalsample(1),1);
for i=1:totalsample(1)
    if ACCALL_1234(i)>threshold
        punchseg(i)=1;
    end
end

figure;%zbir svih akcelarometara u razlicitim bojama
subplot (3,1,1);
plot(M(:,1), ACCALL_1, 'r');
hold;
plot(M(:,1), ACCALL_2, 'g');
plot(M(:,1), ACCALL_3, 'b');
plot(M(:,1), ACCALL_4, 'y');
subplot (3,1,2);
plot(M(:,1), ACCALL_1234);
subplot (3,1,3);
plot(M(:,1), punchseg);

%vizuelizacija. Kao neki vektor. E sad problem je triangulacija, jer imamo
%4 senzora. Osim toga nije bas jednostavno





%% SPREMAM PODATKE ZA ANN
clc;
close all;
% Samo definisem ose da imaju logicka imena
osa=M(:,1);
prozor=10; % Ovo je perioda signala, podrazumeva se jedan udarac po periodi
prosirenje=5; % Ovo je da se prosiri pedioda za ANN posto su jako brze promene sa ACC
prag=1e7; % Treshold kojim gledam da li su aktivirani senzori

% ACC 1
S1_x=M(:,2);
S1_y=M(:,3);
S1_z=M(:,4);

% ACC 2
S2_x=M(:,20);
S2_y=M(:,21);
S2_z=M(:,22);

% ACC 3
S3_x=M(:,11);
S3_y=M(:,12);
S3_z=M(:,13);

% ACC 4
S4_x=M(:,47);
S4_y=M(:,48);
S4_z=M(:,49);

% Racunam pojedinacne intezitete, ovo ce se koristiti
% za obucavanje ANN
figure;
legend('show');
title('SVI INTEZITETI');
intezitet_1=S1_x.^2+S1_y.^2+S1_z.^2;
intezitet_2=S2_x.^2+S2_y.^2+S2_z.^2;
intezitet_3=S3_x.^2+S3_y.^2+S3_z.^2;
intezitet_4=S4_x.^2+S4_y.^2+S4_z.^2;
subplot (4,1,1);
plot(osa,intezitet_1);
legend('Acc 1');
subplot (4,1,2);
plot(osa,intezitet_2);
legend('Acc 2');
subplot (4,1,3);
plot(osa,intezitet_3);
legend('Acc 3');
subplot (4,1,4);
plot(osa,intezitet_4);
legend('Acc 4');
%%
% Racunam zbirni intezitet kako bi oderdio
% Kada je aktiviran neki senzor
figure;
legend('show');
title('Zbir Inteziteta');
zbir_inteziteta=intezitet_1+intezitet_2+intezitet_3+intezitet_4;
plot(osa,zbir_inteziteta);

% Izvlacim vrednosti na x osi koji su sve senzori presli treshold
pocetak=1;
ukupno=1;
tresholdi=[];
tr=1;

fprintf('\nOdbirci koji su presli treshold\n')


for i=1:length(osa) 
    if zbir_inteziteta(i)>=prag
            fprintf('%d odbirak : %d\n',ukupno,osa(i));
            ukupno=ukupno+1;
            tresholdi(tr)=osa(i);
            tr=tr+1;
    end       
        
end


% Pretpostavljam da za vreme trajanja periode
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
            
            kraj_intezitet_1 = intezitet_1 (pocetak:kraj);
            kraj_intezitet_2 = intezitet_2 (pocetak:kraj);
            kraj_intezitet_3 = intezitet_3 (pocetak:kraj);
            kraj_intezitet_4 = intezitet_4 (pocetak:kraj);            
            
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



%% Signal koji nedostaje udarac 9, obratiti paznju na dimenzije

clc
signal_9=[914;915;916;917;918;919;920;921;922;923;924;925;926;926];

signal_acc_9=[signal_9,intezitet_1(signal_9),intezitet_2(signal_9),intezitet_3(signal_9),intezitet_4(signal_9)];
save('signal9.mat','signal_acc_9')


%figure;
%plot(signal_9,signal_acc_9)

