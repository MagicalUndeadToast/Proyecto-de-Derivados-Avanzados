function SM= getMonteCarlos(e,Spot,Strike, r, q,Sigma, Tiempo,M,N,opcion)

rng(2);
a=0;
b=Tiempo;
tiempo= linspace(a,b,N);%genera N numeros espaciados de igual forma entre a y b.
SM=Spot; %Crea matriz inicial con valores iniciales igual a So.
dt=tiempo(2);  %t2-t1



Z=normrnd(0,1,[M,N]); %Crea matriz de MxN con valores normales
Aux=exp((r-q-(Sigma.^2)./2).*dt+Sigma.*sqrt(dt).*Z);% A los valores normales anteriores les aplica un funcion exp.
SM=SM.*(prod(Aux'))'; %Calcula el valor final de la simulaicon de monte carlos.

switch opcion
    case{'MMA'}
    VT=1;
    case{'other'}
    VT=max(e.*(SM-Strike),0);
    otherwise
    fprint('Posiblemente exista un error');
end

Yt=VT./exp(r*Tiempo);
SM=mean(Yt);


end
