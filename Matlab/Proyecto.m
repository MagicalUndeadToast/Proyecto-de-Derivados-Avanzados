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

%% Sexta seccion
Step6()

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
disp("El error de las volatilidades implicitas con Monte-Carlos es de un: " +...
    ErrorSigmaMC*100 +"%")
disp(" ")

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
        ValueMMAHS(k,i)=HestonCallPrice(1,Strike(k,1),r(k,i),q(k,i),...
            Tiempo(k,i),vt,theta,w,sig,rho,psi);
        RDiscountNuevosHS(k,i)=exp(-r(k,i)*Tiempo(k,i));
    end
end

% Diferencia porcentual.
ErrorMMAHS=abs(ValueMMAHS./RDiscountNuevosHS-1);
ErrorMMAHS=ErrorPromedio(ErrorMMAHS,0);
disp("El error con Heston del MMA es de un: " + ErrorMMAHS*100+"%")

[PorcentajeMMAHS,PorcentajesMMAHS,LimiteInferiorMMAHS,LimiteSuperiorMMAHS,contadoresMMAHS]=...
    IntervaloDeConfianza(ValueMMAHS,RDiscountNuevosHS);

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

disp("El error de las volatilidades implicitas con Heston es de un: "...
    + ErrorSigmasHeston*100+"%")
disp(" ")

%% Decimosexta Seccion.
% Heston versus Monte-Carlo ATM 3 meses.
M=10000;
N=66;

% Calculamos primero los FairValue.

[MC8,Heston8] = HSMCFairValue(M,N,e,Spot,Strike,r,q,...
    Sigma,Tiempo,vt,theta,w,sig,rho,psi);
BSValue8=BlackScholes(1, Spot, Strike(:,8), q(:,2), r(:,2), Tiempo(:,2), Sigma(:,8));

% Ahora calculamos la Volatilidad Implicita.

SigmaMCBS=0.15;
Accuracy=0.002025;

[ValoresMC8, VolMC8,StepMC,ValoresHeston8,...
    VolHeston8,StepHeston] = HSMCVolImp(Spot,r,q,...
        Tiempo,Strike,MC8,Heston8,SigmaMCBS...
        ,Accuracy,e);

disp("El total de steps con Monte-Carlo es: "+sum(StepMC))
disp("El total de steps con Heston es: "+sum(StepHeston))
disp(" ")

% Calculamos el Error de las Volatilidades.

ErrorHSVSMCMC=ErrorPromedio(VolMC8,Sigma(:,8))...
    /ErrorPromedio(Sigma(:,8),0);
ErrorHSVSMCHS=ErrorPromedio(VolHeston8,Sigma(:,8))...
    /ErrorPromedio(Sigma(:,8),0);

% Error de los Fair Values.

ErrorBSMC=ErrorPromedio(MC8,BSValue8)...
    /ErrorPromedio(BSValue8,0);
ErrorBSHeston=ErrorPromedio(Heston8,BSValue8)...
    /ErrorPromedio(BSValue8,0);

disp("El error promedio de la volatilidad con Monte-Carlo es de un: "...
    + ErrorHSVSMCMC*100+"%")
disp("El error promedio de la volatilidad con Heston es de un: "...
    + ErrorHSVSMCHS*100+"%")
disp(" ")

% sum(isnan(VolHeston8))

disp("El error promedio del fair value entre BS y Monte-Carlo es de un: "...
    + ErrorBSMC*100+"%")
disp("El error promedio del fair value entre BS y Heston es de un: "...
    + ErrorBSHeston*100+"%")
disp(" ")

%% Decimoseptima Seccion.
% Justificacion de los parametros.
% Parametros

vt=0.2^2;
theta=0.015;
w=0.01;
sig=0.5;
rho=0.05;
psi=theta.*w;

X0Inicial=ParametrosIniciales(Sigma,Spot);

%% Decimooctaba Seccion.
% Calibramos para el primer dia.
% Parametros iniciales
x0 = [0.1, 0.01, 0.21, 0.4,0.5]; %Parametros iniciales NO TOCAAAAAR
% NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR 

% Funcion que devuelve los parametros ,sigmas y precios calculados
% con nuestro modelo. 
[parametrosPD,SigmaEmpiricoPD,tfinalPD,tpromedioPD,OptionValueEmpiricoPD] = ...
    DBDCalibration(Sigma,Spot,Strike,r,q,Tiempo,x0,'Primer Dia');

