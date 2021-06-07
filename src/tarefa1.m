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

%Cria um vetor coluna X2 com a mesma quantidade de linhas de Y2
%The easiest way to create an equally spaced column vector is to create a row vector and transpose it.
X1=transpose(1:length(Y1));


%Cria um vetor coluna X2 com a mesma quantidade de linhas de Y2
X2=transpose(1:length(Y2));


%https://www.mathworks.com/help/matlab/ref/polyfit.html

%Specify two outputs to return the coefficients for the 3rd degree polinomial fit as well as the error estimation structure
[p1,S1] = polyfit(X1,Y1,1);
[p2,S2] = polyfit(X1,Y1,2);
[p3,S3] = polyfit(X1,Y1,3);


%Evaluate the third-degree polynomial fit in p at the points in X. Specify the error estimation structure as the third input so that polyval calculates an estimate of the standard error. The standard error estimate is returned in delta.

[y_fit1,delta1] = polyval(p1,X1,S1);
[y_fit2,delta2] = polyval(p2,X1,S2);
[y_fit3,delta3] = polyval(p3,X1,S3);

%To see how good the fit is, evaluate the polynomial at the data points and generate a table showing the data, fit, and error.
%Also known as Forecast Error
resid1 = Y1-y_fit1;
resid2 = Y1-y_fit2;
resid3 = Y1-y_fit3;

%Fit Data

%tab = table (X1,Y1,y_fit,resid);
%prettyprint (tab)

%Square the residuals and total them to obtain the residual sum of squares:
SSresid1 = sum(resid1.^2);
SSresid2 = sum(resid2.^2);
SSresid3 = sum(resid3.^2);

%MAPE
pre_MAPE1 = abs((y_fit1-Y1)./Y1);
MAPE1 = mean(pre_MAPE1(isfinite(pre_MAPE1)))

pre_MAPE2 = abs((y_fit2-Y1)./Y1);
MAPE2 = mean(pre_MAPE2(isfinite(pre_MAPE2)))

pre_MAPE3 = abs((y_fit3-Y1)./Y1);
MAPE3 = mean(pre_MAPE3(isfinite(pre_MAPE3)))


% Errors
%error=(Y1 - y_fit1);

% Squared Error
%sqr-error=(Y1 - y_fit1).^2;

% Mean Squared Error
MSE1 = mean((Y1 - y_fit1).^2);
MSE2 = mean((Y1 - y_fit2).^2);
MSE3 = mean((Y1 - y_fit3).^2);

%RMSE - Root Mean Squared Error
RMSE1 = sqrt(mean((Y1- y_fit1).^2))
RMSE2 = sqrt(mean((Y1- y_fit2).^2))
RMSE3 = sqrt(mean((Y1- y_fit3).^2))

%Compute the total sum of squares of y by multiplying the variance of y by the number of observations minus 1:

SStotal1 = (length(Y1)-1) * var(Y1);
SStotal2 = (length(Y1)-1) * var(Y1);
SStotal3 = (length(Y1)-1) * var(Y1);


%Describes the polinomy

fprintf('Linear y = %fx+%f\n\n',p1)
fprintf('Quadrática y = %fx²+%fx+%f\n\n',p2)
fprintf('Cúbica y = %fx³+%fx²+%fx+%f\n\n',p3)


%Compute R2 using the formula given in the introduction of this topic:
%For linear regression only
rsq1 = 1 - SSresid1/SStotal1
rsq2 = 1 - SSresid2/SStotal2
rsq3 = 1 - SSresid3/SStotal3


%Computing Adjusted R2 for Polynomial Regressions
%Usually the adjusted R2 is smaller than simple R2. It provides a more reliable estimate of the power of your polynomial model to predict.
rsq_adj1 = 1 - SSresid1/SStotal1 * (length(Y1)-1)/(length(Y1)-length(p1))
rsq_adj2 = 1 - SSresid2/SStotal2 * (length(Y1)-1)/(length(Y1)-length(p2))
rsq_adj3 = 1 - SSresid3/SStotal3 * (length(Y1)-1)/(length(Y1)-length(p3))


