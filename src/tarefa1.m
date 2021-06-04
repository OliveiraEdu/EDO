clc;
clear all;
format short;
pkg load tablicious;

%Data Source
%https://datastudio.google.com/u/0/reporting/4ff82b8a-a9ff-4577-b239-da2e38d24443/page/vBjQB

%Data set 29-May-2021
Y1 = dlmread ('~/Documents/repo/matlab/EDO/datasets/covid1.csv', ',', [0,3,inf,3]);

%Data set 31-May-2021
Y2  = dlmread ('~/Documents/repo/matlab/EDO/datasets/covid2.csv', ',', [0,3,inf,3]);

%Inicializa o vetor X1
X1 = [];

%Cria um vetor coluna X1 com a mesma quantidade de linhas de Y1
 for i=1:length(Y1)
   X1 = [X1; i];
 end

%Inicializa o vetor X2
X2 = [];

%Cria um vetor coluna X2 com a mesma quantidade de linhas de Y2
 for j=1:length(Y2)
   X2 = [X2; j];
 end

%https://www.mathworks.com/help/matlab/ref/polyfit.html

%Specify two outputs to return the coefficients for the 3rd degree polinomial fit as well as the error estimation structure
[p,S] = polyfit(X1,Y1,3);

%Evaluate the third-degree polynomial fit in p at the points in X. Specify the error estimation structure as the third input so that polyval calculates an estimate of the standard error. The standard error estimate is returned in delta.

[y_fit,delta] = polyval(p,X1,S);

%To see how good the fit is, evaluate the polynomial at the data points and generate a table showing the data, fit, and error.
resid = Y1-y_fit;

%Fit Data

tab = table (X1,Y1,y_fit,resid);
prettyprint (tab)

%Square the residuals and total them to obtain the residual sum of squares:

SSresid = sum(resid.^2);

%Compute the total sum of squares of y by multiplying the variance of y by the number of observations minus 1:

SStotal = (length(Y1)-1) * var(Y1);

%Polinomy

fprintf('y = %fx³+%fx²+%fx+%f\n\n',p)

%Compute R2 using the formula given in the introduction of this topic:
%For linear regression only
rsq = 1 - SSresid/SStotal

%Computing Adjusted R2 for Polynomial Regressions
%The adjusted R2, 0.8945, is smaller than simple R2, .9083. It provides a more reliable estimate of the power of your polynomial model to predict.
rsq_adj = 1 - SSresid/SStotal * (length(Y1)-1)/(length(Y1)-length(p))

%Plot the original data, linear fit, and 95% prediction interval y±2Δ.

%Plota os dados
scatter(X1,Y1)

hold on

plot(X2,Y2,'.')

plot(X1,y_fit,'r-')
plot(X1,y_fit+2*delta,'m--',X1,y_fit-2*delta,'m--')

grid on


legend('Recuperados até 29/05/2021','Recuperados até 31/05/2021','Modelo (polinômio grau 3)','Intervalo de 95% de previsão','Location','northwest','NumColumns',1);

xlabel('Dia Transcorridos')
ylabel('Recuperados')
title('Regressão linear polinomial entre as variáveis')

%Plot of residuals
%Producing a fit using a linear model requires minimizing the sum of the squares of the residuals. 
%This minimization yields what is called a least-squares fit. 
%You can gain insight into the “goodness” of a fit by visually examining a plot of the residuals. 
%If the residual plot has a pattern (that is, residual data points do not appear to have a random scatter), the randomness indicates that the model does not properly fit the data.
figure
scatter(X1,resid,'*')
grid on
xlabel('Dia Transcorridos')
ylabel('Resíduo')
title('Análise de distribuição dos resíduos da regressão linear')