%% Decimonovena Seccion.
% Se calculan los diferentes errores para los sigmas y precios para Primer Dia.
SigmaErrorPD=ErrorPromedio(SigmaEmpiricoPD,Sigma(1,:));
PriceErrorPD=ErrorPromedio(OptionValueEmpiricoPD,OptionValue(1,:));
SigmaPercentErrorPD=ErrorPromedioPorcentual(SigmaEmpiricoPD,Sigma(1,:));
PriceErrorPercentPD=ErrorPromedioPorcentual(OptionValueEmpiricoPD,OptionValue(1,:));
RowSigmaErrorPD=ErrorFila(SigmaEmpiricoPD,Sigma(1,:));
RowPriceErrorPD=ErrorFila(OptionValueEmpiricoPD,OptionValue(1,:));

%% Vigesima Seccion.
% Se imprimen los errores de calibracion  del primer dia.
disp("El error promedio de la volatilidad para el primer dia es: " ...
    + SigmaErrorPD)
disp("El error promedio porcentual de la volatilidad para el primer dia es: " ...
    + SigmaPercentErrorPD + "%")
disp(" ")
disp("El error promedio del valor de la  opcion para el primer dia es: " ...
    + PriceErrorPD)
disp("El error promedio porcentual del valor de la opcion para el primer dia es: " ...
    + PriceErrorPercentPD + "%")
disp(" ")

%% Vigesimoprimera Seccion.
% Graficos de la Smile del primer dia en 2D.
Tenores=["1 Mes", "3 Meses", "6 Meses", "9 Meses", "12 Meses" ];
for i=1:5
    if i==1
        k=1;
    end
figure(i);
plotaux=[SigmaEmpiricoPD(1,k),SigmaEmpiricoPD(1,k+1),SigmaEmpiricoPD(1,k+2),...
    SigmaEmpiricoPD(1,k+3),SigmaEmpiricoPD(1,k+4)];
plotaux2=[Sigma(1,k),Sigma(1,k+1),Sigma(1,k+2),Sigma(1,k+3),Sigma(1,k+4)];
plotaux3=linspace(1,5,5);
plot(plotaux3,plotaux),title(Tenores(i));
hold on;
plot(plotaux3,plotaux2);
legend("Smile Empirica","Smile Teorica");
xlabel("Pilares");
ylabel("Volatilidad");
xticks([1,2,3,4,5]);
xticklabels({'10P','25P','50C','75C','90C'});
hold off;
k=i*5+1;

end

%% Vigesimosegunda Seccion.
% Calibramos para datos entre TInicial y TFinal.
% Parametros iniciales para empezar a calibrar.
x0 = [0.1, 0.01, 0.21, 0.4,0.5]; %Parametros iniciales NO TOCAAAAAR
% NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR
tinicial=1;
tfinal=3;
[parametrosFC,SigmaEmpiricoFC,tfinalFC,tpromedioFC,OptionValueEmpiricoFC] = ...
    DBDCalibration(Sigma,Spot,Strike,r,q,Tiempo,x0,'Fechas',tinicial,tfinal);

%% Vigesimotercera Seccion.
% Se calculan los diferentes errores para los sigmas y precios para Fechas.
SigmaErrorFC=ErrorPromedio(SigmaEmpiricoFC,Sigma(tinicial:tfinal,:));
PriceErrorFC=ErrorPromedio(OptionValueEmpiricoFC,OptionValue(tinicial:tfinal,:));
SigmaPercentErrorFC=ErrorPromedioPorcentual(SigmaEmpiricoFC,Sigma(tinicial:tfinal,:));
PriceErrorPercentFC=ErrorPromedioPorcentual(OptionValueEmpiricoFC,OptionValue(tinicial:tfinal,:));
RowSigmaErrorFC=ErrorFila(SigmaEmpiricoFC,Sigma(tinicial:tfinal,:));
RowPriceErrorFC=ErrorFila(OptionValueEmpiricoFC,OptionValue(tinicial:tfinal,:));

%% Vigesimocuarta Seccion.
% SMILE de la Data en 3D incompleta.
Tenores=["1 Mes", "3 Meses", "6 Meses", "9 Meses", "12 Meses" ];
for i=1:5
    if i==1
        k=1;
    end  
figure(i+5);
plotaux=[SigmaEmpiricoFC(:,k),SigmaEmpiricoFC(:,k+1),SigmaEmpiricoFC(:,k+2),...
    SigmaEmpiricoFC(:,k+3),SigmaEmpiricoFC(:,k+4)];
plotaux2=[Sigma(:,k),Sigma(:,k+1),Sigma(:,k+2),Sigma(:,k+3),Sigma(:,k+4)];
plotaux3=linspace(1,5,5);

[X,Y]=meshgrid(plotaux3,Date(tinicial:tfinal));
Z=plotaux2(tinicial:tfinal,:);
surf(X,Y,Z,'FaceColor','r');
xticks([1,2,3,4,5]);
xticklabels({'10P','25P','50C','75C','90C'}),ylabel("Fecha")
xlabel("Pilar"), zlabel("Volatilidad"),title(Tenores(i))
hold on
[X1,Y1]=meshgrid(plotaux3,Date);
Z1=plotaux;
surf(X,Y,Z1,'FaceColor','b');
legend("Smile Teorica","Smile Empirica")
hold off;
k=i*5+1;
end

