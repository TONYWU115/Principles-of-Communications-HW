x = 0:0.1:20;

n1 = 0;
n2 = 1;
n3 = 2;

y1 = besselj(n1, x);
y2 = besselj(n2, x);
y3 = besselj(n3, x);

plot(x, y1, 'b-', x, y2, 'r--', x, y3, 'g-.');
xlabel('x');
ylabel('J_n(x)');
title('Bessel 函數');
legend(['J_' num2str(n1)], ['J_' num2str(n2)], ['J_' num2str(n3)]);
grid on;