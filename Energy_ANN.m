clc
clear all
close all
 
    % Ucitaj Udrarac 1
[Energija_1,Signal_1]=energije(1,'Signali/p1_',11);
    % Ucitaj Udrarac 2
[Energija_2,Signal_2]=energije(2,'Signali/p2_',11);
    % Ucitaj Udrarac 3
[Energija_3,Signal_3]=energije(3,'Signali/p3_',11);
    % Ucitaj Udrarac 4
[Energija_4,Signal_4]=energije(4,'Signali/p4_',11);
    % Ucitaj Udrarac 5
%[Energija_5,Signal_5]=energije(5,'Signali/p5_',11);
    % Ucitaj Udrarac 6
[Energija_6,Signal_6]=energije(6,'Signali/p6_',11);
    % Ucitaj Udrarac 7
[Energija_7,Signal_7]=energije(7,'Signali/p7_',11);
    % Ucitaj Udrarac 8
[Energija_8,Signal_8]=energije(8,'Signali/p8_',11);
    % Ucitaj Udrarac 9
[Energija_9,Signal_9]=energije(9,'Signali/p9_',11);


% Iz ucitanih fajlova pravim TRAIN i TEST set, isti set za obe mreza
close all;

% Uzimamo svaki treci i osmi udarac za test set
train_set=[ 1,2,3,4,5,6,7,8,9,10];
test_set= [ 11]; % ,7,8,9,10,11

% OBUKA =============================================================
obuka_ulaz=[Energija_1(1:4,train_set),Energija_2(1:4,train_set)...
           ,Energija_3(1:4,train_set),Energija_4(1:4,train_set)...
           ,Energija_6(1:4,train_set)...
           ,Energija_7(1:4,train_set),Energija_8(1:4,train_set)...
           ,Energija_9(1:4,train_set)];
obuka_izlaz=[Energija_1(5,train_set),Energija_2(5,train_set)...
            ,Energija_3(5,train_set),Energija_4(5,train_set)...
            ,Energija_6(5,train_set)...
            ,Energija_7(5,train_set),Energija_8(5,train_set)...
            ,Energija_9(5,train_set)];
 
% TEST =============================================================  
test_ulaz=[Energija_1(1:4,test_set),Energija_2(1:4,test_set)...
          ,Energija_3(1:4,test_set),Energija_4(1:4,test_set)...
          ,Energija_6(1:4,test_set)...
          ,Energija_7(1:4,test_set),Energija_8(1:4,test_set)...
          ,Energija_9(1:4,test_set)];  
test_izlaz=[Energija_1(5,test_set),Energija_2(5,test_set)...
           ,Energija_3(5,test_set),Energija_4(5,test_set)...
           ,Energija_6(5,test_set)...
           ,Energija_7(5,test_set),Energija_8(5,test_set)...
           ,Energija_9(5,test_set)];  
        
       

clear Signal_1; clear Signal_2; clear Signal_3;
clear Signal_4; clear Signal_5; clear Signal_6;
clear Signal_7; clear Signal_8; clear Signal_9;
clear train_set; clear test_set;
  
%%

 ULAZ=[Energija_1(1:4,1:3),Energija_2(1:4,1:3)...
      ,Energija_3(1:4,1:3),Energija_4(1:4,1:3)...
      ,Energija_6(1:4,1:3),Energija_7(1:4,1:3)...
      ,Energija_8(1:4,1:3),Energija_9(1:4,1:3)];

izlazx=[Energija_1(5,1:3),Energija_2(5,1:3)...
       ,Energija_3(5,1:3),Energija_4(5,1:3)...
       ,Energija_6(5,1:3),Energija_7(5,1:3)...
       ,Energija_8(5,1:3),Energija_9(5,1:3)];     
%%
ULAZ=[obuka_ulaz];
IZLAZ=[];
for i=1:length(obuka_izlaz)
    tmp=de2bi(obuka_izlaz(i),4);
    IZLAZ(:,i)=tmp';
end



SMOR=[ULAZ;IZLAZ];

x=ULAZ;
t=IZLAZ;
net = patternnet([80,40]); %80,40
net = train(net,x,t);
%view(net)
y = net(x);
perf = perform(net,t,y);
classes = vec2ind(y);
%plotconfusion(IZLAZ,ULAZ);
%nnstart

% https://www.mathworks.com/help/nnet/gs/classify-patterns-with-a-neural-network.html
% https://www.mathworks.com/help/nnet/ref/softmax.html
% https://www.mathworks.com/help/nnet/examples/wine-classification.html
% https://www.mathworks.com/help/nnet/ug/train-and-apply-multilayer-neural-networks.html





