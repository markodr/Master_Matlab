clear all
clc
close all
[Rezultati] = textread('p5.txt','%f');
Rezultati=Rezultati.*3.3;
% *3.3V i RACUNAM INTEZITET SA 4 ACC 

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
title('Pojedinacni acc');
plot(signal_1);
plot(signal_2);
plot(signal_3);
plot(signal_4);
legend('ACC 1', 'ACC 2', 'ACC 3', 'ACC 4');

% Ovde imam 4 inteziteta, malo je nezgodno.
% Logika je kada ja udarim u senzor svi ACC reaguju
% tj. reaguju vise nego u stanju mirovanja, zbog toga
% racunam jedan intezitet i na osnovu njega jurim periodu

svi_signali=[signal_1;signal_2;signal_3;signal_4];
intezitet = (signal_1+signal_2+signal_3+signal_4);
intezitet=[intezitet;1:length(intezitet)];
sort_intezitet=sortrows(intezitet.');
figure;
plot(intezitet(1,:));

% Sada cu da sredim rucno signale pa ce u MBED-u da peglam
pikovi_1=[544,797,1050,1282,1560,1816,2103,2368,2603,2880,3162];%
pikovi_2=[461,749,1025,1311,1602,1877,2196,2497,2776,3070,3389];%
pikovi_3=[480,745,1022,1297,1572,1850,2116,2379,2646,2914,3200];%
pikovi_4=[314,573,793,1069,1285,1525,1764,2000,2250,2466,2696];%
pikovi_5=[301,572,825,1088,1369,1636,1878,2126,2402,2659,2946];%
pikovi_6=[375,667,957,1237,1527,1818,2081,2368,2647,2926,3213];%
pikovi_7=[372,664,960,1253,1503,1745,2036,2289,2561,2827,3124];%
pikovi_8=[349,616,843,1091,1334,1581,1825,2119,2344,2595,2831];%
pikovi_9=[368,590,794,1009,1230,1433,1649,1860,2076,2261,2546];%

%% Funkcija koja snima signale, ispravni sinali su kopirani u folder Signali
% Paziti na imena signala, tj. ucitati signal i snimiti ga.
clc
snimi_signale(svi_signali,pikovi_1,30, 'p1_');

% HANDLE EXCEPTION !!!!




%% PRIKAZUJE POJEDINACNE SIGNALE koji su simljeni prthodnom funkcijom
izlaz=importdata('Signali/p9_11.mat');
figure;
hold on;
legend('show');
title('Perioda');
plot(izlaz(1,:));
plot(izlaz(2,:));
plot(izlaz(3,:));
plot(izlaz(4,:));
legend('ACC 1', 'ACC 2', 'ACC 3', 'ACC 4');
hold off;

% Uporediti itezitete
intezitet_1=0;
intezitet_2=0;
intezitet_3=0;
intezitet_4=0;
for(i=1:length(izlaz));
    intezitet_1=izlaz(1,(i))+intezitet_1;
    intezitet_2=izlaz(2,(i))+intezitet_2;
    intezitet_3=izlaz(3,(i))+intezitet_3;
    intezitet_4=izlaz(4,(i))+intezitet_4;
end


fprintf('\n %f, %f, %f, %f\n',intezitet_1,intezitet_2,intezitet_3,intezitet_4);


%%

% Ovo sortira po pikovima, ubaciti periodu kako ne bi kupio isti signal dva puta
% zajedno=[signal_3.'  ,   (1:length(signal_3)).'   ];
% sortirano=sortrows(zajedno);


% figure;
% hold on;
% plot(signal_1);
% plot(signal_2);
% plot(signal_3);
% legend('ACC 1', 'ACC 2','ACC 3');
% hold off;





% % % % %% OVO MENJA SIGNALE OBRISATI AKO TREBA JOS KODA
% % % % 
% % % % figure;
% % % % base_line=2.4;
% % % % hold on;
% % % % legend('show');
% % % % title('Prepeglavam na Base line');
% % % % 
% % % % for i=1:length(signal_1)
% % % %     if signal_1(i)<base_line
% % % %         signal_1(i)=base_line;
% % % %     end
% % % % end
% % % % 
% % % % for i=1:length(signal_2)
% % % %     if signal_2(i)<base_line
% % % %         signal_2(i)=base_line;
% % % %     end
% % % % end
% % % % 
% % % % for i=1:length(signal_3)
% % % %     if signal_3(i)<base_line
% % % %         signal_3(i)=base_line;
% % % %     end
% % % % end
% % % % 
% % % % for i=1:length(signal_4)
% % % %     if signal_4(i)<base_line
% % % %         signal_4(i)=base_line;
% % % %     end
% % % % end
% % % % 
% % % % plot(signal_1);
% % % % plot(signal_2);
% % % % plot(signal_3);
% % % % plot(signal_4);
% % % % legend('ACC 1', 'ACC 2', 'ACC 3', 'ACC 4')
% % % % 

%[mean(signal_1);mean(signal_2);mean(signal_3);mean(signal_4)]



% % Da vidimo sta se desava sa intezitetima
% 
% intezitet_1=0;
% intezitet_2=0;
% intezitet_3=0;
% intezitet_4=0;
% 
% i=1;
% intezitet_1=intezitet_1+signal_1(i);
% intezitet_2=intezitet_2+signal_2(i);
% intezitet_3=intezitet_3+signal_3(i);
% intezitet_4=intezitet_4+signal_4(i);
% 
% 
% fprintf('\nIntezitet 1 = %f',intezitet_1);
% fprintf('\nIntezitet 2 =%f',intezitet_2);
% fprintf('\nIntezitet 3 =%f',intezitet_3);
% fprintf('\nIntezitet 4 =%f\n',intezitet_4);
% 
% [mean(signal_1);mean(signal_2);mean(signal_3);mean(signal_4)];
% 
% % % ACC 1 Odnos udaraca
% % 
% % odnos=[];
% % treshold=1.1;
% % for i=1:length(signal_1)
% %     odnos(i,1)=i;
% %     odnos(i,2)=signal_1(i)/signal_2(i);
% %     odnos(i,3)=signal_1(i)/signal_3(i);
% %     odnos(i,4)=signal_1(i)/signal_4(i);
% % end
% % 
% % pikovi=[];
% % v=1;
% % % Trazimo kada je jedna osa veca od ostale 3
% % for i=1:length(odnos)
% %     
% %     if (odnos(i,2)>1) && (odnos(i,3)>treshold)
% %        pikovi(v)=i;
% %        v=v+1;
% %     end
% % end
% % 'ACC 1'
% % length(pikovi)
% % pikovi
% 
% treshold=1.1;
% 
% aktiviran_1=udarci(treshold,signal_1,signal_2,signal_3,signal_4);
% aktiviran_2=udarci(treshold,signal_2,signal_1,signal_3,signal_4);
% aktiviran_3=udarci(treshold,signal_3,signal_1,signal_2,signal_4);
% aktiviran_4=udarci(treshold,signal_4,signal_1,signal_2,signal_3);
% 
% [length(aktiviran_1),length(aktiviran_2),length(aktiviran_3),length(aktiviran_4)]
% 
