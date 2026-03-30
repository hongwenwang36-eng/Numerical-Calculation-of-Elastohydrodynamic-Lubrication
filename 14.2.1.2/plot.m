function plot_fig141()
% Read OUT.DAT (columns: X, P, H), split by blocks (N=101), and plot.

    fname = 'OUT.DAT';
    if exist(fname, 'file') ~= 2
        error(['Cannot find OUT.DAT in current folder: ', pwd]);
    end

    M = readmatrix(fname);
    if size(M,2) < 3
        error('OUT.DAT must have at least 3 columns: X, P, H.');
    end

    Xcol = M(:,1);
    Pcol = M(:,2);
    Hcol = M(:,3);

    N = 101;  % must match main code

    totalRows = numel(Xcol);
    if mod(totalRows, N) ~= 0
        error('Row count is not a multiple of N=101. Check OUT.DAT.');
    end

    nDA = totalRows / N;

    % Set DA list (adjust order if your output order differs)
    DA_list = [0, 0.05, 0.10, 0.15];

    % Determine how many blocks to plot
    nPlot = nDA;
    if numel(DA_list) ~= nDA
        nPlot = min(nDA, numel(DA_list));
        disp('Warning: number of blocks in OUT.DAT does not match DA_list length.');
        disp(['Detected blocks: ', num2str(nDA), ', DA_list length: ', num2str(numel(DA_list))]);
        disp(['Plotting first ', num2str(nPlot), ' blocks only.']);
    end

    % Reshape into N-by-nDA
    P_all = reshape(Pcol, [N, nDA]);
    H_all = reshape(Hcol, [N, nDA]);
    X = Xcol(1:N);

    figure;
    hold on;
    box on;

    % Pressure: solid
    for k = 1:nPlot
        plot(X, P_all(:,k), 'LineWidth', 1.5);
    end

    % Film thickness: dashed (so you can distinguish)
    for k = 1:nPlot
        plot(X, H_all(:,k), 'LineWidth', 1.5);
    end

    xlim([min(X), max(X)]);
    ylim([0, 2]);

    xlabel('x');
    ylabel('P(x), H(x)');
    title('Figure 14.1  Pressure and film thickness with sine roughness');

    % Legend
    lgd = cell(1, 2*nPlot);
    for k = 1:nPlot
        lgd{k} = sprintf('P, DA=%.2f', DA_list(k));
    end
    for k = 1:nPlot
        lgd{nPlot+k} = sprintf('H, DA=%.2f', DA_list(k));
    end
    legend(lgd, 'Location', 'best');

    hold off;
end
