function [ValueForwardHeston,ValorTeoricoFW] = ForwardHeston(e,Spot,Strike,r,q,Tiempo,vt,theta,w,sig,rho,psi)
%ForwardMontecarlo Sirve para separar codigo de la Main File y obtener los
%valores de los Forwards respectivos.
%   Aplica la funcion de montecarlo para el valor de los forward.
% Tenor de 1 mes.

for k=1:size(r,1)
    ValueForwardHeston(k,1)=HestonCallPrice(Spot(k,1),Strike(k,1),...
        r(k,1),q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi);
    ValorTeoricoFW(k,1)=Spot(k,1)*exp(-q(k,1)*Tiempo(k,1))-Strike(k,1)*...
        exp(-r(k,1)*Tiempo(k,1));
end
% Tenor de 3 meses.
for k=1:size(r,1)
    ValueForwardHeston(k,2)=HestonCallPrice(Spot(k,1),Strike(k,1+5),...
        r(k,2),q(k,2),Tiempo(k,2),vt,theta,w,sig,rho,psi);
    ValorTeoricoFW(k,2)=Spot(k,1)*exp(-q(k,2)*Tiempo(k,2))-Strike(k,1+5)*...
        exp(-r(k,2)*Tiempo(k,2));
end
% Tenor de 6 meses.
for k=1:size(r,1)
    ValueForwardHeston(k,3)=HestonCallPrice(Spot(k,1),Strike(k,1+10),...
        r(k,3),q(k,3),Tiempo(k,3),vt,theta,w,sig,rho,psi);
    ValorTeoricoFW(k,3)=Spot(k,1)*exp(-q(k,3)*Tiempo(k,3))-Strike(k,1+10)*...
        exp(-r(k,3)*Tiempo(k,3));
end
% Tenor de 9 meses.
for k=1:size(r,1)
    ValueForwardHeston(k,4)=HestonCallPrice(Spot(k,1),Strike(k,1+15),...
        r(k,4),q(k,4),Tiempo(k,4),vt,theta,w,sig,rho,psi);
    ValorTeoricoFW(k,4)=Spot(k,1)*exp(-q(k,4)*Tiempo(k,4))-Strike(k,1+15)*...
        exp(-r(k,4)*Tiempo(k,4));
end
% Tenor de 12 meses.
for k=1:size(r,1)
    ValueForwardHeston(k,5)=HestonCallPrice(Spot(k,1),Strike(k,1+20),...
        r(k,5),q(k,5),Tiempo(k,5),vt,theta,w,sig,rho,psi);
    ValorTeoricoFW(k,5)=Spot(k,1)*exp(-q(k,5)*Tiempo(k,5))-Strike(k,1+20)*...
        exp(-r(k,5)*Tiempo(k,5));
end
end

