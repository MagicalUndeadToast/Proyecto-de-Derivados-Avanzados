function [ValoresObtenidos,SigmasObtenidos] = VolImpMC(Spot,r,q,Tiempo,Strike,ValorTeoricoMCBS,e)
%VolImpMC Nos permite separar el codigo del main code para poder
%identificar errores.
%   Esta funcion nos permite identificar errores, no sobrecargar
%   visualmente el main asi como hacer pruebas menores con el codigo.

% Indicamos el Accuracy para todo el documento.
Accuracy=0.00001;

% Partimos con un sigma de 0.05.
SigmaMCBS=0.15;
% Tenor de 1 mes.
for k=1:size(r,1)
    [ValoresObtenidos(k,1), SigmasObtenidos(k,1)]=VolBS2(Spot(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),Strike(k,1),ValorTeoricoMCBS(k,1),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 3 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,2), SigmasObtenidos(k,2)]=VolBS2(Spot(k,1),r(k,2)...
        ,q(k,2),Tiempo(k,2),Strike(k,1+5),ValorTeoricoMCBS(k,2),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 6 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,3), SigmasObtenidos(k,3)]=VolBS2(Spot(k,1),r(k,3)...
        ,q(k,3),Tiempo(k,3),Strike(k,1+10),ValorTeoricoMCBS(k,3),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 9 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,4), SigmasObtenidos(k,4)]=VolBS2(Spot(k,1),r(k,4)...
        ,q(k,4),Tiempo(k,4),Strike(k,1+15),ValorTeoricoMCBS(k,4),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 12 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,5), SigmasObtenidos(k,5)]=VolBS2(Spot(k,1),r(k,5)...
        ,q(k,5),Tiempo(k,5),Strike(k,1+20),ValorTeoricoMCBS(k,5),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Seguimos con un sigma de 0.1.
%SigmaMCBS=0.1;
% Tenor de 1 mes.
for k=1:size(r,1)
    [ValoresObtenidos(k,6), SigmasObtenidos(k,6)]=VolBS2(Spot(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),Strike(k,1),ValorTeoricoMCBS(k,6),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 3 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,7), SigmasObtenidos(k,7)]=VolBS2(Spot(k,1),r(k,2)...
        ,q(k,2),Tiempo(k,2),Strike(k,1+5),ValorTeoricoMCBS(k,7),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 6 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,8), SigmasObtenidos(k,8)]=VolBS2(Spot(k,1),r(k,3)...
        ,q(k,3),Tiempo(k,3),Strike(k,1+10),ValorTeoricoMCBS(k,8),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 9 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,9), SigmasObtenidos(k,9)]=VolBS2(Spot(k,1),r(k,4)...
        ,q(k,4),Tiempo(k,4),Strike(k,1+15),ValorTeoricoMCBS(k,9),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 12 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,10), SigmasObtenidos(k,10)]=VolBS2(Spot(k,1),r(k,5)...
        ,q(k,5),Tiempo(k,5),Strike(k,1+20),ValorTeoricoMCBS(k,10),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Seguimos con un sigma de 0.2.
%SigmaMCBS=0.2;
% Tenor de 1 mes.
for k=1:size(r,1)
    [ValoresObtenidos(k,11), SigmasObtenidos(k,11)]=VolBS2(Spot(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),Strike(k,1),ValorTeoricoMCBS(k,11),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 3 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,12), SigmasObtenidos(k,12)]=VolBS2(Spot(k,1),r(k,2)...
        ,q(k,2),Tiempo(k,2),Strike(k,1+5),ValorTeoricoMCBS(k,12),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 6 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,13), SigmasObtenidos(k,13)]=VolBS2(Spot(k,1),r(k,3)...
        ,q(k,3),Tiempo(k,3),Strike(k,1+10),ValorTeoricoMCBS(k,13),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 9 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,14), SigmasObtenidos(k,14)]=VolBS2(Spot(k,1),r(k,4)...
        ,q(k,4),Tiempo(k,4),Strike(k,1+15),ValorTeoricoMCBS(k,14),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 12 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,15), SigmasObtenidos(k,15)]=VolBS2(Spot(k,1),r(k,5)...
        ,q(k,5),Tiempo(k,5),Strike(k,1+20),ValorTeoricoMCBS(k,15),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Seguimos con un sigma de 0.5.
%SigmaMCBS=0.5;
% Tenor de 1 mes.
for k=1:size(r,1)
    [ValoresObtenidos(k,16), SigmasObtenidos(k,16)]=VolBS2(Spot(k,1),r(k,1)...
        ,q(k,1),Tiempo(k,1),Strike(k,1),ValorTeoricoMCBS(k,16),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 3 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,17), SigmasObtenidos(k,17)]=VolBS2(Spot(k,1),r(k,2)...
        ,q(k,2),Tiempo(k,2),Strike(k,1+5),ValorTeoricoMCBS(k,17),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 6 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,18), SigmasObtenidos(k,18)]=VolBS2(Spot(k,1),r(k,3)...
        ,q(k,3),Tiempo(k,3),Strike(k,1+10),ValorTeoricoMCBS(k,18),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 9 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,19), SigmasObtenidos(k,19)]=VolBS2(Spot(k,1),r(k,4)...
        ,q(k,4),Tiempo(k,4),Strike(k,1+15),ValorTeoricoMCBS(k,19),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
% Tenor de 12 meses.
for k=1:size(r,1)
    [ValoresObtenidos(k,20), SigmasObtenidos(k,20)]=VolBS2(Spot(k,1),r(k,5)...
        ,q(k,5),Tiempo(k,5),Strike(k,1+20),ValorTeoricoMCBS(k,20),SigmaMCBS...
        ,Accuracy,e); %#ok<*AGROW,*NASGU>                                              
end
end

