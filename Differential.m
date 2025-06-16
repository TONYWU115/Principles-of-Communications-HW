b_k = [1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 1, 0];

initial_a = 1; 

fprintf('原始輸入位元 b_k: ');
disp(b_k);

a_k = zeros(size(b_k));
current_a = initial_a;

for k = 1:length(b_k)
    a_k(k) = xor(b_k(k), current_a);
    current_a = a_k(k);
end

fprintf('差分編碼結果 a_k (使用初始值 %d): \n', initial_a);
disp(a_k);

received_a_k = a_k; 

decoded_b_k = zeros(size(received_a_k));
current_received_a = initial_a;

for k = 1:length(received_a_k)
    decoded_b_k(k) = xor(received_a_k(k), current_received_a);
    current_received_a = received_a_k(k);
end

fprintf('解碼後位元 b_k_hat: \n');
disp(decoded_b_k);

if isequal(b_k, decoded_b_k)
    disp('解碼成功，與原始輸入位元完全相同。');
else
    disp('解碼失敗，結果不符。');
end