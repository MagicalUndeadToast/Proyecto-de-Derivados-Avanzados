%% Clear Section.
% Partimos con el codigo.
clc
clear
clear ALL
rng(2);
%Secciones del codigo.

%% Primera Seccion.
% Carga de los datos.
[Spot,RDiscount,QDiscount,Forward,Sigma,SigmaRR,Strike,T,OptionValue ...
    ,Date]=LoadData();
% Hacemos los procedimientos respectivos.
% Pasamos a puntos porcentuales los sigmas.
Sigma=Sigma/100;
% Guardamos sigmas RR y BTF.
SigmaRR=SigmaRR/100;
% Eliminamos primera fila
Strike(1,:)=[];
% Eliminamos primera fila.
OptionValue(1,:)=[];

%% Segunda Seccion.
% Transformacion de algunos datos y otros procesos
% respectivos.
% Pasamos el tiempo a un numero entre 0 y 1.
for i=1:size(T,1)
    for k=1:size(T,2)
        Tiempo(i,k)=T(i,k)/T(i,5);
    end
end

%% Tercera Seccion.
% Hacemos el calculo del Forward.
% Pasamos el factor de descuento a la tasa domestica.
r=log(RDiscount)./(-T);
% Pasamos el factor de descuento a la tasa extranjera.
q=log(QDiscount)./(-T);
% Calculamos el Forward y su error.
ForwardEmpirico=ForwardEmpirico(Spot,r,q,T);
% Calculamos el error entre el Forward obtenido empiricamente y aquel
% otorgado por el Dataset.
ForwardError=abs(ForwardEmpirico-Forward);

%% Cuarta Seccion.
% Obtenemos los pilares.
Pilares=[0.9 0.75 0.5 0.75 0.9];
% Epsilon Call Flag.
e=1;
% Calculamos los Strike Empiricos.
StrikesEmpiricos=StrikesEmpiricos(Spot,r,q,Pilares,Tiempo,Sigma,e);
% Calculamos el error a los Strike Empiricos.
ErrorStrike=abs(StrikesEmpiricos-Strike);

%% Quinta Seccion.
% Calculamos los valores de las opciones utilizando la formula de ValueBS,
% que nos entrega multiples valores útiles.
Value1M=BlackScholes(1.*ones(804,5), Spot.*ones(804,5)...
    ,Strike(:,1:5), q(:,1).*ones(804,5), r(:,1).*ones(804,5)...
    , Tiempo(:,1).*ones(804,5),Sigma(:,1:5));
Value3M=BlackScholes(1.*ones(804,5), Spot.*ones(804,5)...
    ,Strike(:,6:10), q(:,2).*ones(804,5), r(:,2).*ones(804,5)...
    , Tiempo(:,2).*ones(804,5),Sigma(:,6:10));
Value6M=BlackScholes(1.*ones(804,5), Spot.*ones(804,5)...
    ,Strike(:,11:15), q(:,3).*ones(804,5), r(:,3).*ones(804,5)...
    , Tiempo(:,3).*ones(804,5),Sigma(:,11:15));
Value9M=BlackScholes(1.*ones(804,5), Spot.*ones(804,5)...
    ,Strike(:,16:20), q(:,4).*ones(804,5), r(:,4).*ones(804,5)...
    , Tiempo(:,4).*ones(804,5),Sigma(:,16:20));
Value12M=BlackScholes(1.*ones(804,5), Spot.*ones(804,5)...
    ,Strike(:,21:25), q(:,5).*ones(804,5), r(:,5).*ones(804,5)...
    , Tiempo(:,5).*ones(804,5),Sigma(:,21:25));

%Juntamos y calculamos error.
ValoresEmpiricos=[Value1M Value3M Value6M Value9M Value12M];
ErrorValores=abs(ValoresEmpiricos-OptionValue);

%% Sexta Seccion.
% Comprobamos las volatilidades RR y BFY.

for w=0:4
    for k=1:size(SigmaRR,1)
       SigmaNuevo(k,4+w*5)=SigmaRR(k,1+w*5)+SigmaRR(k,3+w*5)...
           +SigmaRR(k,2+w*5)./2;%#ok<*SAGROW> %Sigma put
       SigmaNuevo(k,2+w*5)=SigmaRR(k,1+w*5)+SigmaRR(k,3+w*5)...
           -SigmaRR(k,2+w*5)./2;%Sigma call
       SigmaNuevo(k,3+w*5)=SigmaRR(k,1+w*5);
       SigmaNuevo(k,5+w*5)=SigmaRR(k,1+w*5)+SigmaRR(k,5+w*5)...
           +SigmaRR(k,4+w*5)./2;%Sigma put
       SigmaNuevo(k,1+w*5)=SigmaRR(k,1+w*5)+SigmaRR(k,5+w*5)...
           -SigmaRR(k,4+w*5)./2; %Sigma call
    end
