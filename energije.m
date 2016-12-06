function [ Inteziteti,Signal ] = energije( polje,Putanja,duzina )
%Broj polja, Putanja do fajlova,Broj fajlova
%   Funkcija vraca napakovane podatke za ANN
clc
v=1;
Signal=[];
for i=1:duzina
    ime_fajla=strcat(Putanja,num2str(i));
    ime_fajla=strcat(ime_fajla,'.mat')
    ulaz=importdata(ime_fajla);
    
    % Izracunaj srednju vrednost
    mean_1=mean(ulaz(1,:));
    mean_2=mean(ulaz(2,:));
    mean_3=mean(ulaz(3,:));
    mean_4=mean(ulaz(4,:));
    
    % Izracunaj energiju signala
    energija_1 = sum( (ulaz(1,:)-mean_1).^2 );
    energija_2 = sum( (ulaz(2,:)-mean_2).^2 );
    energija_3 = sum( (ulaz(3,:)-mean_3).^2 );
    energija_4 = sum( (ulaz(4,:)-mean_4).^2 );
    
    
    
    tmp=[energija_1;energija_2;energija_3;energija_4;polje];
    % Intezitet pakujem u petlji sa polje a ceo signal van petlje
    Signal=horzcat(Signal,ulaz);
    Inteziteti(v,:)=tmp;
    fprintf('\n %f, %f, %f, %f\n',energija_1,energija_2,energija_3,energija_4);
    v=v+1;
end
Inteziteti=Inteziteti.';
Signal=[ Signal,[polje;polje;polje;polje] ];

figure;
hold on;
legend('show');
title(num2str(polje));
plot(Signal(1,1:length(Signal)-1));
plot(Signal(2,1:length(Signal)-1));
plot(Signal(3,1:length(Signal)-1));
plot(Signal(4,1:length(Signal)-1));
legend('ACC 1', 'ACC 2', 'ACC 3', 'ACC 4');
hold off;


end

