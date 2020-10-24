function V = BlackScholes(ep, S0, K, q, rf, Tiempo, sigma)

d1= (log(S0./K)+(rf-q).*Tiempo)./(sigma.*sqrt(Tiempo))+ (sigma.*sqrt(Tiempo)./2);
d2= d1-sigma.*sqrt(Tiempo);

%Devuelvo V_0 co black-scholes
V= ep.*S0.*exp(-q.*Tiempo).*normcdf(ep.*d1)-ep.*K.*exp(-rf.*Tiempo).*normcdf(ep.*d2); %Devuelve valor con formula de Black-Scholes
end