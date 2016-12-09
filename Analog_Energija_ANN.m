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

% Brisanje nepotrebnih signala

% Ovde prepeglavam signale koji mi ne odgovaraju tj. lose su snimljeni 
%Energija_5(:,:)=Energija_5(:,:).*0;

% Kreiranje seta za obuku

% Kreiram set za obuku, u ovom slucaju u obuku ucitavam sve signale 
% prilikom ucitavanja mreza sama pravi test,obuku,validaciju

close all;
% Definisem koji indeks signala treba da ucitam
train_set =  [  3,4,7,8,10];
test_set =   [1,2,5,6,9,11];
test_set_1 = [1,2,5,6,9,11];%[1,2,9];

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
       
% DODATNI TEST da ubrzam trazenje odgovarajuce ANN

test_ulaz_1=[Energija_1(1:4,test_set_1),Energija_2(1:4,test_set_1)...
          ,Energija_3(1:4,test_set_1),Energija_4(1:4,test_set_1)...
          ,Energija_5(1:4,test_set_1),Energija_6(1:4,test_set_1)...
          ,Energija_7(1:4,test_set_1),Energija_8(1:4,test_set_1)...
          ,Energija_9(1:4,test_set_1)];  
test_izlaz_1=[Energija_1(5,test_set_1),Energija_2(5,test_set_1)...
          ,Energija_3(5,test_set_1),Energija_4(5,test_set_1)...
          ,Energija_5(5,test_set_1),Energija_6(5,test_set_1)...
          ,Energija_7(5,test_set_1),Energija_8(5,test_set_1)...
          ,Energija_9(5,test_set_1)]; 
       
% Ne koristim raw signale, zato ih brisem. Ucitani su samo zbog
% vizuelizacije

clear Signal_1; clear Signal_2; clear Signal_3;
clear Signal_4; clear Signal_5; clear Signal_6;
clear Signal_7; clear Signal_8; clear Signal_9;
clear train_set; clear test_set; clear test_set_1;

%% Normalizacija seta

