function [H, RO, EPS, EDA, V, ROU] = HREE(N,DX,X,P,H,RO,EPS,EDA,V,ROU)

global ENDA A1 A2 A3 Z HM0 DH EDA0 
global AK 

KK = 0;
PAI1=0.318309886;
G0 = 1.570796325;
KR = 0;
DA = 0.1;
H00 = 0;


W1 = 0.0;
for I = 1:N
    W1 = W1 + P(I);
end

C3 = (DX * W1) / G0;
DW = 1.0 - C3;

% CALL VI(N,DX,P,V)
V = VI(N, DX, P, V);

HMIN = 1.0e3;
%%
if KR == 0
    fid12 = fopen('ROUGH2.DAT','r');
    for I = 1:N
        ROU(I) = fscanf(fid12, '%f', 1);
    end
    fclose(fid12);
    KR = 1;
end

%%
% DO 30 I=1,N
for I = 1:N
    H0 = 0.5 * X(I) * X(I) + V(I) + DA * ROU(I);
    if H0 < HMIN
        HMIN = H0;
    end
    H(I) = H0;
end

% IF(KK.EQ.0)THEN ...
if KK == 0
    KK  = 1;
    DH  = 0.005 * HM0;
    H00 = -HMIN + HM0;
end

% IF(DW.LT.0.0)H00=H00+DH
% IF(DW.GT.0.0)H00=H00-DH
if DW < 0.0
    H00 = H00 + DH;
end
if DW > 0.0
    H00 = H00 - DH;
end

% DO 60 I=1,N
for I = 1:N
    H(I)   = H00 + H(I);
    EDA(I) = exp( A1 * (-1.0 + (1.0 + A2 * P(I))^Z) );
    RO(I)  = (A3 + 1.34 * P(I)) / (A3 + P(I));
    EPS(I) = RO(I) * (H(I)^3) / (ENDA * EDA(I));
end
end