%%
% % % %  %% Prebacujem iz binarnog u decimalni prikaz
% % % %  Estimacija_Decimalne_Obuke=[];
% % % %  for i=1:length(Estimacija_izlaza)
% % % %     tmp=Estimacija_izlaza(:,i)';
% % % %     Estimacija_Decimalne_Obuke(i)=bi2de(tmp);
% % % %  end
% % % %  %
% % % %  
% % % %  brojanje=[obuka_izlaz;Estimacija_Decimalne_Obuke];
% % % %  pogodjeno=0;
% % % %  for i=1:length(brojanje)
% % % %      tmp=brojanje(:,1);
% % % %      if tmp(1)==tmp(2)
% % % %          pogodjeno=pogodjeno+1;
% % % %      end
% % % %  end
% % % %  
% % % %  fprintf('OBUKA Pogodjeno %d od %d a to je %f procenata\n',ukupno,length(PROVERI_OBUKA_BINARNO),ukupno/length(PROVERI_OBUKA_BINARNO)*100)
% % % % 
% % % %  
% % % %  
% % % % %%
% % % %  
% % % %  PROVERI_OBUKA_BINARNO=[obuka_ulaz*globalni_maksimum;izlaz;binarna_estimacija_obuke;bin_dec_izlaz_obuke];
% % % %  
% % % %  ukupno=0;
% % % %  for i=1:length(PROVERI_OBUKA_BINARNO)
% % % %      
% % % %       if PROVERI_OBUKA_BINARNO(5,i)==PROVERI_OBUKA_BINARNO(10,i)
% % % %           ukupno=ukupno+1;
% % % %       end
% % % %  end
% % % %  
% % % % fprintf('OBUKA Pogodjeno %d od %d a to je %f procenata\n',ukupno,length(PROVERI_OBUKA_BINARNO),ukupno/length(PROVERI_OBUKA_BINARNO)*100)
% % % % 
% % % % 
% % % % 
% % % % %% Provera TESTA
% % % %  for(i=1:length(test_ulaz))
% % % %     binarna_estimacija_testa(:,i)=sim(net,test_ulaz(:,i)); 
% % % %  end
% % % %  
% % % % %  %Vrednost funkcije moze biti <0 pa to proglasavam sa 0
% % % % % velicina=size(binarna_estimacija_testa);
% % % % %  for i=1:velicina(1)
% % % % %     for v=1:velicina(2)
% % % % %        if binarna_estimacija_testa(i,v)<0
% % % % %            binarna_estimacija_testa(i,v)=0;
% % % % %        end
% % % % %        
% % % % %        if binarna_estimacija_testa(i,v)>1
% % % % %            binarna_estimacija_testa(i,v)=1;
% % % % %        end
% % % % %        
% % % % %     end
% % % % %  end
% % % % %  
% % % %   binarna_estimacija_testa=round(binarna_estimacija_testa);
% % % % 
% % % % 
% % % %  % Prebacujem iz binarnog u decimalni prikaz
% % % %  bin_dec_izlaz_testa=[];
% % % %  for i=1:length(binarna_estimacija_testa)
% % % %     tmp=binarna_estimacija_testa(:,i)';
% % % %     bin_dec_izlaz_testa(i)=bi2de(tmp);
% % % %  end
% % % %  
% % % %  PROVERI_TEST_BINARNO=[test_ulaz*globalni_maksimum;test_izlaz;binarna_estimacija_testa;bin_dec_izlaz_testa];
% % % %  
% % % %  
% % % %  ukupno=0;
% % % %  for i=1:length(PROVERI_TEST_BINARNO)
% % % %      
% % % %       if PROVERI_TEST_BINARNO(5,i)==PROVERI_TEST_BINARNO(10,i)
% % % %           ukupno=ukupno+1;
% % % %       end
% % % %  end
% % % %  
% % % % fprintf('TEST Pogodjeno %d od %d a to je %f procenata\n',ukupno,length(PROVERI_TEST_BINARNO),ukupno/length(PROVERI_TEST_BINARNO)*100)
% % % % 

%% Sledi provera signala

%PROVERA_obuka=[obuka_ulaz;obuka_binarni_izlaz]; clear PROVERA_obuka;
%PROVERA_test=[test_ulaz;test_binarni_izlaz]; clear PROVERA_test;


% Vizualizacija podataka
% https://www.mathworks.com/help/matlab/examples/visualizing-four-dimensional-data.html

%nnstart



% %% Treniramo KLASIFIKACIJU   logsig u izlazu da ne peglam <0 
% clc
% % 'purelin' 'logsig' 'tansig' 'hardlim' tansig ???
% % http://www.mathworks.com/help/nnet/ug/train-and-apply-multilayer-neural-networks.html
% S=[10,8]; %80,40
% TF= {'tansig','tansig','logsig'}; % Transfer function of ith layer.
% BTF= 'trainbfg'; % Backprop network training function : 'trainlm'   trainscg
% BLF= 'learngdm'; % Backprop weight/bias learning function : 'learngdm'
% PF=  'mse'; % Performance function
% IPF= {'fixunknowns'}; % Row cell array of input processing functions
% OPF= {'removeconstantrows'}; % Row cell array of output processing functions
% DDF= 'dividetrain'; % Data division function   dividerand korstim dividetrain
% 
% net=newff(obuka_ulaz,obuka_binarni_izlaz,S,TF,BTF,BLF,PF,IPF,OPF,DDF);
% 
% net.trainParam.epochs = 5000;
% net.trainParam.showWindow = true;
% net.trainParam.show= 1;
% %net.trainParam.min_grad=1e-16;
% net.performParam.regularization = 0.09; %0.00001 Sve ispod ne radi
% %net.trainParam.max_fail = 20;
% 
% 
% % Pocinjem obucavanje ANN 
% [net,tr]=train(net,obuka_ulaz,obuka_binarni_izlaz);% Batch Training (train).

