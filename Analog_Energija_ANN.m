clc
clear all
close all

% Ucitavam kompletane signale - radi vizuelizacije podataka
% Ucitavam energiju segmenata koju pakujem zajedno sa izlazom ukupno 11
% prozora

[Energija_1,Signal_1]=energije(1,'Signali/p1_',11);
[Energija_2,Signal_2]=energije(2,'Signali/p2_',11);
[Energija_3,Signal_3]=energije(3,'Signali/p3_',11);
[Energija_4,Signal_4]=energije(4,'Signali/p4_',11);
[Energija_5,Signal_5]=energije(5,'Signali/p5_',11);
[Energija_6,Signal_6]=energije(6,'Signali/p6_',11);
[Energija_7,Signal_7]=energije(7,'Signali/p7_',11);
[Energija_8,Signal_8]=energije(8,'Signali/p8_',11);
[Energija_9,Signal_9]=energije(9,'Signali/p9_',11);

%% Brisanje nepotrebnih signala

% Ovde prepeglavam signale koji mi ne odgovaraju tj. lose su snimljeni 
%Energija_5(:,:)=Energija_5(:,:).*0;

%% Kreiranje seta za obuku

% Kreiram set za obuku, u ovom slucaju u obuku ucitavam sve sginale 
% prilikom ucitavanja mreza sama pravi test,obuku,validaciju

% ======== PROVERITI DA SE NISAM ZAJEBAO PRILIKOM IZVLACENJA !!!

close all;
% Definisem koji indeks signala treba da ucitam
train_set=[ 1,3,4,6,7,8,10,11];
% Ne koristim poziciju 5 pa za test koristim signal koji sam izbacio
test_set= [2,5,9]; %Ovde koristim samo 5 3,7,9

% OBUKA =============================================================
obuka_ulaz=[Energija_1(1:4,train_set),Energija_2(1:4,train_set)...
           ,Energija_3(1:4,train_set),Energija_4(1:4,train_set)...
           ,Energija_5(1:4,train_set),Energija_6(1:4,train_set)...
           ,Energija_7(1:4,train_set),Energija_8(1:4,train_set)...
           ,Energija_9(1:4,train_set)];
obuka_izlaz=[Energija_1(5,train_set),Energija_2(5,train_set)...
            ,Energija_3(5,train_set),Energija_4(5,train_set)...
            ,Energija_5(5,train_set),Energija_6(5,train_set)...
            ,Energija_7(5,train_set),Energija_8(5,train_set)...
            ,Energija_9(5,train_set)];
 
% TEST =============================================================  
test_ulaz=[Energija_1(1:4,test_set),Energija_2(1:4,test_set)...
          ,Energija_3(1:4,test_set),Energija_4(1:4,test_set)...
          ,Energija_5(1:4,test_set),Energija_6(1:4,test_set)...
          ,Energija_7(1:4,test_set),Energija_8(1:4,test_set)...
          ,Energija_9(1:4,test_set)];  
test_izlaz=[Energija_1(5,test_set),Energija_2(5,test_set)...
           ,Energija_3(5,test_set),Energija_4(5,test_set)...
           ,Energija_5(5,test_set),Energija_6(5,test_set)...
           ,Energija_7(5,test_set),Energija_8(5,test_set)...
           ,Energija_9(5,test_set)];  
        
       
% Ne koristim raw signale, zato ih brisem. Ucitani su samo zbog
% vizuelizacije

clear Signal_1; clear Signal_2; clear Signal_3;
clear Signal_4; clear Signal_5; clear Signal_6;
clear Signal_7; clear Signal_8; clear Signal_9;
clear train_set; clear test_set;

% Normalizacija seta

obuka_maksimum=max(obuka_ulaz')';
test_maksimum=max(test_ulaz')';

for i=1:length(obuka_ulaz)
    obuka_ulaz(:,i)=obuka_ulaz(:,i)./obuka_maksimum;
end

for i=1:length(test_ulaz)
    test_ulaz(:,i)=test_ulaz(:,i)./test_maksimum;
end

clear obuka_maksimum; clear test_maksimum

%% Kreiranje izlaza

% LOSE SAMO KODIDAO VEKTORE :(
% https://www.mathworks.com/help/nnet/ref/vec2ind.html

obuka_binarni_izlaz=[];
for i=1:length(obuka_izlaz)
    tmp=pakuj_izlaz(obuka_izlaz(i));
    obuka_binarni_izlaz(:,i)=tmp';
end

test_binarni_izlaz=[];
for i=1:length(test_izlaz)
    tmp=pakuj_izlaz(test_izlaz(i));
    test_binarni_izlaz(:,i)=tmp';
end

clear tmp;

%% Treniranje ANN

net = patternnet([10,10]); % [80,40] [150,150] []
%net.trainParam.max_fail = 15;
%net.trainParam.min_grad=1e-6;
net.performParam.regularization = 0.0001;
%plotconfusion(targets,outputs)
plotconfusion();
net = train(net,obuka_ulaz,obuka_binarni_izlaz);

y = net(obuka_ulaz);
%classes = vec2ind(y);raspakuj_izlaz

% OVDE PUCA SREDITI SRANJE JER PRIMA VEKTOR NA MATRICU...
y_round=round(y);
classes = raspakuj_izlaz(y_round);

UPOREDI=[obuka_izlaz;classes];
%perf = perform(net,obuka_binarni_izlaz,y);
%view(net)

% Provera OBUKE seta
% Propustam test set koji sam definisao na pocetku. Ove odbirke mreza nije
% koristila za obucavanje

clc
simuliran_obuka_izlaz=[];
for(i=1:length(obuka_ulaz))
    simuliran_obuka_izlaz(:,i)=sim(net,obuka_ulaz(:,i));
end

simuliran_test_obuka_vector = raspakuj_izlaz(simuliran_obuka_izlaz);

OBUKA=[obuka_izlaz;simuliran_test_obuka_vector];

%
pogodjeno=0;
for i=1:length(OBUKA)
    tmp=OBUKA(:,i);
    if tmp(1)==tmp(2)
        pogodjeno=pogodjeno+1;
    end   
end


fprintf('OBUKA Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno,length(OBUKA),pogodjeno/length(OBUKA)*100)

% % Ulazni_Signal=obuka_ulaz;
% % Simuliran_Izlaz=[];
% %  for(i=1:length(Ulazni_Signal))
% %     Simuliran_Izlaz(:,i)=sim(net,Ulazni_Signal(:,i)); 
% %  end
% % %%
% % Simuliran_Izlaz=round(Simuliran_Izlaz);
% %  
% %  
% % Simuliran_Decimalni_Izlaz=[]; 
% %   for i=1:length(Simuliran_Izlaz)
% %     tmp=Simuliran_Izlaz(:,i)';
% %     Simuliran_Decimalni_Izlaz(i)=bi2de(tmp);
% %   end
% %  
% % 
% % uporedjivanje=[obuka_izlaz;Simuliran_Decimalni_Izlaz];  
% % pogodjeno=0;
% % for i=1:length(uporedjivanje)
% %     xtmp=uporedjivanje(:,i);
% %     if xtmp(1)==xtmp(2)
% %         pogodjeno=pogodjeno+1;
% %     end
% % end
% % 
% % fprintf('OBUKA Pogodjeno %d od %d a to je %f procenata\n',...
% %        pogodjeno,length(uporedjivanje),pogodjeno/length(uporedjivanje)*100)
% % 
% %  
% clear pogodjeno; clear uporedjivanje;
% clear Simuliran_Izlaz; clear Ulazni_Signal;
% clear Simuliran_Decimalni_Izlaz;
 

