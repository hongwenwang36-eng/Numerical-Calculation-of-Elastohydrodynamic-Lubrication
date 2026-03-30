function [KK, H00, H, RO, EPS, EDA, P, V, ROU] = ITER(N, KK, DX, H00, G0, X, Y, H, RO, EPS, EDA, P, V, ROU)
% SUBROUTINE ITER(N,KK,DX,H00,G0,X,Y,H,RO,EPS,EDA,P,V,ROU)

global AK

% DATA KG1,PAI/0,3.14159265/
persistent KG1 AK00 AK10
PAI = 3.14159265;

if isempty(KG1), KG1 = 0; end

if KG1 ~= 0
    % GOTO 2
else
    KG1 = 1;
    AK00 = AK(0+1,0+1);   % AK(0,0)
    AK10 = AK(1+1,0+1);   % AK(1,0)
end

% 2 DO 100 K=1,KK
for K = 1:KK

    for J = 2:(N-1)
        J0 = J - 1;
        J1 = J + 1;

        D2 = 0.5 * (EPS(1,J) + EPS(2,J));

        for I = 2:(N-1)

            if H(I,J) <= 0.0
                % GOTO 60 -> just skip update
                continue;
            end

            I0 = I - 1;
            I1 = I + 1;

            D1 = D2;
            D2 = 0.5 * (EPS(I1,J) + EPS(I,J));
            D4 = 0.5 * (EPS(I,J0) + EPS(I,J));
            D5 = 0.5 * (EPS(I,J1) + EPS(I,J));

            D8  = 2.0 * RO(I,J)  * AK00 / (PAI^2);
            D9  = 2.0 * RO(I0,J) * AK10 / (PAI^2);

            D10 = D1 + D2 + D4 + D5 + D8*DX - D9*DX;

            D11 = D1*P(I0,J) + D2*P(I1,J) + D4*P(I,J0) + D5*P(I,J1);

            D12 = (RO(I,J)*H(I,J) - D8*P(I,J) - RO(I0,J)*H(I0,J) + D9*P(I,J)) * DX;

            P(I,J) = (D11 - D12) / D10;

            if P(I,J) < 0.0
                P(I,J) = 0.0;
            end
        end
    end

    % CALL HREE(...)
    [KK, H00, H, RO, EPS, EDA, P, V, ROU] = HREE(N, DX, KK, H00, G0, X, Y, H, RO, EPS, EDA, P, V, ROU);
end
end
