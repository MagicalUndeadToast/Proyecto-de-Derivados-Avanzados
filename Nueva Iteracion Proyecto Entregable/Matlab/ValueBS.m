function [fairvalue,delta,gamma,vega] = ValueBS(So,K,r,q,T,sigma,e)
%Funcion que calcula el fairvalue y el vega a partir de la G-K y
%blackscholes
d1=((((log(So/K))+(r-q)*T)/(sigma*sqrt(T))) +(sigma*sqrt(T)/2));
d2=d1-sigma*sqrt(T);
%Primero lo hacemos con la formula que tenemos de las transparencias.
%estamos en una call
fairvalue=e*So*exp(-q*T)*normcdf(e*d1)-e*K*exp(-r*T)*normcdf(e*d2);
delta=e*exp(-q*T)*normcdf(e*d1);
gamma=exp(-q*T)*((normpdf(d1))/(So*sigma*sqrt(T)));
vega=So*exp(-q*T)*normpdf(d1)*sqrt(T);
end

