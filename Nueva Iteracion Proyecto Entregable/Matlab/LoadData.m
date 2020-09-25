function [Spot,RDiscount,QDiscount,Forward,Sigma,SigmaRR,Strike,T,OptionValue,Date] = LoadData()
%Oculta inicialmente el codigo de la carga de datos para que se vea mas
%amigable en un inicio, incluye todos los datos 
%   Simplemente carga los datos que ya tenemos para poder utilizarlos con
%   posterioridad.
Spot = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Spot');
RDiscount = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Domestic Discount Factor');
QDiscount = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Foreign Discount Factor');
Forward = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Forward');
Sigma = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Vols');
SigmaRR = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Vols RR & BFY');
Strike = xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Strikes');
T=xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Working Days');
OptionValue=xlsread('Data Fitting a quantitative model onto a market smile GBP-USD','Option Value');
%FormatOut='mm/dd/yy';
Aux=xlsread('Data Fitting a quantitative model onto a market smile GBP-USD.xlsx','Forward','A2:A806','basic');
Date=x2mdate(Aux,0,'datetime');
end

