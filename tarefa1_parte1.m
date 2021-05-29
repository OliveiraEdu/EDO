%https://www.mathworks.com/help/matlab/data_analysis/linear-regression.html

clear all;
clc;

% Lê o arquivo
a = csvread ('/home/eduardo/Documents/datasets/covid1.csv')

% Lê a segunda coluna (óbitos) e cria um vetor y
%y = dlmread ('/home/eduardo/Documents/datasets/covid1.csv', ',', [0,2,inf,2]);

%Lê a segunda coluna (recuperados) e cria um vetor y
y = dlmread ('/home/eduardo/Documents/datasets/covid1.csv', ',', [0,3,inf,3]);

%Cria um vetor v de comprimento igual a y
v = [];

for  n = 1:length(y)
    v = [v ; n];
end

scatter(v,y)

xlabel('Dia Transcorridos')
%ylabel('Óbitos')
ylabel('Recuperados')
title('Relação de regressão linear entre as variáveis')
grid on
