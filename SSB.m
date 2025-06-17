%using signal processing toolbox
f1 = 1; 
t = -2:0.001:2; 

m_t = cos(2*pi*f1*t) - 0.4*cos(4*pi*f1*t) + 0.9*cos(6*pi*f1*t);
m_hilbert = imag(hilbert(m_t));
fc = 10 * max([f1, 2*f1, 3*f1]); 

envelope_ssb = abs(hilbert(m_t));
s_USB = m_t .* cos(2*pi*fc*t) - m_hilbert .* sin(2*pi*fc*t);
s_LSB = m_t .* cos(2*pi*fc*t) + m_hilbert .* sin(2*pi*fc*t);
%envelope_USB = abs(s_USB + 1i * hilbert(s_USB));

figure;

subplot(5,1,1);
plot(t, m_t);
title('Message signal m(t)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(5,1,2);
plot(t, m_hilbert);
title('Hilbert transform of the message signal.'); 
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(5,1,3);
plot(t, envelope_ssb);
title('Envelope of the SSB signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(5,1,4);
plot(t, s_USB);
hold on;
plot(t, m_t, 'r--');
title('Upper-sideband SSB signal with message signal.');
xlabel('Time (s)');
ylabel('Amplitude');
legend('s_{USB}(t)', 'm(t)');
grid on;
hold off;

subplot(5,1,5);
plot(t, s_LSB);
hold on;
plot(t, m_t, 'r--');
title('Lower-sideband SSB signal with message signal');
xlabel('Time (s)');
ylabel('Amplitude');
legend('s_{LSB}(t)', 'm(t)');
grid on;
hold off;

sgtitle('SSB');