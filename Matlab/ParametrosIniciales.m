function res=ParametrosIniciales(Sigma,Spot)
%Se crea el modelo de regresion lineal entre la volatilidad al cuadrado y
%su diferencia.
y=diff(Sigma(:,3).^2);
x=Sigma(2:804,3).^2;
X=[ones(length(x),1),x];

% Se resuelve el problema y estima A y B.
b=X\y;
A=b(1);
B=b(2);
%Calculamos a partir de estos parametros los valores de theta, w, psi, vt,
%sig,rho
deltaT=1/252;
theta=-B/deltaT;
w=A/(theta*deltaT);
psi=theta*w;
vt=std(Sigma(:,3));
sig=psi^2*deltaT*vt;
theta=0.01;
rho=corrcoef(diff(Sigma(:,3).^2),diff(Spot));
par=["Vt","Theta","w","VolVol","Rho"];
par2=[vt,theta,w,sig,rho(1,2)];

% Imprime resultados
for i=1:5
    disp(par(i)+": "+par2(i))
end
disp(" ")
res=par2;
end
