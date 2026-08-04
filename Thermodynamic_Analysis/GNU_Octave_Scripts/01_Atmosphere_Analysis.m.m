clear;
clc;
close all;

%% Atmospheric Conditions

T0 = 288.15;      % K
P0 = 101325;      % Pa
gamma = 1.4;
R = 287;

Mach = 0.0;

%% Speed of sound

a = sqrt(gamma*R*T0);

%% Flight velocity

V0 = Mach*a;

%% Total conditions

Tt0 = T0*(1+((gamma-1)/2)*Mach^2);

Pt0 = P0*(1+((gamma-1)/2)*Mach^2)^(gamma/(gamma-1));

%% Display Results

fprintf("\n");
fprintf("Atmospheric Conditions\n");
fprintf("----------------------\n");
fprintf("Ambient Temperature : %.2f K\n",T0);
fprintf("Ambient Pressure    : %.2f Pa\n",P0);
fprintf("Speed of Sound      : %.2f m/s\n",a);
fprintf("Flight Velocity     : %.2f m/s\n",V0);
fprintf("Total Temperature   : %.2f K\n",Tt0);
fprintf("Total Pressure      : %.2f Pa\n",Pt0);
