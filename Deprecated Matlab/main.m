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
%% Analisis datos
% Forward
rf=log(RDiscount)./(-T); %Descomponemos factor descuento en Rf
q=log(QDiscount)./(-T); %Descomponemos factor descuento en Q
ForwardEmpirico=Spot.*exp(-q.*T)./exp(-rf.*T); %Corroboramos forward
ForwardError= abs(ForwardEmpirico-Forward); %Error Forward


%% Strike
Pilares=[0.9 0.75 0.5 0.75 0.9]; %Pilares
ep=1; %Epsilon Call

%Llenamos la matriz de strike por tiempo, recorriendo los  5 pilares.
%Calculamos alpha, luego el Delta y finalmente el strike.

%Mes uno
aux=1; 
for i=1:size(rf,1)
    for e=1:size(rf,2)
        alpha(i,e)=exp(-q(i,aux)*Tiempo(i,aux)); 
        Delta=ep*norminv(ep*Pilares(e)/alpha(i,e));
        Strike1Mes(i,e)=Spot(i,1).*exp((rf(i,aux)-q(i,aux)).*Tiempo(i,aux)).*exp((sigma(i,e).^2*Tiempo(i,aux)./2)-Delta.*sigma(i,e).*sqrt(Tiempo(i,aux))); 
    end
end

%Mes 3
aux=2; 
for i=1:size(rf,1)
    for e=1:size(rf,2)
        alpha(i,e)=exp(-q(i,aux)*Tiempo(i,aux));
        Delta=ep*norminv(ep*Pilares(e)/alpha(i,e));
        Strike3Meses(i,e)=Spot(i,1).*exp((rf(i,aux)-q(i,aux)).*Tiempo(i,aux)).*exp((sigma(i,e+5).^2*Tiempo(i,aux)./2)-Delta.*sigma(i,e+5).*sqrt(Tiempo(i,aux))); 
    end
end

%Mes 6
aux=3; 
for i=1:size(rf,1)
    for e=1:size(rf,2)
        alpha(i,e)=exp(-q(i,aux)*Tiempo(i,aux));
        Delta=ep*norminv(ep*Pilares(e)/alpha(i,e));
        Strike6Meses(i,e)=Spot(i,1).*exp((rf(i,aux)-q(i,aux)).*Tiempo(i,aux)).*exp((sigma(i,e+10).^2*Tiempo(i,aux)./2)-Delta.*sigma(i,e+10).*sqrt(Tiempo(i,aux))); 
    end
end

%Mes 9
aux=4; 
for i=1:size(rf,1)
    for e=1:size(rf,2)
        alpha(i,e)=exp(-q(i,aux)*Tiempo(i,aux));
        Delta=ep*norminv(ep*Pilares(e)/alpha(i,e));
        Strike9Meses(i,e)=Spot(i,1).*exp((rf(i,aux)-q(i,aux)).*Tiempo(i,aux)).*exp((sigma(i,e+15).^2*Tiempo(i,aux)./2)-Delta.*sigma(i,e+15).*sqrt(Tiempo(i,aux))); 
    end
end

%Mes 12+
aux=5; 
for i=1:size(rf,1)
    for e=1:size(rf,2)
        alpha(i,e)=exp(-q(i,aux)*Tiempo(i,aux));
        Delta=ep*norminv(ep*Pilares(e)/alpha(i,e));
        Strike12Meses(i,e)=Spot(i,1).*exp((rf(i,aux)-q(i,aux)).*Tiempo(i,aux)).*exp((sigma(i,e+20).^2*Tiempo(i,aux)./2)-Delta.*sigma(i,e+20).*sqrt(Tiempo(i,aux))); 
    end
end

%Juntamos los strikes y vemos el error.
StrikeEmpiricos = [Strike1Mes Strike3Meses Strike6Meses Strike9Meses Strike12Meses ];
ErrorStrike=abs(StrikeEmpiricos-Strike);
%ErrorStrike=mean(ErrorStrike)';

%% Valor opcion

%Calculamos los valores de la opcion mediante la formula de Black Scholes.
%Se calculan para los diferentes tiempos.

Value1M=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,1:5), q(:,1).*ones(804,5), rf(:,1).*ones(804,5), Tiempo(:,1).*ones(804,5),sigma(:,1:5));
Value3M=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,6:10), q(:,2).*ones(804,5), rf(:,2).*ones(804,5), Tiempo(:,2).*ones(804,5),sigma(:,6:10));
Value6M=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,11:15), q(:,3).*ones(804,5), rf(:,3).*ones(804,5), Tiempo(:,3).*ones(804,5),sigma(:,11:15));
Value9M=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,16:20), q(:,4).*ones(804,5), rf(:,4).*ones(804,5), Tiempo(:,4).*ones(804,5),sigma(:,16:20));
Value12M=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,21:25), q(:,5).*ones(804,5), rf(:,5).*ones(804,5), Tiempo(:,5).*ones(804,5),sigma(:,21:25));

