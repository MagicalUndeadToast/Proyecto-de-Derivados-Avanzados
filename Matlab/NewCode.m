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
       SigmaNuevo(k,4+w*5)=SigmaRR(k,1+w*5)+SigmaRR(k,3+w*5)+SigmaRR(k,2+w*5)./2;%#ok<*SAGROW> %Sigma put
       SigmaNuevo(k,2+w*5)=SigmaRR(k,1+w*5)+SigmaRR(k,3+w*5)-SigmaRR(k,2+w*5)./2;%Sigma call
       SigmaNuevo(k,3+w*5)=SigmaRR(k,1+w*5);
       SigmaNuevo(k,5+w*5)=SigmaRR(k,1+w*5)+SigmaRR(k,5+w*5)+SigmaRR(k,4+w*5)./2;%Sigma put
       SigmaNuevo(k,1+w*5)=SigmaRR(k,1+w*5)+SigmaRR(k,5+w*5)-SigmaRR(k,4+w*5)./2; %Sigma call
    end
end

% Error de los Sigmas Respectivos.
ErrorSigma=abs(SigmaNuevo-Sigma);
% Butterfly estan en ForwardEmpirico comentado como Deadcode.
%% New Code Section.
% Aca se inicia el codigo siguiente.

%% Espacio de Calculo.
% Espacio para hacer calculos en el programa sin tener que correr la
% simulacion de nuevo.
%%