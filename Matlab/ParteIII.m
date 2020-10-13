% Parte III Proyecto
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

%% Parametros

vt=0.1^2;
theta=0.015;
w=0.01;
sig=0.1^2;
rho=0.05;
psi=theta.*w;

%%
%HestonCallPrice(Spot(1,1),Strike(1,1),r(1,1),q(1,1),Tiempo(1,1),vt,theta,w,sig,rho,psi)
for k=1:804
    Prueba(k,1)=...
        HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi);
    
    [fairvalueHeston(k,1),sigmaHeston(k,1)]=VolBS2(Spot(k,1),r(k,1),q(k,1),Tiempo(k,1),...
        Strike(k,1),Prueba(k,1),0.1,0.1/100,1);
end
x=Sigma(:,1);
ErrorPromedio(Prueba,OptionValue(:,1))
ErrorPromedio(sigmaHeston,x)
