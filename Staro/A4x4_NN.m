%Radonova transformacija, tomografija, ct skener, mra...
clc
clear all
close all
% Ucitavam originalne podatke
Udarac_1=importdata('signal1.mat');
Udarac_2=importdata('signal2.mat');
Udarac_3=importdata('signal3.mat');
Udarac_4=importdata('signal4.mat');
Udarac_5=importdata('signal5.mat');
Udarac_6=importdata('signal6.mat');
Udarac_7=importdata('signal7.mat');
Udarac_8=importdata('signal8.mat');
Udarac_9=importdata('signal9.mat');

%% Plot sredjenih podataka

% Udarac 1
figure;
hold on;
legend('show');
title('Udarac 1');
plot(Udarac_1(:,1),Udarac_1(:,2),'r');
plot(Udarac_1(:,1),Udarac_1(:,3),'g');
plot(Udarac_1(:,1),Udarac_1(:,4),'b');
plot(Udarac_1(:,1),Udarac_1(:,5),'c');
legend('Acc 1','Acc 2','Acc 3','Acc 4');

% Udarac 2
figure;
legend('show');
title('Udarac 2');
hold on;
plot(Udarac_2(:,1),Udarac_2(:,2),'r');
plot(Udarac_2(:,1),Udarac_2(:,3),'g');
plot(Udarac_2(:,1),Udarac_2(:,4),'b');
plot(Udarac_2(:,1),Udarac_2(:,5),'c');
legend('Acc 1','Acc 2','Acc 3','Acc 4');

% Udarac 3
figure;
legend('show');
title('Udarac 3');
hold on;
plot(Udarac_3(:,1),Udarac_3(:,2),'r');
plot(Udarac_3(:,1),Udarac_3(:,3),'g');
plot(Udarac_3(:,1),Udarac_3(:,4),'b');
plot(Udarac_3(:,1),Udarac_3(:,5),'c');
legend('Acc 1','Acc 2','Acc 3','Acc 4');

% Udarac 4
figure;
legend('show');
title('Udarac 4');
hold on;
plot(Udarac_4(:,1),Udarac_4(:,2),'r');
plot(Udarac_4(:,1),Udarac_4(:,3),'g');
plot(Udarac_4(:,1),Udarac_4(:,4),'b');
plot(Udarac_4(:,1),Udarac_4(:,5),'c');
legend('Acc 1','Acc 2','Acc 3','Acc 4');

% Udarac 5
figure;
legend('show');
title('Udarac 5');
hold on;
plot(Udarac_5(:,1),Udarac_5(:,2),'r');
plot(Udarac_5(:,1),Udarac_5(:,3),'g');
plot(Udarac_5(:,1),Udarac_5(:,4),'b');
plot(Udarac_5(:,1),Udarac_5(:,5),'c');
legend('Acc 1','Acc 2','Acc 3','Acc 4');

% Udarac 6
figure;
legend('show');
title('Udarac 6');
hold on;
plot(Udarac_6(:,1),Udarac_6(:,2),'r');
plot(Udarac_6(:,1),Udarac_6(:,3),'g');
plot(Udarac_6(:,1),Udarac_6(:,4),'b');
plot(Udarac_6(:,1),Udarac_6(:,5),'c');
legend('Acc 1','Acc 2','Acc 3','Acc 4');

% Udarac 7
figure;
legend('show');
title('Udarac 7');
hold on;
plot(Udarac_7(:,1),Udarac_7(:,2),'r');
plot(Udarac_7(:,1),Udarac_7(:,3),'g');
plot(Udarac_7(:,1),Udarac_7(:,4),'b');
plot(Udarac_7(:,1),Udarac_7(:,5),'c');
legend('Acc 1','Acc 2','Acc 3','Acc 4');

% Udarac 8
figure;
legend('show');
title('Udarac 8');
hold on;
plot(Udarac_8(:,1),Udarac_8(:,2),'r');
plot(Udarac_8(:,1),Udarac_8(:,3),'g');
plot(Udarac_8(:,1),Udarac_8(:,4),'b');
plot(Udarac_8(:,1),Udarac_8(:,5),'c');
legend('Acc 1','Acc 2','Acc 3','Acc 4');

% Udarac 9
figure;
legend('show');
title('Udarac 9');
hold on;
plot(Udarac_9(:,1),Udarac_9(:,2),'r');
plot(Udarac_9(:,1),Udarac_9(:,3),'g');
plot(Udarac_9(:,1),Udarac_9(:,4),'b');
plot(Udarac_9(:,1),Udarac_9(:,5),'c');
legend('Acc 1','Acc 2','Acc 3','Acc 4');

% Prikaz dimenzije vektora

