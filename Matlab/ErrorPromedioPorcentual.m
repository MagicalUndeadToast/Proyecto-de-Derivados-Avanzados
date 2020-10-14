function [ErrorPromedioPorcentual] = ...
    ErrorPromedioPorcentual(Empirica,Teorica)
%Funcion hecha casi al final para calcular el error medio absoluto.
%   Al poner dos matrices calcula el error entre ellas, para poder usarse
%   en la consola o en comprobaciones rapidas.
ErrorPromedioPorcentual=mean2(abs(Empirica-Teorica))...
    /mean2(abs(Teorica));
ErrorPromedioPorcentual=ErrorPromedioPorcentual*100;
end

