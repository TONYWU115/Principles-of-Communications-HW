f1 = 1;          % 訊息信號的基頻
fs = 100;        % 取樣頻率
T = 5;
t = 0:1/fs:T;
fc = 10;        % 載波頻率

mt = cos(2*pi*f1*t) - 0.4*cos(4*pi*f1*t) + 0.9*cos(6*pi*f1*t);

order = 50;
half_order = floor(order/2);
impulse_response = zeros(1, order+1);
for n = 1:order+1
    if n ~= half_order + 1
        impulse_response(n) = 1/(pi*(n - (half_order + 1)));
    end
end

N = order + 1;
window = 0.54 - 0.46 * cos(2*pi*(0:N-1)/(N-1));
h_fir = impulse_response .* window;
m_hat_t_approx = conv(mt, h_fir, 'same');

envelope = abs(mt);

usb_ssb_approx = mt.*cos(2*pi*fc*t) - m_hat_t_approx.*sin(2*pi*fc*t);

lsb_ssb_approx = mt.*cos(2*pi*fc*t) + m_hat_t_approx.*sin(2*pi*fc*t);

figure;

subplot(5,1,1);
plot(t, mt);
xlabel('時間 (秒)');
ylabel('m(t)');
title('(a) 訊息信號');
grid on;

subplot(5,1,2);
plot(t, m_hat_t_approx);
xlabel('時間 (秒)');
ylabel('$\hat{m}(t)_{approx}$', 'Interpreter','latex');
title('(b) 希爾伯特轉換');
grid on;

subplot(5,1,3);
plot(t, envelope);
xlabel('時間 (秒)');
ylabel('|m(t)|');
title('(c) SSB 信號的包絡');
grid on;

subplot(5,1,4);
plot(t, usb_ssb_approx);
xlabel('時間 (秒)');
ylabel('USB-SSB(t)_{approx}');
title('(d) 近似上邊帶 SSB 信號');
grid on;

subplot(5,1,5);
plot(t, lsb_ssb_approx);
xlabel('時間 (秒)');
ylabel('LSB-SSB(t)_{approx}');
title('(e) 近似下邊帶 SSB 信號');
grid on;

sgtitle('單邊帶 (SSB) 系統的時域信號');