fprintf('Udarac_1 : %d x %d \n',size(Udarac_1))
fprintf('Udarac_2 : %d x %d \n',size(Udarac_2))
fprintf('Udarac_3 : %d x %d \n',size(Udarac_3))
fprintf('Udarac_4 : %d x %d \n',size(Udarac_4))
fprintf('Udarac_5 : %d x %d \n',size(Udarac_5))
fprintf('Udarac_6 : %d x %d \n',size(Udarac_6))
fprintf('Udarac_7 : %d x %d \n',size(Udarac_7))
fprintf('Udarac_8 : %d x %d \n',size(Udarac_8))
fprintf('Udarac_9 : %d x %d \n',size(Udarac_9))


%% Sredjivanje dimenzije podataka za ANN
close all
duzine_vekrora= [length(Udarac_1),length(Udarac_2),length(Udarac_3),...
                 length(Udarac_4),length(Udarac_5),length(Udarac_6),...
                 length(Udarac_7),length(Udarac_8),length(Udarac_9)];

duzina=min(duzine_vekrora);

Udarac_1=Udarac_1(1:duzina,2:5);
Udarac_2=Udarac_2(1:duzina,2:5);
Udarac_3=Udarac_3(1:duzina,2:5);
Udarac_4=Udarac_4(1:duzina,2:5);
Udarac_5=Udarac_5(1:duzina,2:5);
Udarac_6=Udarac_6(1:duzina,2:5);
Udarac_7=Udarac_7(1:duzina,2:5);
Udarac_8=Udarac_8(1:duzina,2:5);
Udarac_9=Udarac_9(1:duzina,2:5);

% Definisanje ulaznih podataka
ulaz=[Udarac_1,Udarac_2,Udarac_3,Udarac_4,Udarac_5,Udarac_6,Udarac_7,Udarac_8,Udarac_9];

% Definisanje izlaznih podataka
% x x x x
% y y y y
Polje_1=[1,1,1,1];
Polje_2=[2,2,2,2];
Polje_3=[3,3,3,3];

Polje_4=[4,4,4,4];
Polje_5=[5,5,5,5];
Polje_6=[6,6,6,6];

Polje_7=[7,7,7,7];
Polje_8=[8,8,8,8];
Polje_9=[9,9,9,9];

izlaz=[Polje_1,Polje_2,Polje_3,Polje_4,Polje_5,Polje_6,Polje_7,Polje_8,Polje_8];

%% KREIRANJE NEURALNE MREZE nnstart

DATA_PROVERA=[ulaz;izlaz];

% 'purelin' 'logsig' 'tansig' 'hardlim' tanh ???
% http://www.mathworks.com/help/nnet/ug/train-and-apply-multilayer-neural-networks.html
S=[14]; %S=[14,7,3];
TF= {'tansig','purelin'}; % Transfer function of ith layer.
BTF= 'trainlm'; % Backprop network training function : 'trainlm'
BLF= 'learngdm'; % Backprop weight/bias learning function : 'learngdm'
PF=  'mse'; % Performance function
IPF= {'fixunknowns'}; % Row cell array of input processing functions
OPF= {'removeconstantrows'}; % Row cell array of output processing functions
DDF= 'dividerand'; % Data division function  

net=newff(ulaz,izlaz,S,TF,BTF,BLF,PF,IPF,OPF,DDF);

net.trainParam.show = 50;
net.trainParam.lr = 0.1;
net.trainParam.epochs = 2000;
net.trainParam.goal = 1e-16;
net.trainParam.showWindow = true;
net.trainParam.show= 20;
net.performParam.regularization = 0.0001;

% Pocinjem obucavanje ANN 
[net,tr]=train(net,ulaz,izlaz);% Batch Training (train).

%%
%close all;
%clc;
% figure;
% hold on;
% vertikala=[0,0];
% horizontala=[-1,1];
% plot(horizontala,vertikala,'-r');
% plot(vertikala,horizontala,'-r');
% horizontala=[-1,1];
% plot(horizontala,vertikala,'-r');
% plot(vertikala,horizontala,'-r');

%% PRVI RED mean

IZLAZ=sim(net,Udarac_1);
disp((IZLAZ));
IZLAZ=sim(net,Udarac_2);
disp((IZLAZ));
IZLAZ=sim(net,Udarac_3);
disp((IZLAZ));
%% DRUGI RED mean

IZLAZ=sim(net,Udarac_4);
disp((IZLAZ));
IZLAZ=sim(net,Udarac_5);
disp((IZLAZ));
IZLAZ=sim(net,Udarac_6);
disp((IZLAZ));
%% TRECI RED mean

IZLAZ=sim(net,Udarac_7);
disp((IZLAZ));
IZLAZ=sim(net,Udarac_8);
disp((IZLAZ));
IZLAZ=sim(net,Udarac_9);
disp((IZLAZ));



