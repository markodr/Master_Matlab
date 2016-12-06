clc
clear all
close all

% Ucitaj Udrarac 1
[Intezitet_1,Signal_1]=pakovanje(1,'Signali/p1_',11);
% Ucitaj Udrarac 2
[Intezitet_2,Signal_2]=pakovanje(2,'Signali/p2_',11);
% Ucitaj Udrarac 3
[Intezitet_3,Signal_3]=pakovanje(3,'Signali/p3_',11);
% Ucitaj Udrarac 4
[Intezitet_4,Signal_4]=pakovanje(4,'Signali/p4_',11);
% Ucitaj Udrarac 5
[Intezitet_5,Signal_5]=pakovanje(5,'Signali/p5_',11);
% Ucitaj Udrarac 6
[Intezitet_6,Signal_6]=pakovanje(6,'Signali/p6_',11);
% Ucitaj Udrarac 7
[Intezitet_7,Signal_7]=pakovanje(7,'Signali/p7_',11);
% Ucitaj Udrarac 8
[Intezitet_8,Signal_8]=pakovanje(8,'Signali/p8_',11);
% Ucitaj Udrarac 9
[Intezitet_9,Signal_9]=pakovanje(9,'Signali/p9_',11);


%% Iz ucitanih fajlova pravim TRAIN i TEST set, isti set za obe mreza
close all;
%1-11 12-22 23-33 34-44 45-55 56-66 67-77 78-88 89-99

% Uzimamo svaki treci i osmi udarac za test set
train_set=[ 1:2, 6:9, 11 ];
test_set=[3,4,5,10];

% Ovim obucamamo ANN
      ulaz=[Intezitet_1(1:4,train_set),Intezitet_2(1:4,train_set)...
           ,Intezitet_3(1:4,train_set),Intezitet_4(1:4,train_set)...
           ,Intezitet_5(1:4,train_set),Intezitet_6(1:4,train_set)...
           ,Intezitet_7(1:4,train_set),Intezitet_8(1:4,train_set)...
           ,Intezitet_9(1:4,train_set)];
 
% Kreiram decimalni broj u izlazu
     izlaz=[Intezitet_1(5,train_set),Intezitet_2(5,train_set)...
           ,Intezitet_3(5,train_set),Intezitet_4(5,train_set)...
           ,Intezitet_5(5,train_set),Intezitet_6(5,train_set)...
           ,Intezitet_7(5,train_set),Intezitet_8(5,train_set)...
           ,Intezitet_9(5,train_set)];
 
% Ovim testiramo ANN   
   test_ulaz=[Intezitet_1(1:4,test_set),Intezitet_2(1:4,test_set)...
            ,Intezitet_3(1:4,test_set),Intezitet_4(1:4,test_set)...
            ,Intezitet_5(1:4,test_set),Intezitet_6(1:4,test_set)...
            ,Intezitet_7(1:4,test_set),Intezitet_8(1:4,test_set)...
            ,Intezitet_9(1:4,test_set)];  
   
% Kreiram decimalni broj u izlazu
  test_izlaz=[Intezitet_1(5,test_set),Intezitet_2(5,test_set)...
             ,Intezitet_3(5,test_set),Intezitet_4(5,test_set)...
             ,Intezitet_5(5,test_set),Intezitet_6(5,test_set)...
             ,Intezitet_7(5,test_set),Intezitet_8(5,test_set)...
             ,Intezitet_9(5,test_set)];  
         
%%  Pravim Binarni izlaz zbog klasifikacije
binarni_izlaz=[];
for i=1:length(izlaz)
    tmp=de2bi(izlaz(i),4);
    binarni_izlaz(:,i)=tmp';
end

binarni_test_izlaz=[];
for i=1:length(test_izlaz)
    tmp=de2bi(izlaz(i),4);
    binarni_test_izlaz(:,i)=tmp';
end


% Trazenje Maksimuma
maksimum_1=[ulaz;izlaz];
maksimum_2=[test_ulaz;test_izlaz];
prvi=max(max(maksimum_1));
drugi=max(max(maksimum_2));
globalni_maksimum=max(prvi,drugi);

% Normalizacija ulaznih podataka
ulaz=ulaz/globalni_maksimum;
test_ulaz=test_ulaz/globalni_maksimum;


%% Treniramo PURELIN ANN 
clc
% 'purelin' 'logsig' 'tansig' 'hardlim' tanh ???
% http://www.mathworks.com/help/nnet/ug/train-and-apply-multilayer-neural-networks.html
S=[40,4];
TF= {'logsig','purelin'}; % Transfer function of ith layer.
BTF= 'trainlm'; % Backprop network training function : 'trainlm'
BLF= 'learngdm'; % Backprop weight/bias learning function : 'learngdm'
PF=  'mse'; % Performance function
IPF= {'fixunknowns'}; % Row cell array of input processing functions
OPF= {'removeconstantrows'}; % Row cell array of output processing functions
DDF= 'dividerand'; % Data division function  

net=newff(ulaz,izlaz,S,TF,BTF,BLF,PF,IPF,OPF,DDF);

net.trainParam.show = 50;
%net.trainParam.lr = 0.0001; %0.00001;
net.trainParam.epochs = 1000;
%net.trainParam.goal = 1e-6;
%net.trainParam.mu = 0.00001;
net.trainParam.showWindow = true;
net.trainParam.show= 10;
%net.performParam.regularization = 0.00001; %0.00001;
net.trainParam.max_fail=10;
% Pocinjem obucavanje ANN 
[net,tr]=train(net,ulaz,izlaz);% Batch Training (train).




%%
clc
clear PROVERI
clear PROVERI_OBUKA
clear estimacija

%
 for(i=1:length(test_ulaz))
    
    estimacija(1,i)=sim(net,test_ulaz(:,i));
     
 end
 
estimacija=[test_ulaz;test_izlaz;estimacija];
PROVERI_TEST=[estimacija;round(estimacija(6,:))];

clear estimacija


 for(i=1:length(ulaz))
    
    estimacija(1,i)=sim(net,ulaz(:,i));
     
 end
 
 estimacija=[ulaz;izlaz;estimacija];

PROVERI_OBUKA=[estimacija;round(estimacija(6,:))];


pogodjeno=0;
for i=1:length(PROVERI_OBUKA)
if PROVERI_OBUKA(5,i)==PROVERI_OBUKA(7,i)
    pogodjeno=pogodjeno+1;
end
    
end

fprintf('OBUKA Pogodjeno %d od %d a to je %f procenata\n',pogodjeno,length(PROVERI_OBUKA),pogodjeno/length(PROVERI_OBUKA)*100)



pogodjeno=0;
for i=1:length(PROVERI_TEST)
        if PROVERI_TEST(5,i)==PROVERI_TEST(7,i) 
            pogodjeno=pogodjeno+1;
        
        
    end
    
end

fprintf('TEST Pogodjeno %d od %d a to je %f procenata\n',pogodjeno,length(PROVERI_TEST),pogodjeno/length(PROVERI_TEST)*100)

% PRIKAZATI ULAZNE VEKTORE



