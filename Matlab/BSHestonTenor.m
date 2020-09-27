function [ValueHSBS,ValorTeoricoHSBS] = BSHestonTenor(e,Spot,Strike,r,q,...
    Tiempo,theta,w,sig,rho,psi)
%Calcula montecarlo para el primer tenor y todos los sigma, ordenados en
%primera instancia por los 5 Tenores para un sigma fijo y luego cambiando
%de sigma para la siguiente iteracion.
%   Matriz para todos los sigma y todos los tenores, ordenados por 5
%   Tenores para el mismo sigma 4 veces consecutivas.

% Partimos con un sigma de 0.05.
SigmaMCBS=0.05;
% Tenor de 1 mes.
for k=1:size(r,1)
    ValueHSBS(k,1)=HestonCallPrice(Spot(k,1),Strike(k,1),...
        r(k,1),q(k,1),Tiempo(k,1),SigmaMCBS,theta,w,sig,rho,psi); %#ok<AGROW>
    ValorTeoricoHSBS(k,1)=ValueBS(Spot(k,1),Strike(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),SigmaMCBS,e); %#ok<AGROW>
end
% Tenor de 3 meses.
for k=1:size(r,1)
    ValueHSBS(k,2)=HestonCallPrice(Spot(k,1),Strike(k,1+5),...
        r(k,2),q(k,2),Tiempo(k,2),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,2)=ValueBS(Spot(k,1),Strike(k,1+5),r(k,2)...
        ,q(k,2),Tiempo(k,2),SigmaMCBS,e);
end
% Tenor de 6 meses.
for k=1:size(r,1)
    ValueHSBS(k,3)=HestonCallPrice(Spot(k,1),Strike(k,1+10),...
        r(k,3),q(k,3),Tiempo(k,3),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,3)=ValueBS(Spot(k,1),Strike(k,1+10),r(k,3)...
        ,q(k,3),Tiempo(k,3),SigmaMCBS,e);
end
% Tenor de 9 meses.
for k=1:size(r,1)
    ValueHSBS(k,4)=HestonCallPrice(Spot(k,1),Strike(k,1+15),...
        r(k,4),q(k,4),Tiempo(k,4),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,4)=ValueBS(Spot(k,1),Strike(k,1+15),r(k,4)...
        ,q(k,4),Tiempo(k,4),SigmaMCBS,e);
end
% Tenor de 12 meses.
for k=1:size(r,1)
    ValueHSBS(k,5)=HestonCallPrice(Spot(k,1),Strike(k,1+20),...
        r(k,5),q(k,5),Tiempo(k,5),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,5)=ValueBS(Spot(k,1),Strike(k,1+20),r(k,5)...
        ,q(k,5),Tiempo(k,5),SigmaMCBS,e);
end


% Ahora cambiamos a una volatilidad de 0.1.
SigmaMCBS=0.1;
% Tenor de 1 mes.
for k=1:size(r,1)
    ValueHSBS(k,6)=HestonCallPrice(Spot(k,1),Strike(k,1),...
        r(k,1),q(k,1),Tiempo(k,1),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,6)=ValueBS(Spot(k,1),Strike(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),SigmaMCBS,e);
end
% Tenor de 3 meses.
for k=1:size(r,1)
    ValueHSBS(k,7)=HestonCallPrice(Spot(k,1),Strike(k,1+5),...
        r(k,2),q(k,2),Tiempo(k,2),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,7)=ValueBS(Spot(k,1),Strike(k,1+5),r(k,2)...
        ,q(k,2),Tiempo(k,2),SigmaMCBS,e);
end
% Tenor de 6 meses.
for k=1:size(r,1)
    ValueHSBS(k,8)=HestonCallPrice(Spot(k,1),Strike(k,1+10),...
        r(k,3),q(k,3),Tiempo(k,3),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,8)=ValueBS(Spot(k,1),Strike(k,1+10),r(k,3)...
        ,q(k,3),Tiempo(k,3),SigmaMCBS,e);
end
% Tenor de 9 meses.
for k=1:size(r,1)
    ValueHSBS(k,9)=HestonCallPrice(Spot(k,1),Strike(k,1+15),...
        r(k,4),q(k,4),Tiempo(k,4),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,9)=ValueBS(Spot(k,1),Strike(k,1+15),r(k,4)...
        ,q(k,4),Tiempo(k,4),SigmaMCBS,e);
