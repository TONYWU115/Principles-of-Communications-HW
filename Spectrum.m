A = 1;
f0 = 1;
N = 5;

freq = (-N:N) * f0;

amplitude = zeros(size(freq));
phase = zeros(size(freq));

for n = -N:N
    if n == 0
        amplitude(n + N + 1) = A / pi;
    elseif abs(n) == 1
        amplitude(n + N + 1) = A / 4;
    elseif abs(n) == 2
        amplitude(n + N + 1) = A / (3 * pi);
    elseif abs(n) == 4
        amplitude(n + N + 1) = A / (15 * pi);
    end
end

for n = -N:N
    if n == 1
        phase(n + N + 1) = -pi / 2; % f0
    elseif n == 2
        phase(n + N + 1) = -pi; % 2f0
    elseif n == 4
        phase(n + N + 1) = -pi; % 4f0
    elseif n == -1
        phase(n + N + 1) = pi / 2; % -f0
    elseif n == -2
        phase(n + N + 1) = pi; % -2f0
    elseif n == -4
        phase(n + N + 1) = pi; % -4f0
    end
end

figure;

subplot(2, 1, 1);
stem(freq, amplitude, 'b', 'LineWidth', 1.5);
title('Amplitude, |X_n|');
xlabel('Frequency (rad/s): f_0');
ylabel('Amplitude(A)');
grid on;
xlim([-N*f0 N*f0]);
ylim([0 max(amplitude)*1.2])

xticks((-N:N)*f0);
xticklabels({'-5f_0', '-4f_0', '-3f_0', '-2f_0', '-f_0', '0', 'f_0', '2f_0', '3f_0', '4f_0', '5f_0', 'nf_0'});

for i = 1:length(freq)
    if amplitude(i) > 0
        if freq(i) == 0
            text(freq(i), amplitude(i), 'A/\pi', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'b');
        elseif abs(freq(i)) == 1
            text(freq(i), amplitude(i), 'A/4', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'b');
        elseif abs(freq(i)) == 2
            text(freq(i), amplitude(i), 'A/3\pi', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'b');
        elseif abs(freq(i)) == 4
            text(freq(i), amplitude(i), 'A/15\pi', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'b');
        end
    end
end

subplot(2, 1, 2);
stem(freq, phase, 'r', 'LineWidth', 1.5);
title('Phase (rad): \angle X_n');
xlabel('Frequency (rad/s): f_0');
ylabel('Phase (rad)');
grid on;
xlim([-N*f0 N*f0]);

xticks((-N:N)*f0);
xticklabels({'-5f_0', '-4f_0', '-3f_0', '-2f_0', '-f_0', '0', 'f_0', '2f_0', '3f_0', '4f_0', '5f_0', 'nf_0'});

yticks([-pi -pi/2 0 pi/2 pi]);
yticklabels({'-\pi', '-\pi/2', '0', '\pi/2', '\pi'});

for i = 1:length(freq)
    if phase(i) ~= 0
        if abs(phase(i)) == pi
            if phase(i) > 0
                text(freq(i), phase(i), '\pi', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'r');
            else
                text(freq(i), phase(i), '-\pi', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'center', 'Color', 'r');
            end
        elseif abs(phase(i)) == pi/2
            if phase(i) > 0
                text(freq(i), phase(i), '\pi/2', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'r');
            else
                text(freq(i), phase(i), '-\pi/2', 'VerticalAlignment', 'top', 'HorizontalAlignment', 'center', 'Color', 'r');
            end
        end
    end
end

set(gcf, 'Position', [100, 100, 800, 600]);