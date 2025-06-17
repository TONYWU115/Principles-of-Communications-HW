A = 1;
maxLag = 10;

R_theoretical = zeros(1, 2*maxLag+1);
m = -maxLag:maxLag;

for k = -maxLag:maxLag
    if k == 0
        R_theoretical(k + maxLag + 1) = 0.5 * A^2;
    elseif abs(k) == 1
        R_theoretical(k + maxLag + 1) = -0.25 * A^2;
    else
        R_theoretical(k + maxLag + 1) = 0;
    end
end

stem(m, R_theoretical, 'r', 'filled');
xlabel('m');
ylabel('R_m');
grid on;
