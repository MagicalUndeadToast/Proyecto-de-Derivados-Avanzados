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
        Tiempo(i,k)=T(i,k)/T(i,5); %#ok<*SAGROW>
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

%NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR 
x0 = [0.1, 0.01, 0.21, 0.4,0.5]; %Parametros iniciales NO TOCAAAAAR
% NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR 

% CALIBRAMOS PARA EL DIA 1
% for k=1:1
% %     fun = @(x)abs(HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
% %         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
% %         -OptionValue(k,1));
% %     V0=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
% %         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3));
% %     
% %     fun= @(x)abs(dummyFunction(Spot(1,1),r(k,1),q(k,1),Tiempo(k,1),Strike(k,1),...
% %         HestonCallPrice(Spot(1,1),Strike(k,1),r(k,1),...
% %         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
% %         ,0.1,0.1/100,1)-Sigma(k,1));
%     
%     fun=@(x)ErrorPromedio(Sigma(1,:),FuncionAux(Spot,Strike,r...
%         ,q,Tiempo,x(1),x(2),x(3),x(4),x(5))) 
%     
%     lb = [0, 0, 0, 0, -.9];
%     ub = [1, 100, 1, .5, .9];
%     %options = optimset('Display','none');
%     %x = fminsearch(fun,x0,options);
% %     options = optimoptions('fmincon','Display','none');
% %     x = fmincon(fun,x0,[],[],[],[],lb,ub,options);
%     x = fmincon(fun,x0,[],[],[],[],lb,ub);
%     
%     vt=x(1);
%     theta=x(2);
%     w=x(3);
%     sig=x(4);
%     rho=x(5);
%     psi=x(2)*x(3);
%     x0=x;
%     
%     parametros(1,k)=x(1);
%     parametros(2,k)=x(2);
%     parametros(3,k)=x(3);
%     parametros(4,k)=x(4);
%     parametros(5,k)=x(5);
%     parametros(6,k)=x(2)*x(3);
%     
% %     %ValorEmpirico(k,1)=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
% %         q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi);
% 
%     SigmaEmpirico=FuncionAux(Spot,Strike,r,q,Tiempo,x(1),x(2),x(3),x(4),x(5))
% end

[parametrosPD,SigmaEmpiricoPD,tfinalPD,tpromedioPD] = ...
    DBDCalibration(Sigma,Spot,Strike,r,q,Tiempo,x0,'Primer Dia');
%%
disp("El error promedio para el primer dia es: " ...
    + ErrorPromedio(SigmaEmpiricoPD,Sigma(1,:)))
disp("El error promedio porcentual para el primer dia es: " ...
    + ErrorPromedioPorcentual(SigmaEmpiricoPD,Sigma(1,:)) + "%")
%%
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


%%

%NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR 
x0 = [0.1, 0.01, 0.21, 0.4,0.5]; %Parametros iniciales NO TOCAAAAAR
% NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR
tinicial=1;
tfinal=3;
[parametrosFC,SigmaEmpiricoFC,tfinalFC,tpromedioFC] = ...
    DBDCalibration(Sigma,Spot,Strike,r,q,Tiempo,x0,'Fechas',tinicial,tfinal);

%% SMILE 
Tenores=["1 Mes", "3 Meses", "6 Meses", "9 Meses", "12 Meses" ];
for i=1:5
    if i==1
        k=1;
    end  
figure(i+5);
plotaux=[SigmaEmpirico(:,k),SigmaEmpirico(:,k+1),SigmaEmpirico(:,k+2),...
    SigmaEmpirico(:,k+3),SigmaEmpirico(:,k+4)];
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
%%
%NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR 
x0 = [0.1, 0.01, 0.21, 0.4,0.5]; %Parametros iniciales NO TOCAAAAAR
% NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR

[parametrosCP,SigmaEmpiricoCP,tfinalCP,tpromedioCP] = ...
    DBDCalibration(Sigma,Spot,Strike,r,q,Tiempo,x0,'Completo');

%% SMILE Completa
Tenores=["1 Mes", "3 Meses", "6 Meses", "9 Meses", "12 Meses" ];
for i=1:5
    if i==1
        k=1;
    end  
figure(i+10);
plotaux=[SigmaEmpirico(:,k),SigmaEmpirico(:,k+1),SigmaEmpirico(:,k+2),...
    SigmaEmpirico(:,k+3),SigmaEmpirico(:,k+4)];
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
%%


