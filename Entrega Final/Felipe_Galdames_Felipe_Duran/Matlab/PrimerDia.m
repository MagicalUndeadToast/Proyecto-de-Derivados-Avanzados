function [sigmas,parametros]= PrimerDia(Spot,r,q,Tiempo,Strike,Sigma)

x0 = [0.2^2, 0.01, 0.01, 0.5,0.05];
% 1 MES
mes=1;
for k=1:5
%     fun = @(x)abs(HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
%         -OptionValue(k,1));

%     V0=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3));
%     
    fun= @(x)abs(dummyFunction(Spot(1,1),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k),...
        HestonCallPrice(Spot(1,1),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
        ,0.1,0.1/100,1)-Sigma(1,k));
    
    lb = [0, 0, 0, 0, -.9];
    ub = [1, 100, 1, .5, .9];
    %options = optimset('Display','none');
    %x = fminsearch(fun,x0,options);
    x = fmincon(fun,x0,[],[],[],[],lb,ub);
    
    vt=x(1);
    theta=x(2);
    w=x(3);
    sig=x(4);
    rho=x(5);
    psi=x(2)*x(3);
    x0=x;
    parametros(1,k)=x(1);
    parametros(2,k)=x(2);
    parametros(3,k)=x(3);
    parametros(4,k)=x(4);
    parametros(5,k)=x(5);
    parametros(6,k)=x(2)*x(3);
    
%     %ValorEmpirico(k,1)=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi);
    
    [~,SigmaEmpirico(k,1)]=VolBS2(Spot(1,mes),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k)...
        ,HestonCallPrice(Spot(1,mes),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),x(1),x(2),x(3),x(4),x(5),x(2)*x(3)),0.01,0.1/100,1);
   
end

% 3 MESES
mes=2;
for k=6:10
%     fun = @(x)abs(HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
%         -OptionValue(k,1));

%     V0=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3));
%     
    fun= @(x)abs(dummyFunction(Spot(1,1),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k),...
        HestonCallPrice(Spot(1,1),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
        ,0.1,0.1/100,1)-Sigma(1,k));
    
    lb = [0, 0, 0, 0, -.9];
    ub = [1, 100, 1, .5, .9];
    %options = optimset('Display','none');
    %x = fminsearch(fun,x0,options);
    x = fmincon(fun,x0,[],[],[],[],lb,ub);
    
    vt=x(1);
    theta=x(2);
    w=x(3);
    sig=x(4);
    rho=x(5);
    psi=x(2)*x(3);
    x0=x;
    parametros(1,k)=x(1);
    parametros(2,k)=x(2);
    parametros(3,k)=x(3);
    parametros(4,k)=x(4);
    parametros(5,k)=x(5);
    parametros(6,k)=x(2)*x(3);
    
%     %ValorEmpirico(k,1)=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi);
    
    [~,SigmaEmpirico(k,1)]=VolBS2(Spot(1,1),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k)...
        ,HestonCallPrice(Spot(1,1),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),x(1),x(2),x(3),x(4),x(5),x(2)*x(3)),0.01,0.1/100,1);
    

end

% 6 MESES
mes=3;
for k=11:15
%     fun = @(x)abs(HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
%         -OptionValue(k,1));

%     V0=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3));
%     
    fun= @(x)abs(dummyFunction(Spot(1,1),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k),...
        HestonCallPrice(Spot(1,1),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
        ,0.1,0.1/100,1)-Sigma(1,k));
    
    lb = [0, 0, 0, 0, -.9];
    ub = [1, 100, 1, .5, .9];
    %options = optimset('Display','none');
    %x = fminsearch(fun,x0,options);
    x = fmincon(fun,x0,[],[],[],[],lb,ub);
    
    vt=x(1);
    theta=x(2);
    w=x(3);
    sig=x(4);
    rho=x(5);
    psi=x(2)*x(3);
    x0=x;
    parametros(1,k)=x(1);
    parametros(2,k)=x(2);
    parametros(3,k)=x(3);
    parametros(4,k)=x(4);
    parametros(5,k)=x(5);
    parametros(6,k)=x(2)*x(3);
    
%     %ValorEmpirico(k,1)=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi);
    
    [~,SigmaEmpirico(k,1)]=VolBS2(Spot(1,1),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k)...
        ,HestonCallPrice(Spot(1,1),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),x(1),x(2),x(3),x(4),x(5),x(2)*x(3)),0.01,0.1/100,1);
    

end

% 9 MESES
mes=4;
for k=16:20
%     fun = @(x)abs(HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
%         -OptionValue(k,1));

%     V0=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3));
%     
    fun= @(x)abs(dummyFunction(Spot(1,1),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k),...
        HestonCallPrice(Spot(1,1),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
        ,0.1,0.1/100,1)-Sigma(1,k));
    
    lb = [0, 0, 0, 0, -.9];
    ub = [1, 100, 1, .5, .9];
    %options = optimset('Display','none');
    %x = fminsearch(fun,x0,options);
    x = fmincon(fun,x0,[],[],[],[],lb,ub);
    
    vt=x(1);
    theta=x(2);
    w=x(3);
    sig=x(4);
    rho=x(5);
    psi=x(2)*x(3);
    x0=x;
    parametros(1,k)=x(1);
    parametros(2,k)=x(2);
    parametros(3,k)=x(3);
    parametros(4,k)=x(4);
    parametros(5,k)=x(5);
    parametros(6,k)=x(2)*x(3);
    
%     %ValorEmpirico(k,1)=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi);
    
    [~,SigmaEmpirico(k,1)]=VolBS2(Spot(1,1),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k)...
        ,HestonCallPrice(Spot(1,1),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),x(1),x(2),x(3),x(4),x(5),x(2)*x(3)),0.01,0.1/100,1);
    

end
% 12 MESES
mes=5;
for k=21:25
%     fun = @(x)abs(HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
%         -OptionValue(k,1));

%     V0=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),x(1),x(2),x(3),x(4),x(5),x(2)*x(3));
%     
    fun= @(x)abs(dummyFunction(Spot(1,1),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k),...
        HestonCallPrice(Spot(1,1),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),x(1),x(2),x(3),x(4),x(5),x(2)*x(3))...
        ,0.1,0.1/100,1)-Sigma(1,k));
    
    lb = [0, 0, 0, 0, -.9];
    ub = [1, 100, 1, .5, .9];
    %options = optimset('Display','none');
    %x = fminsearch(fun,x0,options);
    x = fmincon(fun,x0,[],[],[],[],lb,ub);
    
    vt=x(1);
    theta=x(2);
    w=x(3);
    sig=x(4);
    rho=x(5);
    psi=x(2)*x(3);
    x0=x;
    parametros(1,k)=x(1);
    parametros(2,k)=x(2);
    parametros(3,k)=x(3);
    parametros(4,k)=x(4);
    parametros(5,k)=x(5);
    parametros(6,k)=x(2)*x(3);
    
%     %ValorEmpirico(k,1)=HestonCallPrice(Spot(k,1),Strike(k,1),r(k,1),...
%         q(k,1),Tiempo(k,1),vt,theta,w,sig,rho,psi);
    
    [~,SigmaEmpirico(k,1)]=VolBS2(Spot(1,1),r(1,mes),q(1,mes),Tiempo(1,mes),Strike(1,k)...
        ,HestonCallPrice(Spot(1,1),Strike(1,k),r(1,mes),...
        q(1,mes),Tiempo(1,mes),x(1),x(2),x(3),x(4),x(5),x(2)*x(3)),0.01,0.1/100,1);
    

end
sigmas=SigmaEmpirico;

end
