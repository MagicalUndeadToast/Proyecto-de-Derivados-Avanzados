function [MC8,Heston8] = HSMCFairValue(M,N,e,Spot,Strike,r,q,...
    Sigma,Tiempo,vt,theta,w,sig,rho,psi) %#ok<INUSL>
%Funcion que calcula los fair value a partir de los parametros ingresados
%con Heston y Monte-Carlos con el objetivo de luego comparar las
%volatilidades implicitas obtenidas.
%   A partir de los parametros entregados calcula las volatilidades del
%   pilar ATM en el tenor de 3 meses.
for k=1:size(Spot,1)
    MC8(k,1)=getMonteCarlos(e,Spot(k,1),Strike(k,8), r(k,2), ...
        q(k,2),Sigma(k,8), Tiempo(k,2),M,N,"other"); %#ok<AGROW>
end
for k=1:size(Spot,1)
    vt=Sigma(k,8)^2;
    w=Sigma(k,8)^2;
    Heston8(k,1)=HestonCallPrice(Spot(k,1),Strike(k,8),r(k,2),q(k,2),...
        Tiempo(k,2),vt,theta,w,sig,rho,psi); %#ok<AGROW>
end
end

