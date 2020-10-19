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

%% Justificacion de los parametros
clc
X0Inicial=ParametrosIniciales(Sigma,Spot);

%% Calibramos para el primer dia

% Parametros iniciales
x0 = [0.1, 0.01, 0.21, 0.4,0.5]; %Parametros iniciales NO TOCAAAAAR
% NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR 

% Funcion que devuelve los parametros ,sigmas y precios calculados
% con nuestro modelo. 
[parametrosPD,SigmaEmpiricoPD,tfinalPD,tpromedioPD,OptionValueEmpiricoPD] = ...
    DBDCalibration(Sigma,Spot,Strike,r,q,Tiempo,x0,'Primer Dia');
%% Se calculan los diferentes errores para los sigmas y precios para Primer Dia.
SigmaErrorPD=ErrorPromedio(SigmaEmpiricoPD,Sigma(1,:));
PriceErrorPD=ErrorPromedio(OptionValueEmpiricoPD,OptionValue(1,:));
SigmaPercentErrorPD=ErrorPromedioPorcentual(SigmaEmpiricoPD,Sigma(1,:));
PriceErrorPercentPD=ErrorPromedioPorcentual(OptionValueEmpiricoPD,OptionValue(1,:));
RowSigmaErrorPD=ErrorFila(SigmaEmpiricoPD,Sigma(1,:));
RowPriceErrorPD=ErrorFila(OptionValueEmpiricoPD,OptionValue(1,:));

%% Se imprimen los errores de calibracion  del primer dia.
disp("El error promedio de la volatilidad para el primer dia es: " ...
    + SigmaErrorPD)
disp("El error promedio porcentual de la volatilidad para el primer dia es: " ...
    + SigmaPercentErrorPD + "%")
disp("El error promedio del valor de la  opcion para el primer dia es: " ...
    + PriceErrorPD)
disp("El error promedio porcentual del valor de la opcion para el primer dia es: " ...
    + PriceErrorPercentPD + "%")

%% Graficos de la Smile del primer dia en 2D.
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


%% Calibramos para datos entre TInicial y TFinal

% Parametros iniciales para empezar a calibrar.
x0 = [0.1, 0.01, 0.21, 0.4,0.5]; %Parametros iniciales NO TOCAAAAAR
% NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR
tinicial=1;
tfinal=3;
[parametrosFC,SigmaEmpiricoFC,tfinalFC,tpromedioFC,OptionValueEmpiricoFC] = ...
    DBDCalibration(Sigma,Spot,Strike,r,q,Tiempo,x0,'Fechas',tinicial,tfinal);
%% Se calculan los diferentes errores para los sigmas y precios para Fechas.
SigmaErrorFC=ErrorPromedio(SigmaEmpiricoFC,Sigma(tinicial:tfinal,:));
PriceErrorFC=ErrorPromedio(OptionValueEmpiricoFC,OptionValue(tinicial:tfinal,:));
SigmaPercentErrorFC=ErrorPromedioPorcentual(SigmaEmpiricoFC,Sigma(tinicial:tfinal,:));
PriceErrorPercentFC=ErrorPromedioPorcentual(OptionValueEmpiricoFC,OptionValue(tinicial:tfinal,:));
RowSigmaErrorFC=ErrorFila(SigmaEmpiricoFC,Sigma(tinicial:tfinal,:));
RowPriceErrorFC=ErrorFila(OptionValueEmpiricoFC,OptionValue(tinicial:tfinal,:));

%% SMILE de la Data en 3D
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

%% Plot de la Evolucion de los Parametros.
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


%% Calibramos toda la Data

% Parametros iniciales
x0 = [0.1, 0.01, 0.21, 0.4,0.5]; %Parametros iniciales NO TOCAAAAAR
% NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR NO TOCAAAAAR

[parametrosCP,SigmaEmpiricoCP,tfinalCP,tpromedioCP,OptionValueEmpiricoCP] = ...
    DBDCalibration(Sigma,Spot,Strike,r,q,Tiempo,x0,'Completo');
%% Se calculan los diferentes errores para los sigmas y precios.
SigmaErrorCP=ErrorPromedio(SigmaEmpiricoCP,Sigma);
PriceErrorCP=ErrorPromedio(OptionValueEmpiricoCP,OptionValue);
SigmaPercentErrorCP=ErrorPromedioPorcentual(SigmaEmpiricoCP,Sigma);
PriceErrorPercentCP=ErrorPromedioPorcentual(OptionValueEmpiricoCP,OptionValue);
RowSigmaErrorCP=ErrorFila(SigmaEmpiricoCP,Sigma);
RowPriceErrorCP=ErrorFila(OptionValueEmpiricoCP,OptionValue);

%% SMILE Completa
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
%% Plot de la Evolucion de los Parametros.
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

%% A contiuacion se muestra los errores de la data.
% Iteracion 804 completada en 6184.1895 segundos.
ErroresData();
%%