%% Vigesimoquinta Seccion.
% Plot de la Evolucion de los Parametros.
% Parametros a graficar evolucion fechas.
NombreParametros=["vt", "theta", "w", "sig", "rho", "psi"];
for i=1:6
figure(15+i);
plotaux=parametrosFC(:,i);
plotaux2=Date(tinicial:tfinal);
plot(plotaux2,plotaux);
hold on;
title("Evolucion del Parametro "+NombreParametros(i));
xlabel("Fechas");   
ylabel(NombreParametros(i));
legend(NombreParametros(i));
hold off;
end

%% Vigesimosexta Seccion.
% Calibramos toda la Data.

% Parametros iniciales
x0 = [0.1, 0.01, 0.21, 0.4,0.5]; %Parametros iniciales NO TOCAAAAAR
% NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR

[parametrosCP,SigmaEmpiricoCP,tfinalCP,tpromedioCP,OptionValueEmpiricoCP] = ...
    DBDCalibration(Sigma,Spot,Strike,r,q,Tiempo,x0,'Completo');

%% Vigesimoseptima Seccion.
% Se calculan los diferentes errores para los sigmas y precios.
SigmaErrorCP=ErrorPromedio(SigmaEmpiricoCP,Sigma);
PriceErrorCP=ErrorPromedio(OptionValueEmpiricoCP,OptionValue);
SigmaPercentErrorCP=ErrorPromedioPorcentual(SigmaEmpiricoCP,Sigma);
PriceErrorPercentCP=ErrorPromedioPorcentual(OptionValueEmpiricoCP,OptionValue);
RowSigmaErrorCP=ErrorFila(SigmaEmpiricoCP,Sigma);
RowPriceErrorCP=ErrorFila(OptionValueEmpiricoCP,OptionValue);

%% Vigesimoctava Seccion.
% SMILE 3d Completa.
Tenores=["1 Mes", "3 Meses", "6 Meses", "9 Meses", "12 Meses" ];
for i=1:5
    if i==1
        k=1;
    end
figure(i+10);
plotaux=[SigmaEmpiricoCP(:,k),SigmaEmpiricoCP(:,k+1),SigmaEmpiricoCP(:,k+2),...
    SigmaEmpiricoCP(:,k+3),SigmaEmpiricoCP(:,k+4)];
plotaux2=[Sigma(:,k),Sigma(:,k+1),Sigma(:,k+2),Sigma(:,k+3),Sigma(:,k+4)];
plotaux3=linspace(1,5,5);

[X,Y]=meshgrid(plotaux3,Date(:));
Z=plotaux2(:,:);
surf(X,Y,Z,'FaceColor','r');
xticks([1,2,3,4,5]);
xticklabels({'10P','25P','50C','75C','90C'}),ylabel("Fecha")
xlabel("Pilar"), zlabel("Volatilidad"),title(Tenores(i))
hold on
[X1,Y1]=meshgrid(plotaux3,Date);
Z1=plotaux;
surf(X,Y,Z1,'FaceColor','b');
legend("Smile Teorica","Smile Empirica")
hold off;
k=i*5+1;
end

%% Vigesimonovena Seccion.
% Plot de la Evolucion de los Parametros.
% Parametros a graficar evolucion completa.
NombreParametros=["vt", "theta", "w", "sig", "rho", "psi"];
for i=1:6
figure(21+i);
plotaux=parametrosCP(:,i);
plotaux2=Date(:);
plot(plotaux2,plotaux);
hold on;
title("Evolucion del Parametro "+NombreParametros(i));
xlabel("Fechas");   
ylabel(NombreParametros(i));
legend(NombreParametros(i));
hold off;
end

%% Trigesima Seccion.
% A contiuacion se muestra los errores de la data.
% Iteracion 804 completada en 6184.1895 segundos.
x=ErroresData();

%Grafica de los errores
figure(28)
plot(Date,x,'linewidth',1)
xlabel("Fecha"),ylabel("Volatilidad"), title("Error promedio en el tiempo")
hold on
yyaxis right
plot(Date,Spot,'linewidth',1),ylabel("Precio Spot")
legend({'Error promedio de la volatilidad','Precio Spot'},"location",'northeast')

%% Espacio de Calculo.
% Espacio para hacer calculos en el programa sin tener que correr la
% simulacion de nuevo.
% Abrir una funcion open('').

% plot(normalize(Strike(:,1)),SigmasObtenidos(:,1),'o')
% xlabel('Strike'), ylabel('Volatilidad implicita'), title(
%%'Smile')
%%
