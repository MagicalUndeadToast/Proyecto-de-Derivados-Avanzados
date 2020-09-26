function [ErrorPromedio] = ErrorPromedio(Matrix1,Matrix2)
%Funcion hecha casi al final para calcular el error medio absoluto.
%   Al poner dos matrices calcula el error entre ellas, para poder usarse
%   en la consola o en comprobaciones rapidas.
ErrorPromedio=mean2(abs(Matrix1-Matrix2));
end

