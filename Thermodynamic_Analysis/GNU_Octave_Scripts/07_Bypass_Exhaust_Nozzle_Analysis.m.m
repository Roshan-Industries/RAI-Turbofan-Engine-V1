clear;
clc;
close all;

%% BYPASS EXHAUST NOZZLE ANALYSIS

% Fan inlet conditions
Tt2 = 288.15;             % K
Pt2 = 101.325e3;          % Pa

% Assumed fan performance
fan_pressure_ratio = 1.60;
Wfan = 50e3;              % J/kg

% Ambient conditions
P0 = 101.325e3;           % Pa
V0 = 0.0;                 % m/s

% Bypass mass flow
mdot_bypass = 100.0;      % kg/s

% Gas properties and nozzle efficiency
gamma = 1.4;
Cp = 1005;                % J/(kg K)
eta_n = 0.95;

%% Fan-exit / bypass-nozzle inlet conditions

Pt13 = Pt2 * fan_pressure_ratio;
Tt13 = Tt2 + Wfan / Cp;

%% Nozzle pressure ratios

NPR_bypass = Pt13 / P0;

critical_static_ratio = ...
    (2 / (gamma + 1))^(gamma / (gamma - 1));

ambient_total_ratio = P0 / Pt13;

%% Determine choking condition

if ambient_total_ratio <= critical_static_ratio

    nozzle_choked = true;

    Pe_bypass = Pt13 * critical_static_ratio;
    Tes_bypass = Tt13 * (2 / (gamma + 1));

else

    nozzle_choked = false;

    Pe_bypass = P0;

    Tes_bypass = Tt13 * ...
        (Pe_bypass / Pt13)^((gamma - 1) / gamma);

end

%% Actual exit temperature

Te_bypass = Tt13 - eta_n * (Tt13 - Tes_bypass);

%% Exit velocity

Ve_bypass = sqrt(2 * Cp * (Tt13 - Te_bypass));

%% Momentum thrust

F_bypass_momentum = ...
    mdot_bypass * (Ve_bypass - V0);

%% Pressure thrust

if nozzle_choked
    F_bypass_pressure = NaN;
else
    F_bypass_pressure = 0;
end

%% Total bypass thrust

F_bypass = F_bypass_momentum + F_bypass_pressure;

%% Display results

fprintf('\n');
fprintf('BYPASS EXHAUST NOZZLE ANALYSIS\n');
fprintf('----------------------------------------\n');

fprintf('Fan inlet temperature      : %.2f K\n', Tt2);
fprintf('Fan exit temperature       : %.2f K\n', Tt13);
fprintf('Fan inlet pressure         : %.2f kPa\n', Pt2 / 1000);
fprintf('Fan exit pressure          : %.2f kPa\n', Pt13 / 1000);
fprintf('Bypass nozzle pressure ratio: %.4f\n', NPR_bypass);
fprintf('P0 / Pt13                  : %.4f\n', ambient_total_ratio);
fprintf('Critical pressure ratio    : %.4f\n', critical_static_ratio);

if nozzle_choked
    fprintf('Nozzle condition           : CHOKED\n');
else
    fprintf('Nozzle condition           : NOT CHOKED\n');
end

fprintf('Exit static pressure       : %.2f kPa\n', ...
    Pe_bypass / 1000);
fprintf('Ideal exit temperature     : %.2f K\n', ...
    Tes_bypass);
fprintf('Actual exit temperature    : %.2f K\n', ...
    Te_bypass);
fprintf('Bypass exit velocity       : %.2f m/s\n', ...
    Ve_bypass);
fprintf('Bypass momentum thrust     : %.2f N\n', ...
    F_bypass_momentum);
fprintf('Bypass pressure thrust     : %.2f N\n', ...
    F_bypass_pressure);
fprintf('Total bypass thrust        : %.2f N\n', ...
    F_bypass);
