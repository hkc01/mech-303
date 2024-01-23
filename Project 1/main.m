close all; clear, clc

% Geomertic properties
b= 40e-3; % m
L= 120e-3; % m
t= 5e-3; % m

% Boundary conditions
F= 2e3; % N

% Analytical fit coefficients
AC= [-1.527 3.667 -3.14 3];


% Simulation results
d= 2*[1:12]*1e-3; % m
sigma_max= [27.534 28.979 29.792 30.644 31.697 32.948 34.262 36.074 38.066 40.694 43.993 48.184]*1e6; % The maximum stress vector

sigma_nom= F./((b-d).*t); % The nominal stress vector

d_b= d./b;
Kt= sigma_max./sigma_nom;

plot(d_b, Kt, "b o", DisplayName= "ANSYS data")
grid, axis([0 0.6 1 7])
xlabel("d/b"), ylabel("K_t")
title("Plate with Central Hole")


[xData, yData] = prepareCurveData(d_b(2:end), Kt(2:end)); % 

ft = fittype('poly3'); % third order polynomial fit
%ft = fittype('exp1'); % first order exponential fit

[fitresult, gof] = fit(xData, yData, ft);
C= coeffvalues(fitresult); % fit coefficients

Xfit= 0:1e-3:0.6; 
Yfit= C(1)*Xfit.^3 + C(2)*Xfit.^2 + C(3)*Xfit + C(4); % third order polynomial fit R2= 0.99991

%Yfit= C(1)*exp(C(2)*Xfit); % first order exponential fit R2= 0.99942

YAfit= polyval(AC, Xfit);


hold on;
plot(Xfit, YAfit, "b-", DisplayName= "Analytical Solution")
plot(Xfit, Yfit, "r-", DisplayName= ["Poly-3 fit | R^2= "+ gof.rsquare])
legend()
