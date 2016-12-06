function [ ] = snimi_signale( ulazni_signali,ulazni_pikovi,ulazna_perioda, ulazno_ime)
% 4xACC data,Pikovi,Perioda,Ime fajla
%   Funkcja dobija signale sa 4 acc,pikove, periodu i snima signale


for i=1:length(ulazni_pikovi)
    % Kreiram ime fajla
    ime_fajla=strcat(ulazno_ime,num2str(i));
    ime_fajla=strcat(ime_fajla,'.mat');
    ulazni_pikovi(i);
    izlaz=ulazni_signali(:,ulazni_pikovi(i)-ulazna_perioda:ulazni_pikovi(i)+ulazna_perioda);
    save(ime_fajla,'izlaz');
    fprintf('\nSaved %s',ime_fajla);
end
    





end

