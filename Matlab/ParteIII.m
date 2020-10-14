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

vt=0.2^2;
theta=0.015;
w=0.01;
sig=0.5;
rho=0.05;
psi=theta.*w;
%% Parametros con funcion min
% vt=v(1);
% theta=v(2);
% w=v(3);
% sig=v(4);
% rho=v(5);
% psi=v(6);

%%
%HestonCallPrice(Spot(1,1),Strike(1,1),r(1,1),q(1,1),Tiempo(1,1),vt,theta,w,sig,rho,psi)
x0 = [0.2^2, 0.01, 0.01, 0.5,0.05];
for k=1:10
%     fun = @(x)abs(HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
%         -OptionValue(k,1));

%     V0=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3));
%     
    fun= @(x)abs(VolBS2(Spot(k,1),r(k,1),q(k,1),Tiempo(k,1),Strike(k,1),...
        HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
        ,0.1,0.1/100,1)-Sigma(k,1));
    
    lb = [0, 0, 0, 0, -.9];
    ub = [1, 100, 1, .5, .9];
    %options = optimset('Display','none');
    %x = fminsearch(fun,x0,options);
    x = fmincon(fun,x0,[],[],[],[],lb,ub);
    
    vt=x(1);
    theta=x(2);
    w=x(3);
    sig=x(4);
    rho=x(5);
    psi=x(2)*x(3);
    x0=x;
    parametros(1,k)=x(1);
    parametros(2,k)=x(2);
    parametros(3,k)=x(3);
    parametros(4,k)=x(4);
    parametros(5,k)=x(5);
    parametros(6,k)=x(2)*x(3);
    
    ValorEmpirico(k,1)=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi);
    
    SigmaEmpirico(k,1)=VolBS2(Spot(k,1),r(k,1),q(k,1),Tiempo(k,1),Strike(k,1)...
        ,HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3)),0.01,0.1/100,1);

end
% x=Sigma(:,1);
% ErrorPromedio(Prueba,OptionValue(:,1))
% ErrorPromedio(sigmaHeston,x)

%%

