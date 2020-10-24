function [SigmaAuxiliar] = dummyFunction...
    (Spot,r,q,Tiempo,Strike,Co,sigmao,accuracy,e)
%Una funcion auxiliar para la optimizacion.
%   No hay mucho mas que decir en realidad.
[~,SigmaAuxiliar]=VolBS2(Spot,r,q,Tiempo,Strike,Co,sigmao,accuracy,e);
end

