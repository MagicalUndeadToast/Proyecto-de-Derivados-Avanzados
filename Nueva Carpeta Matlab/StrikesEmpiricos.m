function [StrikesEmpiricos] = StrikesEmpiricos(Spot,r,q,Pilares,Tiempo,Sigma,e)
%Funcion que permite ocultar codigo para que el codigo se vea mas ordenado,
%esta calcula los Strike y los junta en una sola matriz.
%   Es simplemente para poder abordar el problema por partes.
%Mes uno
aux=1; 
for i=1:size(r,1)
    for k=1:size(r,2)
        alpha(i,k)=exp(-q(i,aux)*Tiempo(i,aux)); %#ok<*AGROW,*SAGROW>
        Delta=e*norminv(e*Pilares(k)/alpha(i,k));
        Strike1Mes(i,k)=Spot(i,1).*exp((r(i,aux)-q(i,aux)).*Tiempo(i,aux)).*exp((Sigma(i,k).^2*Tiempo(i,aux)./2)-Delta.*Sigma(i,k).*sqrt(Tiempo(i,aux)));  %#ok<AGROW>
    end
end

%Mes 3
aux=2; 
for i=1:size(r,1)
    for k=1:size(r,2)
        alpha(i,k)=exp(-q(i,aux)*Tiempo(i,aux));
        Delta=e*norminv(e*Pilares(k)/alpha(i,k));
        Strike3Meses(i,k)=Spot(i,1).*exp((r(i,aux)-q(i,aux)).*Tiempo(i,aux)).*exp((Sigma(i,k+5).^2*Tiempo(i,aux)./2)-Delta.*Sigma(i,k+5).*sqrt(Tiempo(i,aux)));  %#ok<AGROW>
    end
end

%Mes 6
aux=3; 
for i=1:size(r,1)
    for k=1:size(r,2)
        alpha(i,k)=exp(-q(i,aux)*Tiempo(i,aux));
        Delta=e*norminv(e*Pilares(k)/alpha(i,k));
        Strike6Meses(i,k)=Spot(i,1).*exp((r(i,aux)-q(i,aux)).*Tiempo(i,aux)).*exp((Sigma(i,k+10).^2*Tiempo(i,aux)./2)-Delta.*Sigma(i,k+10).*sqrt(Tiempo(i,aux)));  %#ok<AGROW>
    end
end

%Mes 9
aux=4; 
for i=1:size(r,1)
    for k=1:size(r,2)
        alpha(i,k)=exp(-q(i,aux)*Tiempo(i,aux));
        Delta=e*norminv(e*Pilares(k)/alpha(i,k));
        Strike9Meses(i,k)=Spot(i,1).*exp((r(i,aux)-q(i,aux)).*Tiempo(i,aux)).*exp((Sigma(i,k+15).^2*Tiempo(i,aux)./2)-Delta.*Sigma(i,k+15).*sqrt(Tiempo(i,aux)));  %#ok<AGROW>
    end
end

%Mes 12+
aux=5; 
for i=1:size(r,1)
    for k=1:size(r,2)
        alpha(i,k)=exp(-q(i,aux)*Tiempo(i,aux));
        Delta=e*norminv(e*Pilares(k)/alpha(i,k));
        Strike12Meses(i,k)=Spot(i,1).*exp((r(i,aux)-q(i,aux)).*Tiempo(i,aux)).*exp((Sigma(i,k+20).^2*Tiempo(i,aux)./2)-Delta.*Sigma(i,k+20).*sqrt(Tiempo(i,aux)));  %#ok<AGROW>
    end
end
% Juntamos los Strike para formar la matriz.
StrikesEmpiricos=[Strike1Mes Strike3Meses Strike6Meses Strike9Meses Strike12Meses];
end

