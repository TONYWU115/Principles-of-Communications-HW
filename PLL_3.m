clear; close all; clc;

fdel = 100;          % 頻率階躍大小 (Hz)
fn = 10;             % 第二階自然頻率 (Hz)
zeta = 0.707;        % 阻尼係數

Kp1 = 1.0;           % 第一階比例增益
Kp2 = 100;           % 第二階比例增益
Ki2 = 1e4;           % 第二階積分增益

npts = 2000;
fs = 2000;
T = 1/fs;
t = (0:(npts-1)) * T;
nsettle = fix(npts / 10);

fin = zeros(1,npts);
fvco = zeros(1,npts);
phierror = zeros(1,npts);
freqerror = zeros(1,npts);

vco_phase = 0;
vco_phase_last = 0;
vco_input_last = 0;

int_stage2 = 0;

for i = 1:npts
    if i < nsettle
        fin(i) = 0;
        phase_input = 0;
    else
        fin(i) = fdel;
        phase_input = 2*pi*fdel*T*(i - nsettle);
    end

    phase_err = phase_input - vco_phase;
    pd_output = sin(phase_err);

    stage1_output = Kp1 * pd_output;

    int_stage2 = int_stage2 + Ki2 * stage1_output * T;
    stage2_output = Kp2 * stage1_output + int_stage2;

    vco_input = stage2_output;
    vco_phase = vco_phase_last + (T/2) * (vco_input + vco_input_last);

    vco_input_last = vco_input;
    vco_phase_last = vco_phase;

    phierror(i) = phase_err;
    fvco(i) = vco_input / (2*pi);
    freqerror(i) = fin(i) - fvco(i);
end

figure;
plot(t, fin, 'b', t, fvco, 'r');
title('Input Frequency vs VCO Output Frequency');
xlabel('Time (s)');
ylabel('Frequency (Hz)');
legend('Input Frequency', 'VCO Output');
grid on;

figure;
plot(phierror / (2*pi), freqerror, 'k');
title('Phase Plane (Phase Error vs Frequency Error)');
xlabel('Phase Error / 2\pi');
ylabel('Frequency Error (Hz)');
grid on;
