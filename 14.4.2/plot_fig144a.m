function plot_fig144a()
% 读取 ROUGH2.DAT 并绘制 Figure 14.4(a) 风格粗糙度图（点接触）

% ====== 与原文点接触程序一致参数 ======
N  = 65;
X0 = -2.5;
XE =  1.5;

DX = (XE - X0) / (N - 1.0);
Y0 = -0.5 * (XE - X0);

X = zeros(N,1);
Y = zeros(N,1);
for i = 1:N
    X(i) = X0 + (i-1)*DX;
    Y(i) = Y0 + (i-1)*DX;
end

% ====== 读 ROUGH2.DAT：按 Fortran 次序 I 外层，J 内层 ======
fid = fopen('ROUGH2.DAT','r');
if fid < 0
    error('找不到 ROUGH2.DAT。请先运行 gen_rough2_point，并确认当前工作目录。');
end

ROU = zeros(N,N);
for I = 1:N
    for J = 1:N
        val = fscanf(fid, '%f', 1);
        if isempty(val)
            fclose(fid);
            error('ROUGH2.DAT 数据不足：需要 N*N 行。');
        end
        ROU(I,J) = val;
    end
end
fclose(fid);

% ====== 画 3D 粗糙度 ======
[Xg, Yg] = meshgrid(X, Y);

figure;
surf(Xg, Yg, ROU');   
shading interp;
view(35, 20);
xlabel('X');
ylabel('Y');
zlabel('Roughness');


xlim([X0 XE]);
ylim([Y0 Y0 + (N-1)*DX]);
zlim([-0.5 1.5]);

grid on;
end
