function Precios=PreciosEmpiricos(Spot,Strike,r,q,Tiempo,vt,theta,w,sig,rho,i)

mes=1;
for k=1:25
    Precios(k)=HestonCallPrice(Spot(i,1),Strike(i,k)...
,r(i,mes),q(i,mes),Tiempo(i,mes),vt,theta,w,sig,rho,theta.*w);
    
    %Avanza en los meses.
    if(mod(k,5)==0)
        mes=mes+1;
    end
end
  
Auxiliar=Precios;

end
