% Da probamo da smanjim dimenziju vektora, definisemo treshold
%  i svaki ACC koji predje treshold definise se sa vrednoscu od 0 do 1
%  Onda jedna mreza estimira x a druga y osu
%    Udarac_1    Udarac_2    Udarac_3
%      0.8          1          0.6         
%       1          0.3          0           
%       0           0           1           
%       0           0           0           
%     Polje       Polje       Polje
%      -1           0           1
%
%




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

%% Normalizujem podakte na istu duzinu

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


%%
mali=sum(Udarac_1);
mali_1=[mali(1);mali(2);mali(3);mali(4)];

mali=sum(Udarac_2);
mali_2=[mali(1);mali(2);mali(3);mali(4)];

mali=sum(Udarac_3);
mali_3=[mali(1);mali(2);mali(3);mali(4)];

mali=sum(Udarac_4);
mali_4=[mali(1);mali(2);mali(3);mali(4)];

mali=sum(Udarac_5);
mali_5=[mali(1);mali(2);mali(3);mali(4)];

mali=sum(Udarac_6);
mali_6=[mali(1);mali(2);mali(3);mali(4)];

mali=sum(Udarac_7);
mali_7=[mali(1);mali(2);mali(3);mali(4)];

mali=sum(Udarac_8);
mali_8=[mali(1);mali(2);mali(3);mali(4)];

mali=sum(Udarac_9);
mali_9=[mali(1);mali(2);mali(3);mali(4)];


%% ANN data
mali_ulaz=[mali_1,mali_2,mali_3,mali_4,mali_5,mali_6,mali_7,mali_8,mali_9];
% Normalizacija podataka na 
%mali_ulaz=mali_ulaz/norm(mali_ulaz);
mali_izlaz=[ -1,0,1,-1,0,1,-1,0,1];

ANN_DATA=[mali_ulaz;mali_izlaz];


% 'purelin' 'logsig' 'tansig' 'hardlim' tanh ???
% http://www.mathworks.com/help/nnet/ug/train-and-apply-multilayer-neural-networks.html
S=[8,8]; %S=[8,8]
TF= {'tansig','purelin'}; % Transfer function of ith layer.
BTF= 'trainlm'; % Backprop network training function : 'trainlm'
BLF= 'learngdm'; % Backprop weight/bias learning function : 'learngdm'
PF=  'mse'; % Performance function
IPF= {'fixunknowns'}; % Row cell array of input processing functions
OPF= {'removeconstantrows'}; % Row cell array of output processing functions
DDF= 'dividerand'; % Data division function  

net_mali=newff(mali_ulaz,mali_izlaz,S,TF,BTF,BLF,PF,IPF,OPF,DDF);

net_mali.trainParam.show = 50;
net_mali.trainParam.lr = 0.00001; %0.00001;
net_mali.trainParam.epochs = 2000;
net_mali.trainParam.goal = 1e-3;
net_mali.trainParam.showWindow = true;
net_mali.trainParam.show= 1;
net_mali.performParam.regularization = 0.1; %0.00001;

% Pocinjem obucavanje ANN 
[net_mali,tr]=train(net_mali,mali_ulaz,mali_izlaz);% Batch Training (train).

%% DEFINSATI VEKTOR KOJI ODREDJUJE DOKLE JE KOJE POLJE !!! KREIRATI MATRICU KONFUZIJE
% Pruciti lerarning rate i regularizaciju kako uticu tu sam negde
clc


fprintf('Udarac 1 treba %d a ANN je %d \n',-1,round(sim(net_mali,mali_1)));
fprintf('Udarac 2 treba %d a ANN je %d \n', 0,round(sim(net_mali,mali_2)));
fprintf('Udarac 3 treba %d a ANN je %d \n', 1,round(sim(net_mali,mali_3)));
fprintf('\n');
fprintf('Udarac 4 treba %d a ANN je %d \n',-1,round(sim(net_mali,mali_4)));
fprintf('Udarac 5 treba %d a ANN je %d \n', 0,round(sim(net_mali,mali_5)));
fprintf('Udarac 6 treba %d a ANN je %d \n', 1,round(sim(net_mali,mali_6)));
fprintf('\n');
fprintf('Udarac 7 treba %d a ANN je %d \n',-1,round(sim(net_mali,mali_7)));
fprintf('Udarac 8 treba %d a ANN je %d \n', 0,round(sim(net_mali,mali_8)));
fprintf('Udarac 9 treba %d a ANN je %d \n', 1,round(sim(net_mali,mali_9)));

%%
% clc
% IZLAZ=sim(net_mali,mali_3);
% disp((IZLAZ));
% 
% IZLAZ=sim(net_mali,mali_5);
% disp((IZLAZ));
% IZLAZ=sim(net_mali,mali_9);
% disp((IZLAZ));
