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

%% New Code Section.
% Nueva seccion de codigo.
vt=0.01;
theta=0.015;
w=0.01;
sig=0.25;
rho=0.05;
psi=theta.*w;


%%
%HestonCallPrice(Spot(1,1),Strike(1,1),r(1,1),q(1,1),Tiempo(1,1),vt,theta,w,sig,rho,psi)
for k=1:804
    Prueba(k,1)=...
        HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi); %#ok<*SAGROW>
    PruebaBS(k,1)=ValueBS(Spot(k,1),Strike(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),0.05,1);
end

ErrorPromedio(Prueba,PruebaBS)

%% MMA Section Code.
% Actualizar esta seccion cuando se nos ocurra como hacer la MMA.
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

%% Calculos para el Forward.
% Aca hacer los calculos para el Forward con Heston.

% Lo calculamos para distintos Tenores.

[ValueForwardHS,ValorTeoricoFWHS] = ForwardHeston(1,Spot,Strike,r,q,...
    Tiempo,vt,theta,w,sig,rho,psi);

% Calculamos el Error.
ErrorFWHS=ErrorPromedio(ValueForwardHS,ValorTeoricoFWHS);
ErrorFWHS=ErrorFWHS/ErrorPromedio(0,ValorTeoricoFWHS);
disp("El error con Heston del Forward es de un: " + ErrorFWHS*100+"%")

[PorcentajeFWHS,PorcentajesFWHS,LimiteInferiorFWHS,LimiteSuperiorFWHS,contadoresFWHS]=...
    IntervaloDeConfianza(ValorTeoricoFWHS,ValueForwardHS);

%% Agregamos las Volatilidades.
% Aca ya no se que poner si te soy sincero.

% Lo calculamos en cada volatilidad para todos los tenores.

[ValueHSBS,ValorTeoricoHSBS]=BSHestonTenor(1,Spot,Strike,r,q,...
    Tiempo,vt,theta,w,sig,rho,psi);

% Calculamos el Error.

ErrorHSBS=ErrorPromedio(ValueHSBS,ValorTeoricoHSBS);
ErrorHSBS=ErrorHSBS/ErrorPromedio(0,ValorTeoricoHSBS);
disp("El error con Heston de Black-Scholes es de un: " + ErrorHSBS*100+"%")

%% Calculo con Heston de Volatilidad Implicita.
% Aca deberiamos usar Newton Raphson.

[ValoresObtenidosHeston,SigmasObtenidosHeston]=VolImpHeston(Spot,r,q,Tiempo,Strike,ValueHSBS,1);


%% Espacio de Calculo.
% Espacio para hacer calculos en el programa sin tener que correr la
% simulacion de nuevo.
% Abrir una funcion open('').
plot(normalize(Strike(:,1)),SigmasObtenidosHeston(:,1),'o')
xlabel('Strike'), ylabel('Volatilidad implicita'), title('Smile')


%% Step 8
%Calculamos los valores de 3M ATM con MC y Heston.

M=10000;
N=66;

%Parametros Heston
vt=0.01;
theta=0.015;
w=0.01;
sig=0.25;
rho=0.05;
psi=theta.*w;

tic
for e=1:size(Spot,1)
    MC8(e,1)=getMonteCarlos(1,Spot(e,1),Strike(e,8), r(e,2), ...
        q(e,2),Sigma(e,8), Tiempo(e,2),M,N,"other");
end
toc

tic
for e=1:size(Spot,1)
    Heston8(e,1)=HestonCallPrice(Spot(e,1),Strike(e,8),r(e,2),q(e,2),...
        Tiempo(e,2),vt,theta,w,sig,rho,psi);
end
toc

%% Step 8
% Calculamos la volatilidad implicita para ambos modelos
SigmaMCBS=0.15;
Accuracy=0.001;

tic
for k=1:size(r,1)
    [ValoresMC8(k,1), VolMC8(k,1),StepMC(k,1)]=VolBS2(Spot(k,1),r(k,2)...
        ,q(k,2),Tiempo(k,2),Strike(k,8),MC8(k,1),SigmaMCBS...
        ,Accuracy,1);
end
toc

tic
for k=1:size(r,1)
    [ValoresHeston8(k,1), VolHeston8(k,1),StepHeston(k,1)]=VolBS2(Spot(k,1),r(k,2)...
        ,q(k,2),Tiempo(k,2),Strike(k,8),Heston8(k,1),SigmaMCBS...
        ,Accuracy,1);
end
toc

disp("Los steps con Monte-Carlo son: "+sum(StepMC))
disp("Los steps con Heston son: "+sum(StepHeston))


disp("El error promedio con Monte-Carlo es: "+ ErrorPromedio(VolMC8,Sigma(:,8))/ErrorPromedio(Sigma(:,8),0)*100+"%")
disp("El error promedio con Heston es: "+ ErrorPromedio(VolHeston8,Sigma(:,8))/ErrorPromedio(Sigma(:,8),0)*100+"%")

