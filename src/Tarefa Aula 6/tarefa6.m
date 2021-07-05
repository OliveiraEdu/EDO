%Tarefa 6
clear all;clc;

%h(0)=0
[T1,H1]=ode45('PVI',[0 10],0);
plot(T1,H1,'linewidth',2)

hold on

%h(0)=2
[T2,H2]=ode45('PVI',[0 10],2);
plot(T2,H2,'linewidth',2)

xlabel('Tempo t em s');
ylabel('Solução h(t) em m');
title('ODE45 - Resultado da Simulação');
grid on;
legend('h(0)=0','h(0)=2')

fprintf('Valores de t e h para h(0)=0 \n\n')
[T1 H1]

fprintf('Valores de t e h para h(0)=2 \n\n')

[T2 H2]

