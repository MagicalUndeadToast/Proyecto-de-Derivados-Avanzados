function [C] = HestonCallPrice(Spot,Strike,r,q,T,vt,theta,w,sig,rho,psi)
%Funcion que computa el precio de la opcion a partir de la formula cerrada
%de Heston.
%   A partir de los argumentos ingresados, esta función regresa el precio
%   de a partir de la fórmula cerrada de Heston, haciendo las integrales
%   como suma y utilizando el ppt del profe.

dphi=0.01;
maxphi=50;
phi=(eps:dphi:maxphi)';

% Estos simbolos no se guardan al parecer, dejo su version de latex para
% que asi en caso de tener dudas podamos buscarlos, dado que no apareceran,
% solo en la version local.

% w=\omega
% theta=\theta
% psi=\psi

% \theta= Mean Reversion Speed. Mas grande mas lenta la reversion a la
% media.
% w= Equilibrio de la varianza, suponemos que es donde esta mas o menos la
% varianza.
% vt= Variance Initial Guess. Variancia inicial.

f1 = CF_SVj(log(Spot),vt,T,r,q,theta*w,0.5,theta+psi-rho*sig,rho,sig,phi);
P1 = 0.5+(1/pi)*sum(real(exp(-1i*phi*log(Strike)).*f1./(1i*phi))*dphi);
f2 = CF_SVj(log(Spot),vt,T,r,q,theta*w,-0.5,theta+psi,rho,sig,phi);
P2 = 0.5+(1/pi)*sum(real(exp(-1i*phi*log(Strike)).*f2./(1i*phi))*dphi);
C = Spot*exp(-q*T)*P1 -Strike*exp(-r*T)*P2;

end