obuka_maksimum=max(obuka_ulaz')';
test_maksimum=max(test_ulaz')';
test_1_maksimum=max(test_ulaz_1')';

tmp_obuka_ulaz=[];tmp_test_ulaz=[];tmp_test_ulaz_1=[];

for i=1:length(obuka_ulaz)
    tmp_obuka_ulaz(:,i)=obuka_ulaz(:,i)./obuka_maksimum;
end

for i=1:length(test_ulaz)
    tmp_test_ulaz(:,i)=test_ulaz(:,i)./test_maksimum;
end

for i=1:length(test_ulaz_1)
    tmp_test_ulaz_1(:,i)=test_ulaz_1(:,i)./test_1_maksimum;
end

obuka_ulaz=tmp_obuka_ulaz;
test_ulaz=tmp_test_ulaz;
test_ulaz_1=tmp_test_ulaz_1;


clear obuka_maksimum; clear test_maksimum; clear test_1_maksimum;
clear tmp_obuka_ulaz; clear tmp_test_ulaz; clear tmp_test_ulaz_1;

%% Kreiranje izlaza
% vec2ind korisim za proveru umesto mojih funkcija

obuka_binarni_izlaz=[];
for i=1:length(obuka_izlaz)
    tmp=pakuj_izlaz(obuka_izlaz(i));
    obuka_binarni_izlaz(:,i)=tmp';
end

% Ovo mi ne treba jer ne obucavam testom mrezu testom, ali ne brisati
% TREBA ZBOG KONFUZIJE
test_binarni_izlaz=[];
for i=1:length(test_izlaz)
    tmp=pakuj_izlaz(test_izlaz(i));
    test_binarni_izlaz(:,i)=tmp';
end

test_binarni_izlaz_1=[];
for i=1:length(test_izlaz_1)
    tmp=pakuj_izlaz(test_izlaz_1(i));
    test_binarni_izlaz_1(:,i)=tmp';
end

clear tmp;

%% Treniranje ANN
 
net = patternnet([40]); 
%net.performParam.rgularization = 0.001;
%net.trainParam.max_fail = 15;
%net.trainParam.min_grad=1e-3;
%plotconfusion(targets,outputs)
%plotconfusion();
net = train(net,obuka_ulaz,obuka_binarni_izlaz);
%perf = perform(net,obuka_binarni_izlaz,y);
%view(net)

% NE RADI MI MOJE RASPAKIVANJE IZLAZA

%% OBUKA propustam ceo set radi provere
clc
y_obuka = net(obuka_ulaz);
classes_obuka = vec2ind(y_obuka);

OBUKA=[obuka_izlaz;classes_obuka];

pogodjeno=0;
for i=1:length(OBUKA)
    tmp=OBUKA(:,i);
    if tmp(1)==tmp(2)
        pogodjeno=pogodjeno+1;
    end   
end


fprintf('OBUKA Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno,length(OBUKA),pogodjeno/length(OBUKA)*100)

clear pogodjeno; clear tmp

%% TEST propustam ceo set radi provere

y_test = net(test_ulaz);
classes_test = vec2ind(y_test);

TEST=[test_izlaz;classes_test];

pogodjeno=0;
for i=1:length(TEST)
    tmp=TEST(:,i);
    if tmp(1)==tmp(2)
        pogodjeno=pogodjeno+1;
    end   
end


fprintf('TEST  Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno,length(TEST),pogodjeno/length(TEST)*100)

clear pogodjeno; clear tmp

%% TEST 2 radi ubrzavanja trazenja mreze

% TEST propustam ceo set radi provere

y_test_1 = net(test_ulaz_1);

classes_test_1 = vec2ind(y_test_1);


TEST_1=[test_izlaz_1;classes_test_1];

pogodjeno=0;
for i=1:length(TEST_1)
    tmp=TEST_1(:,i);
    if tmp(1)==tmp(2)
        pogodjeno=pogodjeno+1;
    end   
end


fprintf('TEST  Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno,length(TEST_1),pogodjeno/length(TEST_1)*100)

clear pogodjeno; clear tmp

%% ============ PETLJA ============
% =======================================================================
% =======================================================================
clc
prag=80;
close all;
clear UPOREDI; clear OBUKA; clear TEST; clear TEST_1

UPOREDI=[];
for k=1:500
clear net;

% Mreza TIP 1
% https://www.mathworks.com/help/nnet/ug/choose-a-multilayer-neural-network-training-function.html
% https://www.mathworks.com/help/nnet/ref/crossentropy.html

% Entropija
net = patternnet(20);
net.performParam.regularization = 0.1;
net.performParam.normalization = 'none';




%view(net)
net.trainParam.showWindow=0; %default is 1)
%Obusavam mrezu
net = train(net,obuka_ulaz,obuka_binarni_izlaz);


% % % % Ucitavam OBUCENE MREZE radi provere
% % % %load('1,2,3,6,8,10_7,5.mat');
% % % %load('1,7,3,6,8,10_2,9.mat');

% Mreza TIP 2
% S=[20,20]; %% 'purelin' 'logsig' 'tansig' 'hardlim' tanh
% TF= {'logsig','logsig'}; % Transfer function of ith layer.
% BTF= 'trainlm'; % Backprop network training function : 'trainlm'
% BLF= 'learngdm'; % Backprop weight/bias learning function : 'learngdm'
% PF=  'mse'; % Performance function
% DDF= 'dividerand'; % Data division function  
% 
% net=newff(obuka_ulaz,obuka_binarni_izlaz,S,TF,BTF,BLF,PF);
% 
% net.trainParam.lr = 0.01;
% net.trainParam.epochs = 100;
% %net.trainParam.goal = 1e-3;
% %net.trainParam.show= 1;
% net.performParam.regularization = 0.0008; 
% net.trainParam.showWindow=0;
% [net,tr]=train(net,obuka_ulaz,obuka_binarni_izlaz);



% OBUKA propustam ceo set radi provere
fprintf('\n');
y_obuka = net(obuka_ulaz);
classes_obuka = vec2ind(y_obuka);

OBUKA=[obuka_izlaz;classes_obuka];

pogodjeno_obuka=0;
for i=1:length(OBUKA)
    tmp=OBUKA(:,i);
    if tmp(1)==tmp(2)
        pogodjeno_obuka=pogodjeno_obuka+1;
    end   
end


fprintf('OBUKA Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno_obuka,length(OBUKA),pogodjeno_obuka/length(OBUKA)*100)

clear tmp    


y_test = net(test_ulaz);
classes_test = vec2ind(y_test);

TEST=[test_izlaz;classes_test];

pogodjeno_test=0;
for i=1:length(TEST)
    tmp=TEST(:,i);
    if tmp(1)==tmp(2)
        pogodjeno_test=pogodjeno_test+1;
    end   
end


fprintf('TEST  Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno_test,length(TEST),pogodjeno_test/length(TEST)*100)

clear tmp 

%DRUGI TEST

y_test_1 = net(test_ulaz_1);
classes_test_1 = vec2ind(y_test_1);

TEST_1=[test_izlaz_1;classes_test_1];

pogodjeno_test_1=0;
for i=1:length(TEST_1)
    tmp=TEST_1(:,i);
    if tmp(1)==tmp(2)
        pogodjeno_test_1=pogodjeno_test_1+1;
    end   
end


fprintf('TEST_1 Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno_test_1,length(TEST_1),pogodjeno_test_1/length(TEST_1)*100)

clear tmp 

% KRAJ DRUGOG TESTA


if ( (pogodjeno_obuka/length(OBUKA)*100>=prag) && (pogodjeno_test/length(TEST)*100>=prag))...
                                ||  ... % ||
   ( (pogodjeno_obuka/length(OBUKA)*100>=prag) && (pogodjeno_test_1/length(TEST_1)*100>=prag))    


    fprintf('\nUSPESNO nakon %d !!!!!!',k);
    figure(1);
    plotconfusion(obuka_binarni_izlaz,y_obuka,'OBUKA');
    figure(2);
    plotconfusion(test_binarni_izlaz,y_test,'TEST');
    figure(3);
    plotconfusion(test_binarni_izlaz_1,y_test_1,'TEST_1');
    
    break
end
    UPOREDI(:,k)=[pogodjeno_obuka/length(OBUKA)*100;...
                  pogodjeno_test/length(TEST)*100;...
                  pogodjeno_test_1/length(TEST_1)*100];
    k=k+1;
    clear pogodjeno_obuka;
    clear pogodjeno_test;
    clear pogodjeno_test_1; 
end

fprintf('\nNEUSPELA OBUKA');
fprintf('\nMaksimum OBUKE %f',max(UPOREDI(1,:)));
fprintf('\nMaksimum TESTA %f',max(UPOREDI(2,:)));
fprintf('\nMaksimum TESTA %f',max(UPOREDI(3,:)));

