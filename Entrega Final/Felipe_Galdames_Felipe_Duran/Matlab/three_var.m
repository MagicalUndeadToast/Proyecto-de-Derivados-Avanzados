function b = three_var(v)
vt=v(1);
theta=v(2);
w=v(3);
sig=v(4);
rho=v(5);
psi=v(6);


for k=1:804
    Prueba(k,1)=...
        HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
        q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi);
    
    [fairvalueHeston(k,1),sigmaHeston(k,1)]=VolBS2(Spot(k,1),r(k,1),q(k,1),Tiempo(k,1),...
        Strike(k,1),Prueba(k,1),0.1,0.1/100,1);
end

b = ErrorPromedio(Prueba,OptionValue(:,1))
end