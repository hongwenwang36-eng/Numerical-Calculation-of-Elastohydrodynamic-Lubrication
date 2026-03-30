function plot_fig143a()

    X0 = -4.0;
    XE =  1.0;
    N  = 200;     % 你画图用多少点就写多少点（需 <= 5000）
    % ---- 读文件----
    fid = fopen('ROUGH2.DAT','r');
    r = zeros(N,1);
    for i = 1:N
        val = fscanf(fid, '%f', 1);     % 每次读一个
        if isempty(val)
            fclose(fid);
            error('%s 行数不足：至少需要 %d 行。', fn, N);
        end
        r(i) = val;
    end
    fclose(fid);
    r(r < 0) = 0;
    r(r > 1) = 1;

    % ---- X 网格 ----
    x = linspace(X0, XE, N).';

    % ---- 作图----
    figure;
    plot(x, r, 'LineWidth', 2);  
    xlabel('X');
    ylabel('Roughness');
    xlim([X0, XE]);
    ylim([0, 1]);
end



