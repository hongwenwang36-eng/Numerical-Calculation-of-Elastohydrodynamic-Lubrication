function EHL(N)

global ENDA A1 A2 A3 Z HM0 DH X0 XE
global E1 PH B R    % <<< 这里：RR 改成 R（与主程序一致）

%% 
X   = zeros(1100,1);
P   = zeros(1100,1);
H   = zeros(1100,1);
RO  = zeros(1100,1);
POLD= zeros(1100,1);
EPS = zeros(1100,1);
EDA = zeros(1100,1);
V   = zeros(1100,1);
ROU = zeros(1100,1);

MK = 1;

DX = (XE - X0) / (N - 1.0);

for I = 1:N
    X(I) = X0 + (I-1) * DX;

    if abs(X(I)) >= 1.0
        P(I) = 0.0;
    end
    if abs(X(I)) < 1.0
        P(I) = sqrt(1.0 - X(I) * X(I));
    end
end

% CALL HREE(...)
[H, RO, EPS, EDA, V, ROU] = HREE(N, DX, X, P, H, RO, EPS, EDA, V, ROU);

% CALL FZ(N,P,POLD)
POLD = FZ(N, P, POLD);

%%
while true
    KK = 19;

    % CALL ITER(...)
    [P, H, RO, EPS, EDA, V, ROU] = ITER(N, KK, DX, X, P, H, RO, EPS, EDA, V, ROU);

    MK = MK + 1;

    % CALL ERROP(...)
    [ERP, POLD] = ERROP(N, P, POLD);

    fprintf('ERP= %g\n', ERP);

    if (ERP > 1.0e-5) && (DH > 1.0e-6)
        if MK >= 50
            MK = 1;
            DH = 0.5 * DH;
        end
        continue;
    end

    break;
end

if DH <= 1.0e-6
    fprintf('Pressures are not convergent!!!\n');
end

H2 = 1.0e3;
P2 = 0.0;

for I = 1:N
    if H(I) < H2
        H2 = H(I);
    end
    if P(I) > P2
        P2 = P(I);
    end
end

H3 = H2 * B * B / R;   % <<< 这里：RR 改成 R
P3 = P2 * PH;

fprintf('P2,H2,P3,H3= %g %g %g %g\n', P2, H2, P3, H3);

OUTHP(N, X, P, H, ROU);

end
