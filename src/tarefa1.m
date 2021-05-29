%https://www.mathworks.com/help/matlab/data_analysis/linear-regression.html
clear all;
clc;
% Lê o arquivoa = csvread ('/home/eduardo/Documents/datasets/covid1.csv')% Lê a segunda coluna (óbitos) e cria um vetor y
%y = dlmread ('/home/eduardo/Documents/datasets/covid1.csv', ',', [0,2,inf,2]);
%Lê a segunda coluna (recuperados) e cria um vetor y
y = dlmread ('/home/eduardo/Documents/datasets/covid1.csv', ',', [0,3,inf,3]);
%Cria um vetor v de comprimento igual a y
v = [];
for  n = 1:length(y)
    v = [v ; n];
end
scatter(v,y)
%Fixed point format with 16 significant figures.format long
%b1 is the slope or regression coefficient.
b1 = v\y
yCalc1 = b1*v;
hold on
plot(v,yCalc1)
xlabel('Dia Transcorridos')
%ylabel('Óbitos')ylabel('Recuperados')title('Relação de regressão linear entre as variáveis')
grid on
%Improve the fit by including a y-intercept β0 in your model as y=β0+β1x. Calculate β0 by padding x with a column of ones and using the \ operator.
X = [ones(length(v),1) v];
b = X\y
%Visualize the relation by plotting it on the same figure.
yCalc2 = X*b;
plot(v,yCalc2,'--')
%Find the better fit of the two fits by comparing values of R2. As the R2 values show, the second fit that includes a y-intercept is better.
Rsq1 = 1 - sum((y - yCalc1).^2)/sum((y - mean(y)).^2)
Rsq2 = 1 - sum((y - yCalc2).^2)/sum((y - mean(y)).^2)
%Use polyfit to compute a linear regression that predicts y from x%p(1) is the slope and p(2) is the intercept of the linear predictor.
p = polyfit(v,y,1)
%Call polyval to use p to predict y, calling the result yfit:
yfit = polyval(p,v);
%Compute the residual values as a vector of signed numbers:yresid = y - yfit;
%Square the residuals and total them to obtain the residual sum of squares:
SSresid = sum(yresid.^2);
%Compute the total sum of squares of y by multiplying the variance of y by the number of observations minus 1:
SStotal = (length(y)-1) * var(y);
%Compute R2 using the formula given in the introduction of this topic:
rsq = 1 - SSresid/SStotal
%This demonstrates that the linear equation p(1) * v -p2 predicts rsq of the variance in the variable y.
%project values for y
proj_y = p(1)*v+p(2)
%yfit =  p(1) * x + p(2);
plot(v, proj_y, '-.')
%Computing Adjusted R2 for Polynomial Regressions
%Call polyfit to generate a cubic fit to predict y from x:
p = polyfit(v,y,3)
%p(4) is the intercept of the cubic predictor.
%Call polyval to use the coefficients in p to predict y, naming the result yfit:
yfit = polyval(p,v);
%polyval evaluates the explicit equation you could manually enter as:
%yfit =  p(1) * x.^3 + p(2) * x.^2 + p(3) * x + p(4);
%Compute the residual values as a vector of signed numbers:
yresid = y - yfit;
%Square the residuals and total them to obtain the residual sum of squares:
SSresid = sum(yresid.^2);
%Compute the total sum of squares of y by multiplying the variance of y by the number of observations minus 1:
SStotal = (length(y)-1) * var(y);
%Compute simple R2 for the cubic fit using the formula given in the introduction of this topic:
rsq = 1 - SSresid/SStotal
%Finally, compute adjusted R2 to account for degrees of freedom:
rsq_adj = 1 - SSresid/SStotal * (length(y)-1)/(length(y)-length(p))
%The adjusted R2, is smaller than simple R2. It provides a more reliable estimate of the power of your polynomial model to predict
%yfit =  p(1) * v.^3 + p(2) * v.^2 + p(3) * v + p(4);
plot(v, yfit)legend('Dados','Regressão 1','Regressão 2','Linear','Cúbico','Location','northwest','NumColumns',1);
