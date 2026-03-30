function gen_rough2_point()

N = 65;

rng(7);

W = randn(N, N);

Lc = 1.6;  

rad = ceil(3*Lc);
[xk, yk] = meshgrid(-rad:rad, -rad:rad);
K = exp(-(xk.^2 + yk.^2)/(2*Lc^2));
K = K / sum(K(:));


R = conv2(W, K, 'same');


spike_ratio = 0.06;            
num_spike = max(1, round(spike_ratio * N * N));
idx = randperm(N*N, num_spike);
R(idx) = R(idx) + 3.0*randn(1, num_spike);   


Lc2 = 0.8;
rad2 = ceil(3*Lc2);
[xk2, yk2] = meshgrid(-rad2:rad2, -rad2:rad2);
K2 = exp(-(xk2.^2 + yk2.^2)/(2*Lc2^2));
K2 = K2 / sum(K2(:));
R = conv2(R, K2, 'same');

R = (R - mean(R(:))) / std(R(:));  
R = 0.55 + 0.35 * R;              
R(R >  1.5) =  1.5;
R(R < -0.5) = -0.5;

fid = fopen('ROUGH2.DAT','w');
for I = 1:N
    for J = 1:N
        fprintf(fid, ' %10.6f\n', R(I,J));
    end
end
fclose(fid);

disp('ROUGH2.DAT 已生成（当前工作目录下）。');
end
