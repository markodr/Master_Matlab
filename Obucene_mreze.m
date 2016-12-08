%% Ucitavam jednu po jednu obucenu mrezu i pokazujem performanse
% https://www.mathworks.com/help/nnet/ref/plotconfusion.html#inputarg_targets
%% PRVA ANN [10 10]
clc; clear all; close all;  %Brisi sve
%%
load('1,2,3,6,8,10_7,5.mat');

% Konfuzija OBUKA
y_obuka=net(obuka_ulaz);
classes_obuka = vec2ind(y_obuka);
view(net)

figure();
plotconfusion(obuka_binarni_izlaz,y_obuka,'OBUKA')

RUCNA_OBUKA=[obuka_izlaz;classes_obuka];

pogodjeno=0;
for i=1:length(RUCNA_OBUKA)
    tmp=RUCNA_OBUKA(:,i);
    if tmp(1)==tmp(2)
        pogodjeno=pogodjeno+1;
    end   
end
fprintf('OBUKA Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno,length(RUCNA_OBUKA),pogodjeno/length(RUCNA_OBUKA)*100)

clear pogodjeno;

% Konfuzija TEST
y_test=net(test_ulaz);
classes_test = vec2ind(y_test);

figure();
plotconfusion(test_binarni_izlaz,y_test,'TEST')


RUCNA_TEST=[test_izlaz;classes_test];

pogodjeno=0;
for i=1:length(RUCNA_TEST)
    tmp=RUCNA_TEST(:,i);
    if tmp(1)==tmp(2)
        pogodjeno=pogodjeno+1;
    end   
end
fprintf('TEST Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno,length(RUCNA_TEST),pogodjeno/length(RUCNA_TEST)*100)
clear pogodjeno;


%% DRUGA ANN [20]
 close all; clear all; clc;
%% 
load('1,7,3,6,8,10_2,9.mat');
% Konfuzija OBUKA
y_obuka=net(obuka_ulaz);
classes_obuka = vec2ind(y_obuka);
view(net)

figure();
plotconfusion(obuka_binarni_izlaz,y_obuka,'OBUKA')

RUCNA_OBUKA=[obuka_izlaz;classes_obuka];

pogodjeno=0;
for i=1:length(RUCNA_OBUKA)
    tmp=RUCNA_OBUKA(:,i);
    if tmp(1)==tmp(2)
        pogodjeno=pogodjeno+1;
    end   
end
fprintf('OBUKA Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno,length(RUCNA_OBUKA),pogodjeno/length(RUCNA_OBUKA)*100)

clear pogodjeno;

% Konfuzija TEST
y_test=net(test_ulaz);
classes_test = vec2ind(y_test);

figure();
plotconfusion(test_binarni_izlaz,y_test,'TEST')


RUCNA_TEST=[test_izlaz;classes_test];

pogodjeno=0;
for i=1:length(RUCNA_TEST)
    tmp=RUCNA_TEST(:,i);
    if tmp(1)==tmp(2)
        pogodjeno=pogodjeno+1;
    end   
end
fprintf('TEST Pogodjeno %d od %d a to je %f procenata\n',...
       pogodjeno,length(RUCNA_TEST),pogodjeno/length(RUCNA_TEST)*100)
clear pogodjeno;

%% TRECA ANN [?]
 close all; clear all; clc;
%%