%Juntamos y calculamos error.
ValoresEmpiricos=[Value1M Value3M Value6M Value9M Value12M];
ErrorValores=abs(ValoresEmpiricos-OptionValue);
%ErrorValores=mean(ErrorValores)';

%%
%Corroboramos que las volatilidades sean consistentes para los diferentes
%pillars.


for w=0:4
    for e=1:size(sigmaRR,1)
       SigmaNuevo(e,4+w*5)=sigmaRR(e,1+w*5)+sigmaRR(e,3+w*5)+sigmaRR(e,2+w*5)./2;%Sigma put
       SigmaNuevo(e,2+w*5)=sigmaRR(e,1+w*5)+sigmaRR(e,3+w*5)-sigmaRR(e,2+w*5)./2;%Sigma call
       SigmaNuevo(e,3+w*5)=sigmaRR(e,1+w*5);
       SigmaNuevo(e,5+w*5)=sigmaRR(e,1+w*5)+sigmaRR(e,5+w*5)+sigmaRR(e,4+w*5)./2;%Sigma put
       SigmaNuevo(e,1+w*5)=sigmaRR(e,1+w*5)+sigmaRR(e,5+w*5)-sigmaRR(e,4+w*5)./2; %Sigma call
    end
end

%Error sigmas.
ErrorSigma=abs(SigmaNuevo-sigma);
%%
% Butterfly 1
A=0.1;
LongCall11=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,1:5)-A, q(:,1).*ones(804,5), rf(:,1).*ones(804,5), Tiempo(:,1).*ones(804,5),sigma(:,1:5));
ShortCal1=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,1:5), q(:,1).*ones(804,5), rf(:,1).*ones(804,5), Tiempo(:,1).*ones(804,5),sigma(:,1:5));
LongCall21=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,1:5)+A, q(:,1).*ones(804,5), rf(:,1).*ones(804,5), Tiempo(:,1).*ones(804,5),sigma(:,1:5));
Butterfly1=LongCall11-2.*ShortCall1+LongCall21;
%%
% Butterfly 3
A=0.1;
LongCall13=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,6:10)-A, q(:,2).*ones(804,5), rf(:,2).*ones(804,5), Tiempo(:,2).*ones(804,5),sigma(:,6:10));
ShortCall3=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,6:10), q(:,2).*ones(804,5), rf(:,2).*ones(804,5), Tiempo(:,2).*ones(804,5),sigma(:,6:10));
LongCall23=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,6:10)+A, q(:,2).*ones(804,5), rf(:,2).*ones(804,5), Tiempo(:,2).*ones(804,5),sigma(:,6:10));
Butterfly3=LongCall13-2.*ShortCall3+LongCall23;
%%
% Butterfly 6
A=0.1;
LongCall16=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,11:15)-A, q(:,3).*ones(804,5), rf(:,3).*ones(804,5), Tiempo(:,3).*ones(804,5),sigma(:,11:15));
ShortCall6=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,11:15), q(:,3).*ones(804,5), rf(:,3).*ones(804,5), Tiempo(:,3).*ones(804,5),sigma(:,11:15));
LongCall26=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,11:15)+A, q(:,3).*ones(804,5), rf(:,3).*ones(804,5), Tiempo(:,3).*ones(804,5),sigma(:,11:15));
Butterfly6=LongCall16-2.*ShortCall6+LongCall26;
%%
% Butterfly 9
A=0.1;
LongCall19=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,16:20)-A, q(:,4).*ones(804,5), rf(:,4).*ones(804,5), Tiempo(:,4).*ones(804,5),sigma(:,16:20));
ShortCall9=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,16:20), q(:,4).*ones(804,5), rf(:,4).*ones(804,5), Tiempo(:,4).*ones(804,5),sigma(:,16:20));
LongCall29=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,16:20)+A, q(:,4).*ones(804,5), rf(:,4).*ones(804,5), Tiempo(:,4).*ones(804,5),sigma(:,16:20));
Butterfly9=LongCall19-2.*ShortCall9+LongCall29;
%%
% Butterfly 12
A=0.07;
LongCall112=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,21:25)-A, q(:,5).*ones(804,5), rf(:,5).*ones(804,5), Tiempo(:,5).*ones(804,5),sigma(:,21:25));
ShortCall12=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,21:25), q(:,5).*ones(804,5), rf(:,5).*ones(804,5), Tiempo(:,5).*ones(804,5),sigma(:,21:25));
LongCall212=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,21:25)+A, q(:,5).*ones(804,5), rf(:,5).*ones(804,5), Tiempo(:,5).*ones(804,5),sigma(:,21:25));
Butterfly12=LongCall112-2.*ShortCall12+LongCall212;
%%