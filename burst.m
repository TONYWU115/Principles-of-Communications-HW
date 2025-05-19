fs = 10000;
T = 0.1;
f = 200;
cycles_per_burst = 4;
gap_time = 0.01;

t = 0:1/fs:T-1/fs;
burst_signal = zeros(size(t));

burst_duration = cycles_per_burst / f;

for i = 1:length(t)
    if mod(t(i), burst_duration + gap_time) < burst_duration
        burst_signal(i) = sin(2 * pi * f * t(i));
    end
end

plot(t, burst_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Four-Burst Signal');
grid on;
