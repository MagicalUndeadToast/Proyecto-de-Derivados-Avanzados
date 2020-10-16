function [parametros,SigmaEmpirico,tfinal,tpromedio] = ...
    DBDCalibration(Sigma,Spot,Strike,r,q,Tiempo,x0,opcion,finicial,ffinal)
%DBDCalibration Esta funcion tiene como objetivo realizar la calibracion
%dia a dia para el modelo.
%   Funcion que calcula el modelo dia a dia, asi como tambien devuelve los
%   resultados del primer dia en caso de ser especificados.
switch opcion
    case{'Primer Dia'}
        tic;
        fun=@(x)AuxFinale(Sigma,Spot,Strike,r,q,Tiempo,...
            x(1),x(2),x(3),x(4),x(5),1); %#ok<*NODEF>
        lb = [0, 0, 0, 0, -.9]; %#ok<*NASGU>
        ub = [1, 100, 1, .5, .9];
        options = optimoptions('fmincon','Display','none');
        x = fmincon(fun,x0,[],[],[],[],lb,ub,[],options);
        vt=x(1);
        theta=x(2);
        w=x(3);
        sig=x(4);
        rho=x(5);
        psi=x(2)*x(3);
        x0=x;
        parametros(1,1)=x(1);
        parametros(1,2)=x(2);
        parametros(1,3)=x(3);
        parametros(1,4)=x(4);
        parametros(1,5)=x(5);
        parametros(1,6)=x(2)*x(3);
        SigmaEmpirico(1,:)=FuncionAux...
            (Spot,Strike,r,q,Tiempo,x(1),x(2),x(3),x(4),x(5),1);
        tfinal=toc;
        tpromedio=tfinal/1;
    case{'Fechas'}
        tic;
        for i=finicial:ffinal
            if i==finicial
                fun=@(x)AuxFinale(Sigma,Spot,Strike,r,q,Tiempo,...
                    x(1),x(2),x(3),x(4),x(5),finicial); %#ok<*NODEF>
                lb = [0, 0, 0, 0, -.9]; %#ok<*NASGU>
                ub = [1, 100, 1, .5, .9];
                options = optimoptions('fmincon','Display','none');
                x = fmincon(fun,x0,[],[],[],[],lb,ub,[],options);
                vt=x(1);
                theta=x(2);
                w=x(3);
                sig=x(4);
                rho=x(5);
                psi=x(2)*x(3);
                x0=x;
                parametros(finicial,1)=x(1);
                parametros(finicial,2)=x(2);
                parametros(finicial,3)=x(3);
                parametros(finicial,4)=x(4);
                parametros(finicial,5)=x(5);
                parametros(finicial,6)=x(2)*x(3);
                SigmaEmpirico=FuncionAux...
                    (Spot,Strike,r,q,Tiempo,x(1),x(2),x(3),x(4),x(5),finicial);
            end
            if i>finicial
                fun=@(x)AuxFinale(Sigma,Spot,Strike,r,q,Tiempo,...
                    x(1),x(2),x(3),x(4),x(5),i); %#ok<*NODEF>
                lb = [0, 0, 0, 0, -.9]; %#ok<*NASGU>
                ub = [1, 100, 1, .5, .9];
                options = optimoptions('fmincon','Display','none');
                x = fmincon(fun,x0,[],[],[],[],lb,ub,[],options);
                vt=x(1);
                theta=x(2);
                w=x(3);
                sig=x(4);
                rho=x(5);
                psi=x(2)*x(3);
                x0=x;
                parametros(i,1)=x(1); %#ok<*AGROW>
                parametros(i,2)=x(2);
                parametros(i,3)=x(3);
                parametros(i,4)=x(4);
                parametros(i,5)=x(5);
                parametros(i,6)=x(2)*x(3);
                SigmaEmpirico=FuncionAux...
                    (Spot,Strike,r,q,Tiempo,x(1),x(2),x(3),x(4),x(5),i);
            end
            
        end
        tfinal=toc;
        tpromedio=tfinal/i;
    case{'Completo'}
        tic;
        for i=1:length(Spot)
            if i==1
                fun=@(x)AuxFinale(Sigma,Spot,Strike,r,q,Tiempo,...
                    x(1),x(2),x(3),x(4),x(5),1); %#ok<*NODEF>
                lb = [0, 0, 0, 0, -.9]; %#ok<*NASGU>
                ub = [1, 100, 1, .5, .9];
                options = optimoptions('fmincon','Display','none');
                x = fmincon(fun,x0,[],[],[],[],lb,ub,[],options);
                vt=x(1);
                theta=x(2);
                w=x(3);
                sig=x(4);
                rho=x(5);
                psi=x(2)*x(3);
                x0=x;
                parametros(1,1)=x(1);
                parametros(1,2)=x(2);
                parametros(1,3)=x(3);
                parametros(1,4)=x(4);
                parametros(1,5)=x(5);
                parametros(1,6)=x(2)*x(3);
                SigmaEmpirico=FuncionAux...
                    (Spot,Strike,r,q,Tiempo,x(1),x(2),x(3),x(4),x(5),1);
            end
            if i>1
                fun=@(x)AuxFinale(Sigma,Spot,Strike,r,q,Tiempo,...
                    x(1),x(2),x(3),x(4),x(5),i); %#ok<*NODEF>
                lb = [0, 0, 0, 0, -.9]; %#ok<*NASGU>
                ub = [1, 100, 1, .5, .9];
                options = optimoptions('fmincon','Display','none');
                x = fmincon(fun,x0,[],[],[],[],lb,ub,[],options);
                vt=x(1);
                theta=x(2);
                w=x(3);
                sig=x(4);
                rho=x(5);
                psi=x(2)*x(3);
                x0=x;
                parametros(i,1)=x(1); %#ok<*AGROW>
                parametros(i,2)=x(2);
                parametros(i,3)=x(3);
                parametros(i,4)=x(4);
                parametros(i,5)=x(5);
                parametros(i,6)=x(2)*x(3);
                SigmaEmpirico=FuncionAux...
                    (Spot,Strike,r,q,Tiempo,x(1),x(2),x(3),x(4),x(5),i);
            end
        end
        tfinal=toc;
        tpromedio=tfinal/i;
    otherwise
        fprint('Posiblemente exista un error');
end
end

