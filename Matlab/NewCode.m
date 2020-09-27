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
for e=1:804
    Prueba(e,1)=...
        HestonCallPrice(Spot(e,1),Strike(e,1),r(e,1),...
        q(e,1),Tiempo(e,1),vt,theta,w,sig,rho,psi); %#ok<*SAGROW>
    PruebaBS(e,1)=ValueBS(Spot(e,1),Strike(e,1),r(e,1)...
        ,q(e,1),Tiempo(e,1),0.05,1);
end

ErrorPromedio(Prueba,PruebaBS)




%% MMA Section Code.
% Actualizar esta seccion cuando se nos ocurra como hacer la MMA.
for i=1:5
    for k=1:size(r,1)  %CAMBIAR ESTO A SIZE(r,2) PARA CODIGO COMPLETO
        ValueMMA(k,i)=HestonCallPrice(1,Strike(k,1),r(k,i),q(k,i),Tiempo(k,i),vt,theta,w,sig,rho,psi);
        RDiscountNuevos(k,i)=exp(-r(k,i)*Tiempo(k,i));
    end
end

ErrorMMAHS=ErrorPromedio(ValueMMA, RDiscountNuevos);
ErrorMMAHS=ErrorMMAHS/ErrorPromedio(0,RDiscountNuevos);
disp("El error con Heston del MMA es de un: " + ErrorMMAHS*100+"%")
%% Calculos para el Forward.
% Aca hacer los calculos para el Forward con Heston.

[ValueForward,ValorTeoricoFW] = ForwardHeston(1,Spot,Strike,r,q,Tiempo,vt,theta,w,sig,rho,psi);
ErrorFWHS=ErrorPromedio(ValueForward,ValorTeoricoFW);
ErrorFWHS=ErrorFWHS/ErrorPromedio(0,ValorTeoricoFW);
disp("El error con Heston del Forward es de un: " + ErrorFWHS*100+"%")
%% Agregamos las Volatilidades.
% Aca ya no se que poner si te soy sincero.
[ValueHSBS,ValorTeoricoHSBS]=BSHestonTenor(1,Spot,Strike,r,q,Tiempo,theta,w,sig,rho,psi);

ErrorHSBS=ErrorPromedio(ValueHSBS,ValorTeoricoHSBS);
ErrorHSBS=ErrorHSBS/ErrorPromedio(0,ValorTeoricoHSBS);
disp("El error con Heston de Black-Scholes es de un: " + ErrorHSBS*100+"%")
%% Calculo con Heston de Volatilidad Implicita.
% Aca deberiamos usar Newton Raphson.

%% Espacio de Calculo.
% Espacio para hacer calculos en el programa sin tener que correr la
% simulacion de nuevo.
% Abrir una funcion open('').

%%






