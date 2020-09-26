function [fairvalue,delta,gamma,vega] = ValueBS(So,K,r,q,Tiempo,sigma,e)
%Funcion que calcula el fairvalue y el vega a partir de la G-K y
%blackscholes
d1=((((log(So/K))+(r-q)*Tiempo)/(sigma*sqrt(Tiempo))) +(sigma*sqrt(Tiempo)/2));
d2=d1-sigma*sqrt(Tiempo);
%Primero lo hacemos con la formula que tenemos de las transparencias.
%estamos en una call
fairvalue=e*So*exp(-q*Tiempo)*normcdf(e*d1)-e*K*exp(-r*Tiempo)*normcdf(e*d2);
delta=e*exp(-q*Tiempo)*normcdf(e*d1);
gamma=exp(-q*Tiempo)*((normpdf(d1))/(So*sigma*sqrt(Tiempo)));
vega=So*exp(-q*Tiempo)*normpdf(d1)*sqrt(Tiempo);
end

