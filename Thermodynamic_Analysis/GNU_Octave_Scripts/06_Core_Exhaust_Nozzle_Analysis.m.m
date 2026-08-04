clear;
clc;
close all;

%% CORE EXHAUST NOZZLE ANALYSIS

% Nozzle inlet conditions from LPT analysis
Tt5 = 637.39;           % K
Pt5 = 161.73e3;         % Pa

% Ambient conditions
P0 = 101.325e3;         % Pa
V0 = 0.0;               % m/s

% Core-gas mass flow
mdot_gas = 20.329;      % kg/s

% Gas properties and nozzle efficiency
gamma = 1.4;
Cp = 1005;              % J/(kg K)
eta_n = 0.95;

%% Nozzle pressure ratios

NPR = Pt5 / P0;

critical_static_ratio = ...
    (2 / (gamma + 1))^(gamma / (gamma - 1));

ambient_total_ratio = P0 / Pt5;

%% Determine whether nozzle is choked

if ambient_total_ratio <= critical_static_ratio

    nozzle_choked = true;

    % Choked exit conditions
    Pe = Pt5 * critical_static_ratio;

    Tes = Tt5 * (2 / (gamma + 1));

else

    nozzle_choked = false;

    % Unchoked nozzle expands to ambient pressure
    Pe = P0;

    Tes = Tt5 * (Pe / Pt5)^((gamma - 1) / gamma);

end

%% Actual exit temperature

Te = Tt5 - eta_n * (Tt5 - Tes);

%% Exit velocity

Ve = sqrt(2 * Cp * (Tt5 - Te));

%% Momentum thrust

F_momentum = mdot_gas * (Ve - V0);

%% Pressure thrust

% Exit area is not required for the current unchoked,
% perfectly expanded condition because Pe = P0.

if nozzle_choked
    F_pressure = NaN;
else
    F_pressure = 0;
end

%% Total core thrust

F_core = F_momentum + F_pressure;

%% Display results

fprintf('\n');
fprintf('CORE EXHAUST NOZZLE ANALYSIS\n');
fprintf('--------------------------------------\n');

fprintf('Nozzle inlet temperature : %.2f K\n', Tt5);
fprintf('Nozzle inlet pressure    : %.2f kPa\n', Pt5 / 1000);
fprintf('Ambient pressure         : %.2f kPa\n', P0 / 1000);
fprintf('Nozzle pressure ratio    : %.4f\n', NPR);
fprintf('P0 / Pt5                 : %.4f\n', ambient_total_ratio);
fprintf('Critical pressure ratio  : %.4f\n', critical_static_ratio);

if nozzle_choked
    fprintf('Nozzle condition         : CHOKED\n');
else
    fprintf('Nozzle condition         : NOT CHOKED\n');
end

fprintf('Exit static pressure     : %.2f kPa\n', Pe / 1000);
fprintf('Ideal exit temperature   : %.2f K\n', Tes);
fprintf('Actual exit temperature  : %.2f K\n', Te);
fprintf('Core exit velocity       : %.2f m/s\n', Ve);
fprintf('Momentum thrust          : %.2f N\n', F_momentum);
fprintf('Pressure thrust          : %.2f N\n', F_pressure);
fprintf('Total core thrust        : %.2f N\n', F_core);
