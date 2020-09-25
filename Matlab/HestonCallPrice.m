function [C] = HestonCallPrice(S,K,r,q,T,vt,theta,w,sig,rho,psi)
%Funcion que computa el precio de la opcion a partir de la formula cerrada
%de Heston.
%   A partir de los argumentos ingresados, esta función regresa el precio
%   de a partir de la fórmula cerrada de Heston, haciendo las integrales
%   como suma y utilizando el ppt del profe.

dphi=0.01;
maxphi=50;
phi=(eps:dphi:maxphi)';

% w=?
% theta=?
% psi=?

f1 = CF_SVj(log(S),vt,T,r,q,theta*w,0.5,theta+psi-rho*sig,rho,sig,phi);
P1 = 0.5+(1/pi)*sum(real(exp(-1i*phi*log(K)).*f1./(1i*phi))*dphi);
f2 = CF_SVj(log(S),vt,T,r,q,theta*w,-0.5,theta+psi,rho,sig,phi);
P2 = 0.5+(1/pi)*sum(real(exp(-1i*phi*log(K)).*f2./(1i*phi))*dphi);
C = S*exp(-q*T)*P1 -K*exp(-r*T)*P2;

end

