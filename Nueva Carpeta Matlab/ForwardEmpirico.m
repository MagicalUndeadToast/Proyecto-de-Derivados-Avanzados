function [ForwardEmpirico] = ForwardEmpirico(Spot,r,q,T)
%Forward Calcula el precio de los Forward utilizando los parametros
%entregaods a la función.
%   Calcula el precio Forward a partir de los parametros ingresados
%   simplemente.
ForwardEmpirico=(Spot.*exp(-q.*T))./exp(-r.*T);
end
% %%
% % Butterfly 3
% A=0.1;
% LongCall13=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,6:10)-A, q(:,2).*ones(804,5), rf(:,2).*ones(804,5), Tiempo(:,2).*ones(804,5),sigma(:,6:10));
% ShortCall3=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,6:10), q(:,2).*ones(804,5), rf(:,2).*ones(804,5), Tiempo(:,2).*ones(804,5),sigma(:,6:10));
% LongCall23=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,6:10)+A, q(:,2).*ones(804,5), rf(:,2).*ones(804,5), Tiempo(:,2).*ones(804,5),sigma(:,6:10));
% Butterfly3=LongCall13-2.*ShortCall3+LongCall23;
% %%
% % Butterfly 6
% A=0.1;
% LongCall16=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,11:15)-A, q(:,3).*ones(804,5), rf(:,3).*ones(804,5), Tiempo(:,3).*ones(804,5),sigma(:,11:15));
% ShortCall6=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,11:15), q(:,3).*ones(804,5), rf(:,3).*ones(804,5), Tiempo(:,3).*ones(804,5),sigma(:,11:15));
% LongCall26=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,11:15)+A, q(:,3).*ones(804,5), rf(:,3).*ones(804,5), Tiempo(:,3).*ones(804,5),sigma(:,11:15));
% Butterfly6=LongCall16-2.*ShortCall6+LongCall26;
% %%
% % Butterfly 9
% A=0.1;
% LongCall19=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,16:20)-A, q(:,4).*ones(804,5), rf(:,4).*ones(804,5), Tiempo(:,4).*ones(804,5),sigma(:,16:20));
% ShortCall9=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,16:20), q(:,4).*ones(804,5), rf(:,4).*ones(804,5), Tiempo(:,4).*ones(804,5),sigma(:,16:20));
% LongCall29=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,16:20)+A, q(:,4).*ones(804,5), rf(:,4).*ones(804,5), Tiempo(:,4).*ones(804,5),sigma(:,16:20));
% Butterfly9=LongCall19-2.*ShortCall9+LongCall29;
% %%
% % Butterfly 12
% A=0.07;
% LongCall112=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,21:25)-A, q(:,5).*ones(804,5), rf(:,5).*ones(804,5), Tiempo(:,5).*ones(804,5),sigma(:,21:25));
% ShortCall12=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,21:25), q(:,5).*ones(804,5), rf(:,5).*ones(804,5), Tiempo(:,5).*ones(804,5),sigma(:,21:25));
% LongCall212=BlackScholes(1.*ones(804,5), Spot.*ones(804,5),Strike(:,21:25)+A, q(:,5).*ones(804,5), rf(:,5).*ones(804,5), Tiempo(:,5).*ones(804,5),sigma(:,21:25));
% Butterfly12=LongCall112-2.*ShortCall12+LongCall212;
% %%
