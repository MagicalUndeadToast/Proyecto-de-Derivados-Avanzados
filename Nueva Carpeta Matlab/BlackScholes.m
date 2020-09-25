function V = BlackScholes(ep, S0, K, q, rf, T, sigma)

d1= (log(S0./K)+(rf-q).*T)./(sigma.*sqrt(T))+ (sigma.*sqrt(T)./2);
d2= d1-sigma.*sqrt(T);

%Devuelvo V_0 co black-scholes
V= ep.*S0.*exp(-q.*T).*normcdf(ep.*d1)-ep.*K.*exp(-rf.*T).*normcdf(ep.*d2); %Devuelve valor con formula de Black-Scholes
end