clear;
clc;
close all;

%% Compressor Inputs

Pt25 = 160000;      % Pa
Tt25 = 330;         % K

pi_c = 12;

eta_c = 0.86;

gamma = 1.4;
Cp = 1005;

mdot_core = 20;

%% Compressor Exit Pressure

Pt3 = Pt25*pi_c;

%% Ideal Temperature

Tt3s = Tt25*pi_c^((gamma-1)/gamma);

%% Actual Temperature

Tt3 = Tt25 + (Tt3s-Tt25)/eta_c;

%% Compressor Work

Wc = Cp*(Tt3-Tt25);

%% Compressor Power

Pc = mdot_core*Wc;

%% Results

fprintf("\n");
fprintf("COMPRESSOR ANALYSIS\n");
fprintf("-------------------------\n");
fprintf("Inlet Pressure : %.2f kPa\n",Pt25/1000);
fprintf("Exit Pressure  : %.2f kPa\n",Pt3/1000);
fprintf("Inlet Temp     : %.2f K\n",Tt25);
fprintf("Exit Temp      : %.2f K\n",Tt3);
fprintf("Specific Work  : %.2f kJ/kg\n",Wc/1000);
fprintf("Power Required : %.2f MW\n",Pc/1e6);
