clc;
close all;
clear all;

%Data set 29-May-2021
Y1= dlmread ('~/Documents/repo/matlab/EDO/datasets/covid1.csv', ',', [0,3,inf,3]);
Y2  = dlmread ('~/Documents/repo/matlab/EDO/datasets/covid1.csv', ',', [0,3,inf,3]);

%Data set 31-May-2021

%Inicializa o vetor
X1 = [];

 %Cria um vetor coluna X com a mesma quantidade de linhas de Y
 for i=1:length(Y1)
   X1 = [X1; i];
 end


figure

%Plota os dados
scatter(X1,Y1)
hold on

%https://www.mathworks.com/help/matlab/ref/polyfit.html

%Specify two outputs to return the coefficients for the 3rd degree polinomial fit as well as the error estimation structure
[p,S] = polyfit(X1,Y1,3);

%Evaluate the third-degree polynomial fit in p at the points in X. Specify the error estimation structure as the third input so that polyval calculates an estimate of the standard error. The standard error estimate is returned in delta.

[y_fit,delta] = polyval(p,X1,S);

%Plot the original data, linear fit, and 95% prediction interval y±2Δ.

plot(X1,Y1,'bo')
hold on
grid on
plot(X1,y_fit,'r-')
plot(X1,y_fit+2*delta,'m--',X1,y_fit-2*delta,'m--')
legend('Dados','Regressão Polinomial','Intervalo de precisão 95%')
xlabel('Dia Transcorridos')
ylabel('Recuperados')
title('Regressão polinomial entre as variáveis')


%Fit Data
pkg load tablicious

%To see how good the fit is, evaluate the polynomial at the data points and generate a table showing the data, fit, and error.
format long
resid = Y1-y_fit;
tab = table (X1,Y1,y_fit,resid);
prettyprint (tab)


%Square the residuals and total them to obtain the residual sum of squares:

SSresid = sum(resid.^2);

%Compute the total sum of squares of y by multiplying the variance of y by the number of observations minus 1:

SStotal = (length(Y1)-1) * var(Y1);

%Compute R2 using the formula given in the introduction of this topic:
%For linear regression only
rsq = 1 - SSresid/SStotal

%Computing Adjusted R2 for Polynomial Regressions
%The adjusted R2, 0.8945, is smaller than simple R2, .9083. It provides a more reliable estimate of the power of your polynomial model to predict.
rsq_adj = 1 - SSresid/SStotal * (length(Y1)-1)/(length(Y1)-length(p))
