function plot_fig143b()
% Fig 14.3(b): Pressure distribution and film thickness


fname = 'OUT.DAT';
fid = fopen(fname, 'r');
if fid < 0
    error('Cannot open %s. Make sure it is in the current folder (pwd).', fname);
end

% 先读全部数字（忽略换行/空格）
A = fscanf(fid, '%f');
fclose(fid);

% 判定列数：优先 4 列（X P H ROU），否则 3 列（X P H）
if mod(numel(A), 4) == 0
    M = reshape(A, 4, []).';
    X = M(:,1);
    P = M(:,2);
    H = M(:,3);
elseif mod(numel(A), 3) == 0
    M = reshape(A, 3, []).';
    X = M(:,1);
    P = M(:,2);
    H = M(:,3);
else
    error('OUT.DAT column count not recognized. It should be 4 or 3 columns per row.');
end

% ---- 画图：P 和 H 同轴
figure;
plot(X, P, 'LineWidth', 1.8); hold on;
plot(X, H, 'LineWidth', 1.8);
hold off;

xlabel('X');
xlim([-4 1]);  
ylim([0 2]);   
legend('P', 'H', 'Location', 'best');
grid on;

end
