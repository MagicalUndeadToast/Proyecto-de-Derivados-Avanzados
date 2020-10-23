function x=Step6()
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
clc

%Parametros iniciales
% NO TOCAR
vt=0.9;
theta=0.06;
w=0.02;
sig=0.5;
rho=-0.8;
psi=theta.*w;
% NO TOCAR

%Calculamos precios con Bs, Heston y MonteCarlo
M=10000;
N=2;
for k=1:100
    Prueba(k,1)=...
        HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi); %#ok<*SAGROW>
    PruebaBS(k,1)=ValueBS(Spot(k,1),Strike(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),0.05,1);
    [MC(k,1),asdf,SM2]=HestonMonteCarlo(1,Spot(k,1),Strike(k,1), r(k,1), ...
        q(k,1), Tiempo(k,1),M,N,vt,theta,w,sig,rho,"other");
end

a=ErrorPromedioPorcentual(Prueba,PruebaBS);
b=ErrorPromedioPorcentual(MC,PruebaBS);
c=ErrorPromedioPorcentual(Prueba,MC);

disp("Error entre Heston y BS es: "+a+"%")
disp("Error entre MC y BS es: "+b+"%")
disp("Error entre Heston y MC es: "+c+"%")

%% Analizamos el parametro vt
c=0.01:0.01:1;
for k=1:100
    vt=c(k);
    Prueba(k,1)=...
        HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi); %#ok<*SAGROW>
    [MC(k,1),asdf,SM2]=HestonMonteCarlo(1,Spot(k,1),Strike(k,1), r(k,1), ...
        q(k,1), Tiempo(k,1),M,N,vt,theta,w,sig,rho,"other");
end

figure
plot(c,Prueba)
hold on
plot(c,MC)
title("V_0 en funcion de vt "), xlabel("v_t"), ylabel("V_0")
legend("V_0 con Heston","V_0 con MC")

%Cambiamos el parametro Theta
vt=0.9;
c=0:1:99;
for k=1:100
    theta=c(k);
    Prueba(k,1)=...
        HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi); %#ok<*SAGROW>
    [MC(k,1),asdf,SM2]=HestonMonteCarlo(1,Spot(k,1),Strike(k,1), r(k,1), ...
        q(k,1), Tiempo(k,1),M,N,vt,theta,w,sig,rho,"other");
end
figure
plot(c,Prueba)
hold on
plot(c,MC)
title("V_0 en funcion de \theta "), xlabel("\theta"), ylabel("V_0")
legend("V_0 con Heston","V_0 con MC")

%Cambiamos el parametro w
theta=0.06;
c=0.01:0.01:1;
for k=1:100
    w=c(k);
    Prueba(k,1)=...
        HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi); %#ok<*SAGROW>
    [MC(k,1),asdf,SM2]=HestonMonteCarlo(1,Spot(k,1),Strike(k,1), r(k,1), ...
        q(k,1), Tiempo(k,1),M,N,vt,theta,w,sig,rho,"other");
end
figure
plot(c,Prueba)
hold on
plot(c,MC)
title("V_0 en funcion de \omega "), xlabel("\omega"), ylabel("V_0")
legend("V_0 con Heston","V_0 con MC")


%Cambiamos el parametro sig
w=0.02;
c=0.005:0.005:0.5;
for k=1:100
    sig=c(k);
    Prueba(k,1)=...
        HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi); %#ok<*SAGROW>
    [MC(k,1),asdf,SM2]=HestonMonteCarlo(1,Spot(k,1),Strike(k,1), r(k,1), ...
        q(k,1), Tiempo(k,1),M,N,vt,theta,w,sig,rho,"other");
end
figure
plot(c,Prueba)
hold on
plot(c,MC)
title("V_0 en funcion de \sigma "), xlabel("\sigma"), ylabel("V_0")
legend("V_0 con Heston","V_0 con MC")

%Cambiamos el parametro rho
sig=0.5;
c=-0.9:0.0181:0.9;
for k=1:100
    rho=c(k);
    Prueba(k,1)=...
        HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi); %#ok<*SAGROW>
    [MC(k,1),asdf,SM2]=HestonMonteCarlo(1,Spot(k,1),Strike(k,1), r(k,1), ...
        q(k,1), Tiempo(k,1),M,N,vt,theta,w,sig,rho,"other");
end
figure
plot(c,Prueba)
hold on
plot(c,MC)
title("V_0 en funcion de \rho "), xlabel("\rho"), ylabel("V_0")
legend("V_0 con Heston","V_0 con MC")
end
