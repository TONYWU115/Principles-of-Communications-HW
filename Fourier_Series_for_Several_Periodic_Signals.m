clc; clear;

N = 10;
n = -N:N;
A = 1;

% 1. Asymmetrical Pulse Train
T0_1 = 1;
t1 = linspace(0, T0_1, 1000);
tau = 0.3;
t0 = 0.1;
x1 = ((t1 - t0) >= 0 & (t1 - t0) < tau);
Xn1 = (tau / T0_1) * sinc(n * tau) .* exp(-1j * 2 * pi * n * t0 / T0_1);

% 2. Half-Rectified Sinewave
T0_2 = 2 * pi;
t2 = linspace(-T0_2, T0_2, 1000);
x2 = A * sin(t2) .* (mod(t2, T0_2) >= 0 & mod(t2, T0_2) <= T0_2/2);
Xn2 = zeros(size(n));
for i = 1:length(n)
    ni = n(i);
    if ni == 0 || mod(ni, 2) == 0
        Xn2(i) = A / (pi * (1 - ni^2));
    elseif abs(ni) == 1
        Xn2(i) = -1j * A / 4;
    end
end

% 3. Full-Rectified Sinewave
T0_3 = pi;
t3 = linspace(0, 2*T0_3, 1000);
x3 = A * abs(sin(t3));
Xn3 = zeros(size(n));
for i = 1:length(n)
    ni = n(i);
    if (1 - 4*ni^2) ~= 0
        Xn3(i) = 2*A / (pi * (1 - 4*ni^2));
    end
end

% 4. Triangular Wave
T0_4 = 1;
t4 = linspace(-T0_4, T0_4, 1000);
x4 = zeros(size(t4));
tt = mod(t4, T0_4);
tt(tt > T0_4/2) = tt(tt > T0_4/2) - T0_4;
x4(tt <= 0) = (4*A/T0_4)*tt(tt <= 0) + A;
x4(tt > 0)  = (-4*A/T0_4)*tt(tt > 0) + A;
Xn4 = zeros(size(n));
for i = 1:length(n)
    ni = n(i);
    if mod(ni, 2) == 1 || mod(ni, 2) == -1
        Xn4(i) = 4*A / (pi^2 * ni^2);
    end
end

figure('Position', [100 100 1000 800])
subplot(4,2,1); plot(t1, x1, 'LineWidth', 1.2);
title('1. Asymmetrical Pulse Train'); grid on;

subplot(4,2,2); stem(n, abs(Xn1), 'filled');
title('|X_n| of Pulse Train'); grid on;

subplot(4,2,3); plot(t2, x2, 'LineWidth', 1.2);
title('2. Half-Rectified Sinewave'); grid on;

subplot(4,2,4); stem(n, abs(Xn2), 'filled');
title('|X_n| of Half-Rectified Sinewave'); grid on;

subplot(4,2,5); plot(t3, x3, 'LineWidth', 1.2);
title('3. Full-Rectified Sinewave'); grid on;

subplot(4,2,6); stem(n, abs(Xn3), 'filled');
title('|X_n| of Full-Rectified Sinewave'); grid on;

subplot(4,2,7); plot(t4, x4, 'LineWidth', 1.2);
title('4. Triangular Wave'); grid on;

subplot(4,2,8); stem(n, abs(Xn4), 'filled');
title('|X_n| of Triangular Wave'); grid on;
