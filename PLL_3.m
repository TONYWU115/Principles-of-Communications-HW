clear all

fdel = input('Enter frequency step size in Hz > ');     % 頻率步進大小 (Hz)
fn = input('Enter the loop natural frequency in Hz > '); % 迴路自然頻率 (Hz)
zeta = input('Enter zeta (loop damping factor) > ');    % 迴路阻尼係數

npts = 2000;
fs = 2000;
T = 1/fs;

t = (0:(npts-1))/fs;

nsettle = fix(npts/10);

Kt = 4*pi*zeta*fn; % 迴路增益
a = pi*fn/zeta;    % 二階濾波器參數
b = (pi*fn)^2;     % 三階積分器參數

filt_in_last = 0;
filt_out_last = 0;
filt2_out_last = 0;
vco_in_last = 0;
vco_out = 0;
vco_out_last = 0;

for i=1:npts
    if i < nsettle
        fin(i) = 0;
        phin(i) = 0;
    else
        fin(i) = fdel;
        phin(i) = 2*pi*fdel*T*(i-nsettle);
    end

    s1 = phin(i) - vco_out;
    s2 = sin(s1);
    s3 = Kt*s2;

    filt_in = a*s3;
    filt_out = filt_out_last + (T/2)*(filt_in + filt_in_last);
    filt_in_last = filt_in;
    filt_out_last = filt_out;

    filt2_in = b*s3;
    filt2_out = filt2_out_last + (T/2)*(filt2_in + filt2_out_last);
    filt2_out_last = filt2_out;

    vco_in = s3 + filt_out + filt2_out;
    vco_out = vco_out_last + (T/2)*(vco_in + vco_in_last);
    vco_in_last = vco_in;
    vco_out_last = vco_out;

    phierror(i) = s1;         % 相位誤差
    fvco(i) = vco_in/(2*pi);  % VCO輸出頻率
    freqerror(i) = fin(i)-fvco(i);
end

kk = 0;
while kk == 0
    k = menu('Phase Lock Loop Postprocessor',...
             'Input Frequency and VCO Frequency',...
             'Phase Plane Plot',...
             'Exit Program');

    if k == 1
        plot(t,fin,t,fvco);
        title('Input Frequency and VCO Frequency');
        xlabel('Time - Seconds');
        ylabel('Frequency - Hertz');
        pause;
    elseif k == 2
        plot(phierror/2/pi,freqerror);
        title('Phase Plane');
        xlabel('Phase Error / pi');
        ylabel('Frequency Error - Hz');
        pause;
    elseif k == 3
        kk = 1;
    end
end