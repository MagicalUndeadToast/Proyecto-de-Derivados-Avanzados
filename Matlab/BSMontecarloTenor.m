function [ValueMCBS,ValorTeoricoMCBS] = BSMontecarloTenor(e,Spot,Strike,r,q,Tiempo,M,N)
%Calcula montecarlo para el primer tenor y todos los sigma, ordenados en
%primera instancia por los 5 Tenores para un sigma fijo y luego cambiando
%de sigma para la siguiente iteracion.
%   Matriz para todos los sigma y todos los tenores, ordenados por 5
%   Tenores para el mismo sigma 4 veces consecutivas.

% Partimos con un sigma de 0.05.
SigmaMCBS=0.05;
% Tenor de 1 mes.
for k=1:size(r,1)
    ValueMCBS(k,1)=getMonteCarlos(e,Spot(k,1),Strike(k,1), r(k,1)...
        , q(k,1),SigmaMCBS, Tiempo(k,1),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,1)=ValueBS(Spot(k,1),Strike(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 3 meses.
for k=1:size(r,1)
    ValueMCBS(k,2)=getMonteCarlos(e,Spot(k,1),Strike(k,1+5), r(k,2)...
        , q(k,2),SigmaMCBS, Tiempo(k,2),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,2)=ValueBS(Spot(k,1),Strike(k,1+5),r(k,2)...
        ,q(k,2),Tiempo(k,2),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 6 meses.
for k=1:size(r,1)
    ValueMCBS(k,3)=getMonteCarlos(e,Spot(k,1),Strike(k,1+10), r(k,3)...
        , q(k,3),SigmaMCBS, Tiempo(k,3),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,3)=ValueBS(Spot(k,1),Strike(k,1+10),r(k,3)...
        ,q(k,3),Tiempo(k,3),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 9 meses.
for k=1:size(r,1)
    ValueMCBS(k,4)=getMonteCarlos(e,Spot(k,1),Strike(k,1+15), r(k,4)...
        , q(k,4),SigmaMCBS, Tiempo(k,4),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,4)=ValueBS(Spot(k,1),Strike(k,1+15),r(k,4)...
        ,q(k,4),Tiempo(k,4),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 12 meses.
for k=1:size(r,1)
    ValueMCBS(k,5)=getMonteCarlos(e,Spot(k,1),Strike(k,1+20), r(k,5)...
        , q(k,5),SigmaMCBS, Tiempo(k,5),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,5)=ValueBS(Spot(k,1),Strike(k,1+20),r(k,5)...
        ,q(k,5),Tiempo(k,5),SigmaMCBS,e); %#ok<*AGROW>
end


% Ahora cambiamos a una volatilidad de 0.1.
SigmaMCBS=0.1;
% Tenor de 1 mes.
for k=1:size(r,1)
    ValueMCBS(k,6)=getMonteCarlos(e,Spot(k,1),Strike(k,1), r(k,1)...
        , q(k,1),SigmaMCBS, Tiempo(k,1),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,6)=ValueBS(Spot(k,1),Strike(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 3 meses.
for k=1:size(r,1)
    ValueMCBS(k,7)=getMonteCarlos(e,Spot(k,1),Strike(k,1+5), r(k,2)...
        , q(k,2),SigmaMCBS, Tiempo(k,2),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,7)=ValueBS(Spot(k,1),Strike(k,1+5),r(k,2)...
        ,q(k,2),Tiempo(k,2),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 6 meses.
for k=1:size(r,1)
    ValueMCBS(k,8)=getMonteCarlos(e,Spot(k,1),Strike(k,1+10), r(k,3)...
        , q(k,3),SigmaMCBS, Tiempo(k,3),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,8)=ValueBS(Spot(k,1),Strike(k,1+10),r(k,3)...
        ,q(k,3),Tiempo(k,3),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 9 meses.
for k=1:size(r,1)
    ValueMCBS(k,9)=getMonteCarlos(e,Spot(k,1),Strike(k,1+15), r(k,4)...
        , q(k,4),SigmaMCBS, Tiempo(k,4),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,9)=ValueBS(Spot(k,1),Strike(k,1+15),r(k,4)...
        ,q(k,4),Tiempo(k,4),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 12 meses.
for k=1:size(r,1)
    ValueMCBS(k,10)=getMonteCarlos(e,Spot(k,1),Strike(k,1+20), r(k,5)...
        , q(k,5),SigmaMCBS, Tiempo(k,5),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,10)=ValueBS(Spot(k,1),Strike(k,1+20),r(k,5)...
        ,q(k,5),Tiempo(k,5),SigmaMCBS,e); %#ok<*AGROW>
end


% Ahora cambiamos a una volatilidad de 0.2.
SigmaMCBS=0.2;
% Tenor de 1 mes.
for k=1:size(r,1)
    ValueMCBS(k,11)=getMonteCarlos(e,Spot(k,1),Strike(k,1), r(k,1)...
        , q(k,1),SigmaMCBS, Tiempo(k,1),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,11)=ValueBS(Spot(k,1),Strike(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 3 meses.
for k=1:size(r,1)
    ValueMCBS(k,12)=getMonteCarlos(e,Spot(k,1),Strike(k,1+5), r(k,2)...
        , q(k,2),SigmaMCBS, Tiempo(k,2),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,12)=ValueBS(Spot(k,1),Strike(k,1+5),r(k,2)...
        ,q(k,2),Tiempo(k,2),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 6 meses.
for k=1:size(r,1)
    ValueMCBS(k,13)=getMonteCarlos(e,Spot(k,1),Strike(k,1+10), r(k,3)...
        , q(k,3),SigmaMCBS, Tiempo(k,3),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,13)=ValueBS(Spot(k,1),Strike(k,1+10),r(k,3)...
        ,q(k,3),Tiempo(k,3),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 9 meses.
for k=1:size(r,1)
    ValueMCBS(k,14)=getMonteCarlos(e,Spot(k,1),Strike(k,1+15), r(k,4)...
        , q(k,4),SigmaMCBS, Tiempo(k,4),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,14)=ValueBS(Spot(k,1),Strike(k,1+15),r(k,4)...
        ,q(k,4),Tiempo(k,4),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 12 meses.
for k=1:size(r,1)
    ValueMCBS(k,15)=getMonteCarlos(e,Spot(k,1),Strike(k,1+20), r(k,5)...
        , q(k,5),SigmaMCBS, Tiempo(k,5),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,15)=ValueBS(Spot(k,1),Strike(k,1+20),r(k,5)...
        ,q(k,5),Tiempo(k,5),SigmaMCBS,e); %#ok<*AGROW>
end


% Ahora cambiamos a una volatilidad de 0.5.
SigmaMCBS=0.5;
% Tenor de 1 mes.
for k=1:size(r,1)
    ValueMCBS(k,16)=getMonteCarlos(e,Spot(k,1),Strike(k,1), r(k,1)...
        , q(k,1),SigmaMCBS, Tiempo(k,1),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,16)=ValueBS(Spot(k,1),Strike(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 3 meses.
for k=1:size(r,1)
    ValueMCBS(k,17)=getMonteCarlos(e,Spot(k,1),Strike(k,1+5), r(k,2)...
        , q(k,2),SigmaMCBS, Tiempo(k,2),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,17)=ValueBS(Spot(k,1),Strike(k,1+5),r(k,2)...
        ,q(k,2),Tiempo(k,2),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 6 meses.
for k=1:size(r,1)
    ValueMCBS(k,18)=getMonteCarlos(e,Spot(k,1),Strike(k,1+10), r(k,3)...
        , q(k,3),SigmaMCBS, Tiempo(k,3),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,18)=ValueBS(Spot(k,1),Strike(k,1+10),r(k,3)...
        ,q(k,3),Tiempo(k,3),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 9 meses.
for k=1:size(r,1)
    ValueMCBS(k,19)=getMonteCarlos(e,Spot(k,1),Strike(k,1+15), r(k,4)...
        , q(k,4),SigmaMCBS, Tiempo(k,4),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,19)=ValueBS(Spot(k,1),Strike(k,1+15),r(k,4)...
        ,q(k,4),Tiempo(k,4),SigmaMCBS,e); %#ok<*AGROW>
end
% Tenor de 12 meses.
for k=1:size(r,1)
    ValueMCBS(k,20)=getMonteCarlos(e,Spot(k,1),Strike(k,1+20), r(k,5)...
        , q(k,5),SigmaMCBS, Tiempo(k,5),M,N,"other"); %#ok<*NASGU>
    ValorTeoricoMCBS(k,20)=ValueBS(Spot(k,1),Strike(k,1+20),r(k,5)...
        ,q(k,5),Tiempo(k,5),SigmaMCBS,e); %#ok<*AGROW>
end
end

