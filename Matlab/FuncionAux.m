function Auxiliar = FuncionAux(Spot,Strike,r,q,Tiempo,vt,theta,w,sig,rho,i)

mes=1;
for k=1:25
    vol(k)=dummyFunction(Spot(i,1),r(i,mes),q(i,mes),Tiempo(i,mes),Strike(i,k),...
        HestonCallPrice(Spot(i,1),Strike(i,k),r(i,mes),...
        q(i,mes),Tiempo(i,mes),vt,theta,w,sig,rho,theta.*w)...
        ,0.1,0.1/10000,1); %#ok<*AGROW>
    
    %Avanza en los meses.
    if(mod(k,5)==0)
        mes=mes+1;
    end
end
  
Auxiliar=vol;

end
