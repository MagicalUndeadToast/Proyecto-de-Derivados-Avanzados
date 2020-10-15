function [fairvalue,sigma,steps,vega,error] = VolBS2(Spot,r,q,Tiempo,Strike,Co,sigmao,accuracy,e)
%Bucle while para Newton Raphson
%   Implementa el bucle while para el algoritmo de newton raphson
sigma=sigmao;
steps=0;
psigma=0;
while (abs(sigma-psigma))>accuracy
    psigma=sigma;
    [pfairvalue,pvega]=ValueBS(Spot,Strike,r,q,Tiempo,psigma,e);
    sigma=psigma+((Co-pfairvalue)./pvega);
    [fairvalue,vega]=ValueBS(Spot,Strike,r,q,Tiempo,sigma,e);
    steps=steps+1;
end
error=abs(psigma-sigma);
end