%tab = table (X1,Y1,y_fit1,resid1);
%prettyprint (tab,['RMSE'; 'MAPE'; 'R²','R*²'],[' ';'linear';'quadrática'; 'cúbica'])

%Plot the original data, linear fit, and 95% prediction interval y±2Δ.

%Plota os dados da semana base
plot(X1,Y1,'ob','linewidth',2)

xlabel('Dia Transcorridos')
ylabel('Indivíduos Recuperados')


hold on
%Plota os dados da semana posterior
%plot(X2,Y2,'.')

%Plota a projeção Linearscatter
plot(X1,y_fit1,'--g', 'linewidth', 2)

%Plota a projeção Quadrática
plot(X1,y_fit2,'-m', 'linewidth', 2)

%Plota a projeção cúbica
plot(X1,y_fit3,'..r', 'linewidth', 2)

grid on

legend('Indivíduos Recuperados até 29/05/2021','Linear','Quadrática','Cúbica','Location','northwest','NumColumns',1);
title('Regressão linear polinomial entre as variáveis')

%Linear
figure
%Plota os dados da semana base
scatter(X1,Y1,'ob','linewidth',2)
hold on

%Plota a projeção Linear
plot(X1,y_fit1,'r-','linewidth', 2)
plot(X1,y_fit1+2*delta1,'g--','linewidth', 2,X1,y_fit1-2*delta1,'g--','linewidth', 2)

grid on

legend('Indivíduos Recuperados até 29/05/2021','Linear','Intervalo de confiança de 95%','Location','northwest','NumColumns',1);

xlabel('Dia Transcorridos')
ylabel('Indivíduos Recuperados')
title('Regressão linear polinomial entre as variáveis')


%Quadrática
figure
%Plota os dados da semana base
scatter(X1,Y1,'ob','linewidth',2)
hold on

%Plota a projeção Quadrática
plot(X1,y_fit2,'r-','linewidth', 2)

plot(X1,y_fit2+2*delta2,'g--','linewidth', 2,X1,y_fit2-2*delta2,'g--','linewidth', 2)

grid on

legend('Indivíduos Recuperados até 29/05/2021','Quadrática','Intervalo de confiança de 95%','Location','northwest','NumColumns',1);

xlabel('Dia Transcorridos')
ylabel('Indivíduos Recuperados')
title('Regressão linear polinomial entre as variáveis')

%Cúbica
figure
%Plota os dados da semana base
plot(X1,Y1,'ob','linewidth',2)
hold on

%Plota a projeção cúbica
plot(X1,y_fit3,'r-','linewidth', 2)
plot(X1,y_fit3+2*delta3,'g--','linewidth', 2,X1,y_fit3-2*delta3,'g--','linewidth', 2)

grid on


legend('Indivíduos Recuperados até 29/05/2021','Cúbica','Intervalo de confiança de 95%','Location','northwest','NumColumns',1);

xlabel('Dia Transcorridos')
ylabel('Indivíduos Recuperados')
%title('Regressão linear polinomial entre as variáveis')

%Plot of residuals
%Producing a fit using a linear model requires minimizing the sum of the squares of the residuals.
%This minimization yields what is called a least-squares fit.
%You can gain insight into the “goodness” of a fit by visually examining a plot of the residuals.
%If the residual plot has a pattern (that is, residual data points do not appear to have a random scatter), the randomness indicates that the model does not properly fit the data.
figure
plot(X1,resid1,'--r','linewidth', 2)
hold on
plot(X1,resid2,'+b','linewidth', 2)
plot(X1,resid3,'.g','linewidth', 2)
grid on
xlabel('Dia Transcorridos')
ylabel('Resíduo')
title('Análise de distribuição dos resíduos da regressão linear')
legend('Linear','Quadrática','Cúbica','Location','northwest','NumColumns',1);