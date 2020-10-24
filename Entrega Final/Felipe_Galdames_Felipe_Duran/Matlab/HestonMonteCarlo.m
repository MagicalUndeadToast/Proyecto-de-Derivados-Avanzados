function [SM,VarianzaFinal,SM2]= HestonMonteCarlo(e,Spot,Strike, r, q, Tiempo,M,N,vt,theta,w,sigma,rho,opcion)

rng(2);
a=0;
b=Tiempo;
tiempo= linspace(a,b,N);%genera N numeros espaciados de igual forma entre a y b.
SM=Spot; %Crea matriz inicial con valores iniciales igual a So.
dt=tiempo(2);  %t2-t1



Z=normrnd(0,1,[M,N])*sqrt(dt); %Wieneer1
WienerAux=normrnd(0,1,[M,N])*sqrt(dt); %W Aleatorio
Z1=rho.*Z+sqrt(1-rho^2).*WienerAux; % W aleatorio correlacionado

% Vector inicial de varianzas
VarianzaFinal=vt*ones(M,1);

% Calculamos todas las vols
for i=1:M
    for e=2:N
        VarianzaFinal(i,e)=abs(theta*(w-vt)*dt+sigma*Z1(i,e)+vt);
    end
end


Aux=exp((r-q-(VarianzaFinal)./2).*dt+sqrt(VarianzaFinal).*Z);% A los valores normales anteriores les aplica un funcion exp.
SM=SM.*(prod(Aux'))'; %Calcula el valor final de la simulaicon de monte carlos.
SM2=SM.*(prod(Aux'))';
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
