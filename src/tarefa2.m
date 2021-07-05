clc;

clear all;

format short;

% Meia vida do elemento em anos

tau = 5730

% Percentual restante do quantidade original no tempo medido

rest = 0.92

% Datação, tempo em anos, calculado pela constante de decaimento

t1 = -tau * log2(rest)

% Datação, tempo em anos, calculado pela meia-vida

t2 = -(tau/log(2))*log(rest)

%Conjunto para o intervalo de 100% até 70% de quantidade de C14

%remain=[1:-0.0001:.7];
remain=[1:-0.0001:0];


%Anos

t3 = -(tau/log(2))*log (remain);


%y1 = exp(t3/(-tau/log(2)));


%Cáculo do valor para o ano de 1988
y2 = exp(1988/(-tau/log(2)))

%Curva de decaimento
plot(t3,remain,'-b','linewidth',1)

hold on

%Decaimento encontrado em 1988

plot(1988,0.92,'or','linewidth',2)

%Valor calculado para 92% de decaimento

plot(t2,rest,'^g','linewidth',2)

%Valor calculado para o  decaimento no ano de 1988

plot(1988,y2,'sm','linewidth',2)
grid on

legend('Curva de Decaimento','Decaimento encontrado em 1988','Decaimento calculado de 92%','Decaimento calculado para 1988')


xlabel('Anos')
ylabel('Quantidade % da Substância')


