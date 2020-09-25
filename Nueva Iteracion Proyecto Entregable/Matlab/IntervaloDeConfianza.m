function [Porcentaje,Porcentajes,LimiteInferior,LimiteSuperior,contadores] = IntervaloDeConfianza(ValorTeorico,ValorEmpirico)
%Intervalo de Confianza Calcula los limites inferiores y superiores de la 
%Distribucion respectiva, entregando otros parametros tambien. 
%   Calcula el intervalo de confianza al 99% para las distribuciones.
ValueNormal=normalize(ValorEmpirico);
LimiteInferior=norminv(0.005);
LimiteSuperior=norminv(0.995);
for i=1:size(ValorTeorico,2)
    contador=0;
    for k=1:size(ValorTeorico,1)
        if (LimiteInferior<=ValueNormal(k,i) && ValueNormal(k,i)<=LimiteSuperior)
            contador=contador+1;
        end
    end
    contadores(1,i)=contador;
end
for i=1:size(ValorTeorico,2)
    Porcentajes(1,i)=contadores(1,i)/size(ValorTeorico,1); %#ok<*AGROW>
end
Porcentaje=mean(Porcentajes);
end

