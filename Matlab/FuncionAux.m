function Auxiliar = FuncionAux(Spot,Strike,r,q,Tiempo,vt,theta,w,sig,rho)

mes=1;
for k=1:25
    vol(1,k)=dummyFunction(Spot(1,1),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k),...
        HestonCallPrice(Spot(1,1),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),vt,theta,w,sig,rho,theta.*w)...
        ,0.1,0.1/100,1);
    
    %Avanza en los meses.
    if(mod(k,5)==0)
        mes=mes+1;
    end
end
  
Auxiliar=vol;

end
