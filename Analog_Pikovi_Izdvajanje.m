clc
clear all
close all

% Ucitavam signal po signal, jebu me pikovi jer ne znam gde koji signal
% pocinje
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

% Iz prethodnog koda rucno sam izdvojio pikove signala

%% Sada cu da sredim rucno signale pa ce u MBED-u da peglam

close all

pikovi_1=[544,797,1050,1282,1560,1816,2103,2368,2603,2880,3162];
pikovi_2=[461,749,1025,1311,1602,1877,2196,2497,2776,3070,3389];
pikovi_3=[480,745,1022,1297,1572,1850,2116,2379,2646,2914,3200];
pikovi_4=[314,573,793,1069,1285,1525,1764,2000,2250,2466,2696];
pikovi_5=[301,572,825,1088,1369,1636,1878,2126,2402,2659,2946];
pikovi_6=[375,667,957,1237,1527,1818,2081,2368,2647,2926,3213];
pikovi_7=[372,664,960,1253,1503,1745,2036,2289,2561,2827,3124];
pikovi_8=[349,616,843,1091,1334,1581,1825,2119,2344,2595,2831];
pikovi_9=[368,590,794,1009,1230,1433,1649,1860,2076,2261,2546];

% Perioda signala koju sam ucitavao
perioda=30;









