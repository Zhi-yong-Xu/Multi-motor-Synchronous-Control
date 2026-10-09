%% The parameters about the FOC of BLDC (PMSM)
%  Copyright 2018 The MathWorks, Inc.

%% PMSM para


Jm = 0.1e-3;    % Rotor inertia [kg*m^2]
Dm = 1e-3;


% PMSM1
Phi = 0.1;      % Permanent magnet flux linkage [Wb]
Ld = 0.01;      % Stator d-axis inductance [H]
Lq = 0.02;      % Stator q-axis inductance [H]
Rs = 0.38;      % Stator resistance per phase [Ω]
p = 2;          % Number of pole pairs




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


%% graph
n =5;
A = diag(ones(n-1,1), 1) + diag(ones(n-1,1), -1);  % 邻接矩阵
D = diag(sum(A, 2)); 

L12 = -[0, 0, 0.5, 1, 0;
       0, 0.2, 1, 0.5,0;
       0.1,0.1,0,0, 0;
       0.2,0.1,0,1,0;
       0,0.1,0.1,0.2,0];
L21 = L12';

L11 = D +diag(sum(-L12,2))- A;  
L22 = D +diag(sum(-L21,2))- A; 
L = [L11];



%% couple

k_s = 0.2;
c_d = 0.05;
