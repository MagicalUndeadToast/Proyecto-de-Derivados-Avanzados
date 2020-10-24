function aux = ErrorFila(matriz1,matriz2)
%Calcula el error que tiene cada fila
aux=mean(abs(matriz1-matriz2)')';
end