end

% Error de los Sigmas Respectivos.
ErrorSigma=abs(SigmaNuevo-Sigma);
% Butterfly estan en ForwardEmpirico comentado como Deadcode.

%% Septima Seccion.
% Comprobamos que Monte-Carlo funcione con el MMA.
M=10;
%1000 Simulaciones
N=10000;
for i=1:5
    for k=1:size(r,1)  %CAMBIAR ESTO A SIZE(r,2) PARA CODIGO COMPLETO
        ValueMMA(k,i)=getMonteCarlos(1,Spot(k,1),0, r(k,i), q(k,i),...
            0, Tiempo(k,i),M,N,'MMA');
        RDiscountNuevos(k,i)=exp(-r(k,i)*Tiempo(k,i));
    end
end

% Diferencia porcentual.
ErrorMC=abs(ValueMMA./RDiscountNuevos-1);
ErrorMC=ErrorPromedio(ErrorMC,0); %AJUSTAR RDISCOUNT PARA EL ERROR
disp("El error con Monte-Carlos del MMA es de un "+ ErrorMC*100+"%")

[PorcentajeMMA,PorcentajesMMA,LimiteInferiorMMA,LimiteSuperiorMMA,contadoresMMA]=...
    IntervaloDeConfianza(RDiscountNuevos,ValueMMA);

%% Octava Seccion.
% Calculos para el Forward
M=100;

N=1000;

% Lo calculamos para distintos Tenores.

[ValueForward,ValorTeoricoFW]=ForwardMontecarlo(e,Spot,Strike,r,q,Tiempo,M,N);

% Calculamos el Error.
ErrorFW=ErrorPromedio(ValueForward,ValorTeoricoFW);
ErrorFW=ErrorFW/ErrorPromedio(ValorTeoricoFW,0);
disp("El error con Monte-Carlos del Forward es de un: " + ErrorFW*100+"%")

[PorcentajeFWMC,PorcentajesFWMC,LimiteInferiorFWMC,LimiteSuperiorFWMC,contadoresFWMC]=...
    IntervaloDeConfianza(ValorTeoricoFW,ValueForward);

%% Novena Seccion.
% Agregamos las volatilidades.
N=52;
M=10000;                        

% Lo calculamos en cada volatilidad para todos los tenores.
[ValueMCBS,ValorTeoricoMCBS]=BSMontecarloTenor(e,Spot,Strike,r,q,...
    Tiempo,M,N);

% Calculamos el Error.
ErrorMCBS=ErrorPromedio(ValueMCBS,ValorTeoricoMCBS);
ErrorMCBS=ErrorMCBS/ErrorPromedio(ValorTeoricoMCBS,0);
disp("El error con Monte-Carlos de Black-Scholes es de un: " ...
    + ErrorMCBS*100+"%")

%% Decima Seccion.
% Calculo de la volatilidad implicita.
[ValoresObtenidos,SigmasObtenidos]=VolImpMC(Spot,r,q,...
    Tiempo,Strike,ValorTeoricoMCBS,e);
SigmasTeoricos= [0.05*ones(804,5) 0.1*ones(804,5) 0.2*ones(804,5) 0.5*ones(804,5)];

% Calculamos el Error de las Volatilidades Implicitas.

ErrorSigmaMC=ErrorPromedio(SigmasObtenidos,SigmasTeoricos);
ErrorSigmaMC=ErrorSigmaMC/ErrorPromedio(SigmasTeoricos,0);
disp("El error de las volatilidades implicita con Monte-Carlo es de un: " +...
    ErrorSigmaMC*100 +"%")

%% Decimoprimera Seccion.
% Parametros utilizados globalmente para Heston (Actualmente).
vt=0.01;
theta=0.015;
w=0.01;
sig=0.25;
rho=0.05;
psi=theta.*w;

%% Decimosegunda Seccion.
% Calculo para el MMA con Heston.
for i=1:5
    for k=1:size(r,1)  %CAMBIAR ESTO A SIZE(r,2) PARA CODIGO COMPLETO
        ValueMMA(k,i)=HestonCallPrice(1,Strike(k,1),r(k,i),q(k,i),...
            Tiempo(k,i),vt,theta,w,sig,rho,psi);
        RDiscountNuevos(k,i)=exp(-r(k,i)*Tiempo(k,i));
    end
