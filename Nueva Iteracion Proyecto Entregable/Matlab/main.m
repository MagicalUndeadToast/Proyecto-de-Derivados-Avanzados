clc
clear

%Leemos los datos y los manipulamos un poco.
Spot = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Spot');
RDiscount = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Domestic Discount Factor');
QDiscount = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Foreign Discount Factor');
Forward = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Forward');
sigma = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Vols');
sigma=sigma/100; %Pasamos a puntos porcentuales los sigmas.
sigmaRR = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Vols RR & BFY');
sigmaRR=sigmaRR/100; %Guardamos sigmas RR y BTF
Strike = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Strikes');
Strike(1,:)=[]; %Eliminamos primera fila.
T=xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Working Days');
OptionValue=xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Option Value');
OptionValue(1,:)=[]; %Eliminamos primera fila.

%Pasamos el Tiempo a un numero entro 0 y 1.
for i=1:size(T,1)
    for e=1:size(T,2)
        Tiempo(i,e)=T(i,e)/T(i,5);
    end
end

rf=log(RDiscount)./(-T); %Descomponemos factor descuento en Rf
q=log(QDiscount)./(-T); %Descomponemos factor descuento en Q

%%
%Comprobamos con una MMA que MonteCarlo funcione
M=10; %1000 Simulaciones
N=10000;

for i=1:5
    for e=1:size(rf,1)  %CAMBIAR ESTO A SIZE(rf,2) PARA CODIGO COMPLETO
        ValueMMA(e,i)=getMonteCarlos(Spot(e,1),1,0, rf(e,i), q(e,i),0, T(e,i),M,N,'MMA');
    end
end

ErrorMC=abs(ValueMMA./RDiscount-1); %Diferencia porcentual
ErrorMC=mean(mean(abs(ErrorMC))); %AJUSTAR RDISCOUNT PARA EL ERROR
disp("El error con Monte-Carlos del MMA es de un "+ ErrorMC*100+"%")

%% Comprobamos para un forward
M=100;

N=1000;
%Calculos para un año
for i=1:2
    for e=1:size(rf,1)  
        ValueForward(e,i)=getMonteCarlos(1,Spot(e,1),Strike(e,i), rf(e,1), q(e,1),0, T(e,1),M,N,"other");
        ValorTeoricoFW(e,i)=Spot(e,1)*exp(-q(e,1)*T(e,1))-Strike(e,i)*exp(-rf(e,1)*T(e,1));
        
    end
end


%Error
ErrorFW=mean(abs(ValueForward-ValorTeoricoFW));
ErrorFW=ErrorFW(1)/mean(ValorTeoricoFW(:,1));
disp("El error con Monte-Carlos del Forward es de un: " + ErrorFW*100+"%")

% Intervalo de Confianza
LimInf=mean2(ValorTeoricoFW)+norminv(0.01)*std2(ValorTeoricoFW)/sqrt(size(ValorTeoricoFW,1)*size(ValorTeoricoFW,2));
LimSup=mean2(ValorTeoricoFW)+norminv(0.99)*std2(ValorTeoricoFW)/sqrt(size(ValorTeoricoFW,1)*size(ValorTeoricoFW,2));
contador=0;

for i=1:size(ValueForward,1)
    for e=1:size(ValueForward,2)
        if(LimInf<=ValueForward(i,e)<=LimSup)
            contador=contador+1;
        end
    end
end

%% Pregunta 5. Agregamos volatilidades
N=52;
M=10000;

for i=1:5
    for e=1:804
       ValueBS(e,i)=getMonteCarlos(1,Spot(e,1),Strike(e,i), rf(e,1), q(e,1),0.05, T(e,1),M,N,"other");
       BSValue(e,i)= BlackScholes(1, Spot(e,1), Strike(e,i), q(e,1), rf(e,1), T(e,1), 0.05);
    end
end
%%
for e=1:size(rf,1)
    ValueForward(e,1)=getMonteCarlos(1,Spot(e,1),Strike(e,1), rf(e,1), q(e,1),0, T(e,1),M,N,"other");
    ValorTeoricoFW(e,1)=Spot(e,1)*exp(-q(e,1)*T(e,1))-Strike(e,1)*exp(-rf(e,1)*T(e,1));
end
for e=1:size(rf,1)
    ValueForward(e,2)=getMonteCarlos(1,Spot(e,1),Strike(e,1+5), rf(e,1), q(e,1),0, T(e,1),M,N,"other");
    ValorTeoricoFW(e,2)=Spot(e,1)*exp(-q(e,1)*T(e,1))-Strike(e,1+5)*exp(-rf(e,1)*T(e,1));
end
for e=1:size(rf,1)
    ValueForward(e,3)=getMonteCarlos(1,Spot(e,1),Strike(e,1+10), rf(e,1), q(e,1),0, T(e,1),M,N,"other");
    ValorTeoricoFW(e,3)=Spot(e,1)*exp(-q(e,1)*T(e,1))-Strike(e,1+10)*exp(-rf(e,1)*T(e,1));
end
for e=1:size(rf,1)
    ValueForward(e,4)=getMonteCarlos(1,Spot(e,1),Strike(e,1+15), rf(e,1), q(e,1),0, T(e,1),M,N,"other");
    ValorTeoricoFW(e,4)=Spot(e,1)*exp(-q(e,1)*T(e,1))-Strike(e,1+15)*exp(-rf(e,1)*T(e,1));
end
for e=1:size(rf,1)
    ValueForward(e,5)=getMonteCarlos(1,Spot(e,1),Strike(e,1+20), rf(e,1), q(e,1),0, T(e,1),M,N,"other");
    ValorTeoricoFW(e,5)=Spot(e,1)*exp(-q(e,1)*T(e,1))-Strike(e,1+20)*exp(-rf(e,1)*T(e,1));
end
%%


    