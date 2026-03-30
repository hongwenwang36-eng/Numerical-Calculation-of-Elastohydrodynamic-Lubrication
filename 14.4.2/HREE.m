function [KK, H00, H, RO, EPS, EDA, P, V, ROU] = HREE(N, DX, KK, H00, G0, X, Y, H, RO, EPS, EDA, P, V, ROU)
% SUBROUTINE HREE(N,DX,KK,H00,G0,X,Y,H,RO,EPS,EDA,P,V,ROU)

global ENDA A1 A2 A3 Z HM0 DH
global AK
global E1 RX B PH

% DATA PAI,PAI1
PAI  = 3.14159265;
PAI1 = 0.2026423;

% DATA KR,DA/0,0.1/
persistent KR
if isempty(KR), KR = 0; end
DA = 0.1;

% CALL VI(N,DX,P,V)
V = VI(N, DX, P, V);

HMIN = 1.0e3;

% IF(KR.EQ.0)THEN read ROUGH2.DAT once
if KR == 0
    fid12 = fopen('ROUGH2.DAT','r');
    for I = 1:N
        for J = 1:N
            ROU(I,J) = fscanf(fid12, '%f', 1);
        end
    end
    fclose(fid12);
    KR = 1;
end

% DO 30 I=1,N; DO 30 J=1,N
for I = 1:N
    for J = 1:N
        % RAD=X(I)*X(I)+Y(J)*Y(J)+DA*ROU(I,J)
        RAD = X(I)*X(I) + Y(J)*Y(J) + DA * ROU(I,J);
        W1  = 0.5 * RAD;
        H0  = W1 + V(I,J);
        if H0 < HMIN
            HMIN = H0;
        end
        H(I,J) = H0;
    end
end

% IF(KK.EQ.0)THEN ...
if KK == 0
    KK  = 1;
    DH  = 0.005 * HM0;
    H00 = -HMIN + 0.5 * HM0;
end

% W1=sum(P)
W1 = 0.0;
for I = 1:N
    for J = 1:N
        W1 = W1 + P(I,J);
    end
end
W1 = DX*DX*W1 / G0;

DW = 1.0 - W1;

if DW < 0.0
    H00 = H00 + DH;
end
if DW > 0.0
    H00 = H00 - DH;
end

% DO 60 I=1,N; DO 60 J=1,N
for I = 1:N
    for J = 1:N
        H(I,J) = H00 + H(I,J);

        if H(I,J) < 0.0
            % P(I,J)=P(I,J)+4.*SQRT(-H)**3*(B**3/R)*(E1/PH)/3.0
            P(I,J) = P(I,J) + 4.0 * (sqrt(-H(I,J))^3) * (B^3 / RX) * (E1/PH) / 3.0;
            H(I,J) = 0.0;
        end

        EDA1    = exp( A1 * (-1.0 + (1.0 + A2 * P(I,J))^Z) );
        EDA(I,J)= EDA1;
        RO(I,J) = (A3 + 1.34 * P(I,J)) / (A3 + P(I,J));
        EPS(I,J)= RO(I,J) * (H(I,J)^3) / (ENDA * EDA1);
    end
end
end
