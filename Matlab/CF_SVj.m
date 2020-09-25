function fj=CF_SVj(xt,vt,tau,r,q,a,uj,bj,rho,sig,phi)

%Datos a calibrar: Vt, rho, sig, theta y w.
gj = bj - rho.*sig.*phi.*1i; %Sig= Volatilidad de la varianza
dj = sqrt( gj.^2 - (sig.^2).*( 2.*uj.*phi.*1i - phi.^2 ) );
gj = ( xj+dj )./( xj-dj );
D  = ( xj+dj )./(sig.^2).* ( 1-exp(dj.*tau) )./( 1-gj.*exp(dj.*tau)  ) ;
xx = ( 1-gj.*exp(dj.*tau) )./( 1-gj );
C  = (r-q).*phi.*1i.*tau + a./( sig.^2 ) .* ( (xj+dj) .* tau - 2.*log(xx) );
fj = exp( C + D.*vt + 1i.*phi.*xt );
end