end

% Diferencia porcentual.
ErrorMMAHS=abs(ValueMMA./RDiscountNuevos-1);
ErrorMMAHS=ErrorPromedio(ErrorMMAHS,0);
disp("El error con Heston del MMA es de un: " + ErrorMMAHS*100+"%")

%% Decimotercera Seccion.
% Calculos para el Forward con Heston.

% Lo calculamos para distintos Tenores.

[ValueForwardHS,ValorTeoricoFWHS] = ForwardHeston(e,Spot,Strike,r,q,...
    Tiempo,vt,theta,w,sig,rho,psi);

% Calculamos el Error.
ErrorFWHS=ErrorPromedio(ValueForwardHS,ValorTeoricoFWHS);
ErrorFWHS=ErrorFWHS/ErrorPromedio(0,ValorTeoricoFWHS);
disp("El error con Heston del Forward es de un: " + ErrorFWHS*100+"%")

[PorcentajeFWHS,PorcentajesFWHS,LimiteInferiorFWHS,LimiteSuperiorFWHS,contadoresFWHS]=...
    IntervaloDeConfianza(ValorTeoricoFWHS,ValueForwardHS);

%% Decimocuarta Seccion.
% Agregamos las Volatilidades con Heston.

% Lo calculamos en cada volatilidad para todos los tenores.

[ValueHSBS,ValorTeoricoHSBS]=BSHestonTenor(e,Spot,Strike,r,q,...
    Tiempo,vt,theta,w,sig,rho,psi);

% Calculamos el Error.

ErrorHSBS=ErrorPromedio(ValueHSBS,ValorTeoricoHSBS);
ErrorHSBS=ErrorHSBS/ErrorPromedio(0,ValorTeoricoHSBS);
disp("El error con Heston de Black-Scholes es de un: " + ErrorHSBS*100+"%")

%% Decimoquinta Seccion.
% Calculo para la volatilidad implicita con Heston.
[ValoresObtenidosHeston,SigmasObtenidosHeston]=VolImpHeston(Spot,r,q,...
    Tiempo,Strike,ValueHSBS,e);
SigmasTeoricos= [0.05*ones(804,5) 0.1*ones(804,5) 0.2*ones(804,5) 0.5*ones(804,5)];

% Calculamos el Error de las Volatilidades Implicitas.

ErrorSigmasHeston=ErrorPromedio(SigmasTeoricos,SigmasObtenidosHeston);
ErrorSigmasHeston=ErrorSigmasHeston/ErrorPromedio(SigmasTeoricos,0);

disp("El error promedio entre los volatildiad teoricas e implicitas es de un: "...
    + ErrorSigmasHeston*100+"%")


%% Decimosexta Seccion.
% Heston versus Monte-Carlo ATM 3 meses.
M=10000;
N=66;

% Calculamos primero los FairValue.

[MC8,Heston8] = HSMCFairValue(M,N,e,Spot,Strike,r,q,...
    Sigma,Tiempo,vt,theta,w,sig,rho,psi);

% Ahora calculamos la Volatilidad Implicita.

SigmaMCBS=0.15;
Accuracy=0.001;

[ValoresMC8, VolMC8,StepMC,ValoresHeston8,...
    VolHeston8,StepHeston] = HSMCVolImp(Spot,r,q,...
        Tiempo,Strike,MC8,Heston8,SigmaMCBS...
        ,Accuracy,e);

disp("El total de steps con Monte-Carlo es: "+sum(StepMC))
disp("El total de steps con Heston es: "+sum(StepHeston))

% Calculamos el Error.

ErrorHSVSMCMC=ErrorPromedio(VolMC8,Sigma(:,8))...
    /ErrorPromedio(Sigma(:,8),0);
ErrorHSVSMCHS=ErrorPromedio(VolHeston8,Sigma(:,8))...
    /ErrorPromedio(Sigma(:,8),0);

disp("El error promedio con Monte-Carlo es de un: "+ ErrorHSVSMCMC*100+"%")
disp("El error promedio con Heston es de un: "+ ErrorHSVSMCHS*100+"%")

%% Espacio de Calculo.
% Espacio para hacer calculos en el programa sin tener que correr la
% simulacion de nuevo.
% Abrir una funcion open('').

% plot(normalize(Strike(:,1)),SigmasObtenidos(:,1),'o')
% xlabel('Strike'), ylabel('Volatilidad implicita'), title('Smile')
%%

