function [RowSigmaError,RowPriceError]=ErroresData()
Sigma = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Vols');
Sigma=Sigma/100;
OptionValue=xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Option Value');
OptionValue(1,:)=[];
SigmaEmpiricoCP=xlsread('SigmaEmpiricoCPFinal','Hoja1');
OptionValueEmpiricoCP=xlsread('OptionValueEmpiricoCPFinal','Hoja1');

SigmaError=ErrorPromedio(SigmaEmpiricoCP,Sigma);
PriceError=ErrorPromedio(OptionValueEmpiricoCP,OptionValue);
SigmaPercentError=ErrorPromedioPorcentual(SigmaEmpiricoCP,Sigma);
PriceErrorPercent=ErrorPromedioPorcentual(OptionValueEmpiricoCP,OptionValue);
RowSigmaError=ErrorFila(SigmaEmpiricoCP,Sigma);
RowPriceError=ErrorFila(OptionValueEmpiricoCP,OptionValue);

disp("El error promedio de las volatilidades es de: "+SigmaError)
disp("El error promedio porcentual de las volatilidades es de: "+SigmaPercentError+"%")
disp("El error promedio del precio es de: "+PriceError)
disp("El error promedio porcentual de los precios es de: "+PriceErrorPercent+"%")


end
