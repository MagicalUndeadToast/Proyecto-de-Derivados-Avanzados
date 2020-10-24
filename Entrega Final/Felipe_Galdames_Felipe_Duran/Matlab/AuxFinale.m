function [AuxFinale] = AuxFinale(Sigma,Spot,Strike,r,q,Tiempo,...
    vt,theta,w,sig,rho,i)
%AuxFinale Simplemente entrega un paso mas en la anidacion de funciones.
%   Entrega el error promedio con los datos anidados.
AuxFinale=ErrorPromedio(Sigma(i,:),FuncionAux(Spot,Strike,r...
        ,q,Tiempo,vt,theta,w,sig,rho,i));
end

