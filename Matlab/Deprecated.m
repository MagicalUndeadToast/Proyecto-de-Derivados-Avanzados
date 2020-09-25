function [Porcentaje,LimitesInferiores,LimitesSuperiores] = Deprecated(ValorTeorico,ValorEmpirico)
%Intervalo de Confianza Calcula los limites inferiores y superiores de la 
%   Detailed explanation goes here.

for i=1:size(ValorTeorico,2)
    contador=0;
    pd=fitdist(ValorTeorico(:,1),'Normal');
    ci=paramci(pd,'Alpha',.01);
    LimiteInferior=ci(1,1);
    LimiteSuperior=ci(2,1);
    LimitesInferiores(1,i)=LimiteInferior; %#ok<*AGROW>
    LimitesSuperiores(1,i)=LimiteSuperior; %#ok<*NASGU>
    
    for k=1:size(ValorTeorico,1)
        if (LimiteInferior<=ValorEmpirico(k,i) && ValorEmpirico(k,i)<=LimiteSuperior)
            contador=contador+1;
        end
    end
    contadores(1,i)=contador;
end
for i=1:size(ValorTeorico,2)
    Porcentajes(1,i)=contadores(1,i)/size(ValorTeorico(1,i),1);
end
Porcentaje=mean(Porcentajes);
end

