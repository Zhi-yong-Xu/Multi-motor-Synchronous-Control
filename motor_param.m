%% The parameters about the FOC of BLDC (PMSM)
%  Copyright 2018 The MathWorks, Inc.

%% PMSM para

Jm = 0.1e-3;    % Rotor inertia [kg*m^2]
Dm = 1e-3;
Jm1 = 0.1e-3;    % Rotor inertia [kg*m^2]
Dm1 = 1e-3;
Jm2 = 0.1e-3;    % Rotor inertia [kg*m^2]
Dm2= 1e-3;
Jm3= 0.1e-3;    % Rotor inertia [kg*m^2]
Dm3 = 1e-3;
Jm4 = 0.1e-3;    % Rotor inertia [kg*m^2]
Dm4 = 1e-3;
Jm5 = 0.1e-3;    % Rotor inertia [kg*m^2]
Dm5 = 1e-3;

% PMSM1
Phi = 0.1;      % Permanent magnet flux linkage [Wb]
Ld = 0.01;      % Stator d-axis inductance [H]
Lq = 0.02;      % Stator q-axis inductance [H]
Rs = 0.38;      % Stator resistance per phase [Ω]
p = 2;          % Number of pole pairs
% Jm1 = 0.1e-3;    % Rotor inertia [kg*m^2]
% Dm1 = 1e-3;      % Rotor damping [N*m/(rad/s)]
% 
% % PMSM2
% Jm2 = 0.4e-3;    % Rotor inertia [kg*m^2]
% Dm2 = 2e-3;      % Rotor damping [N*m/(rad/s)]
% 
% % PMSM3
% Jm3 = 0.4e-3;    % Rotor inertia [kg*m^2]
% Dm3 = 2e-3;      % Rotor damping [N*m/(rad/s)]
% 
% 
% % PMSM4
% Jm4 = 0.2e-3;    % Rotor inertia [kg*m^2]
% Dm4 = 1e-3;      % Rotor damping [N*m/(rad/s)]
% 
% 
% % PMSM5
% Jm5 = 0.2e-3;    % Rotor inertia [kg*m^2]
% Dm5 = 4e-3;      % Rotor damping [N*m/(rad/s)]




%% Inverter 
Vdc = 100;      % DC voltage [V]
fc = 10e3;      % Carrier Frequency [Hz]
Ts = 1/fc/100;  % Sampling time [sec]

%% Current controllers of dq-axis (PI controller)
%  Ld/Rs = 0.0263[sec];
%  Lq/Rs = 0.0526[sec];
%  Target response time constant: 1e-3[sec]
wc_c = 1e3;       % Target response frequency [rad/s]
Kp_id = wc_c*Ld;  % d-axis proportional gain
Ki_id = wc_c*Rs;  % d-axis integral gain
Kp_iq = wc_c*Lq;  % q-axis proportional gain
Ki_iq = wc_c*Rs;  % q-axis integral gain
% Tcc = 100e-6;     % Sample time of current control [sec]

%% Velocity controller (PI controller)
%  Jm/Dm = 0.1[sec];
%  Target response time constant: 0.02[sec]
wc_s = 50;        % Target response frequency [rad/s]
Kp_s = 0.0014;    % Velocity proportional gain
Ki_s = 0.041;     % Velocity integral gain
% Kp_s = wc_s*Jm;   % Velocity proportional gain
% Ki_s = wc_s*Dm;   % Velocity integral gain
% Tsc = 1e-3;       % Sample time of velocity control [sec]