end
% Tenor de 12 meses.
for k=1:size(r,1)
    ValueHSBS(k,10)=HestonCallPrice(Spot(k,1),Strike(k,1+20),...
        r(k,5),q(k,5),Tiempo(k,5),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,10)=ValueBS(Spot(k,1),Strike(k,1+20),r(k,5)...
        ,q(k,5),Tiempo(k,5),SigmaMCBS,e);
end


% Ahora cambiamos a una volatilidad de 0.2.
SigmaMCBS=0.2;
% Tenor de 1 mes.
for k=1:size(r,1)
    ValueHSBS(k,11)=HestonCallPrice(Spot(k,1),Strike(k,1),...
        r(k,1),q(k,1),Tiempo(k,1),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,11)=ValueBS(Spot(k,1),Strike(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),SigmaMCBS,e);
end
% Tenor de 3 meses.
for k=1:size(r,1)
    ValueHSBS(k,12)=HestonCallPrice(Spot(k,1),Strike(k,1+5),...
        r(k,2),q(k,2),Tiempo(k,2),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,12)=ValueBS(Spot(k,1),Strike(k,1+5),r(k,2)...
        ,q(k,2),Tiempo(k,2),SigmaMCBS,e);
end
% Tenor de 6 meses.
for k=1:size(r,1)
    ValueHSBS(k,13)=HestonCallPrice(Spot(k,1),Strike(k,1+10),...
        r(k,3),q(k,3),Tiempo(k,3),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,13)=ValueBS(Spot(k,1),Strike(k,1+10),r(k,3)...
        ,q(k,3),Tiempo(k,3),SigmaMCBS,e);
end
% Tenor de 9 meses.
for k=1:size(r,1)
    ValueHSBS(k,14)=HestonCallPrice(Spot(k,1),Strike(k,1+15),...
        r(k,4),q(k,4),Tiempo(k,4),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,14)=ValueBS(Spot(k,1),Strike(k,1+15),r(k,4)...
        ,q(k,4),Tiempo(k,4),SigmaMCBS,e);
end
% Tenor de 12 meses.
for k=1:size(r,1)
    ValueHSBS(k,15)=HestonCallPrice(Spot(k,1),Strike(k,1+20),...
        r(k,5),q(k,5),Tiempo(k,5),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,15)=ValueBS(Spot(k,1),Strike(k,1+20),r(k,5)...
        ,q(k,5),Tiempo(k,5),SigmaMCBS,e);
end


% Ahora cambiamos a una volatilidad de 0.5.
SigmaMCBS=0.5;
% Tenor de 1 mes.
for k=1:size(r,1)
    ValueHSBS(k,16)=HestonCallPrice(Spot(k,1),Strike(k,1),...
        r(k,1),q(k,1),Tiempo(k,1),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,16)=ValueBS(Spot(k,1),Strike(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),SigmaMCBS,e);
end
% Tenor de 3 meses.
for k=1:size(r,1)
    ValueHSBS(k,17)=HestonCallPrice(Spot(k,1),Strike(k,1+5),...
        r(k,2),q(k,2),Tiempo(k,2),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,17)=ValueBS(Spot(k,1),Strike(k,1+5),r(k,2)...
        ,q(k,2),Tiempo(k,2),SigmaMCBS,e);
end
% Tenor de 6 meses.
for k=1:size(r,1)
    ValueHSBS(k,18)=HestonCallPrice(Spot(k,1),Strike(k,1+10),...
        r(k,3),q(k,3),Tiempo(k,3),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,18)=ValueBS(Spot(k,1),Strike(k,1+10),r(k,3)...
        ,q(k,3),Tiempo(k,3),SigmaMCBS,e);
end
% Tenor de 9 meses.
for k=1:size(r,1)
    ValueHSBS(k,19)=HestonCallPrice(Spot(k,1),Strike(k,1+15),...
        r(k,4),q(k,4),Tiempo(k,4),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,19)=ValueBS(Spot(k,1),Strike(k,1+15),r(k,4)...
        ,q(k,4),Tiempo(k,4),SigmaMCBS,e);
end
% Tenor de 12 meses.
for k=1:size(r,1)
    ValueHSBS(k,20)=HestonCallPrice(Spot(k,1),Strike(k,1+20),...
        r(k,5),q(k,5),Tiempo(k,5),SigmaMCBS,theta,w,sig,rho,psi);
    ValorTeoricoHSBS(k,20)=ValueBS(Spot(k,1),Strike(k,1+20),r(k,5)...
        ,q(k,5),Tiempo(k,5),SigmaMCBS,e);
end
end

