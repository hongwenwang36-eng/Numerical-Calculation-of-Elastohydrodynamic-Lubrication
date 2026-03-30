function [P, H, RO, EPS, EDA, V, ROU] = ITER(N,KK,DX,X,P,H,RO,EPS,EDA,V,ROU)

% 对应 Fortran: SUBROUTINE ITER(N,KK,DX,X,P,H,RO,EPS,EDA,V,ROU)
% COMMON /COMAK/AK(0:1100)

global AK

PAI1 = 0.318309886;

for K = 1:KK   % Fortran: DO 100 K=1,KK

    D2 = 0.5 * (EPS(1) + EPS(2));
    D3 = 0.5 * (EPS(2) + EPS(3));

    for I = 2:(N-1)   % Fortran: DO 70 I=2,N-1
        D1 = D2;
        D2 = D3;

        % Fortran: IF(I.NE.N-1) D3 = 0.5*(EPS(I+1)+EPS(I+2))
        if I ~= (N-1)
            D3 = 0.5 * (EPS(I+1) + EPS(I+2));
        end

        % Fortran: D8=RO(I)*AK(0)*PAI1, D9=RO(I-1)*AK(1)*PAI1
        D8  = RO(I)   * AK(0 + 1) * PAI1;   % AK(0) -> AK(1)
        D9  = RO(I-1) * AK(1 + 1) * PAI1;   % AK(1) -> AK(2)

        D10 = 1.0 / (D1 + D2 + (D9 - D8) * DX);
        D11 = D1 * P(I-1) + D2 * P(I+1);
        D12 = (RO(I) * H(I) - RO(I-1) * H(I-1) + (D8 - D9) * P(I)) * DX;

        P(I) = (D11 - D12) * D10;

        if P(I) < 0.0
            P(I) = 0.0;
        end
    end

    % Fortran: CALL HREE(N,DX,X,P,H,RO,EPS,EDA,V,ROU)
    % MATLAB: 必须接回被更新的变量（P,H,RO,EPS,EDA,V）
   [H, RO, EPS, EDA, V, ROU] = HREE(N, DX, X, P, H, RO, EPS, EDA, V, ROU);


end

end
