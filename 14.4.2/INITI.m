function [DX, X, Y, P, POLD] = INITI(N, X0, XE, X, Y, P, POLD)
% SUBROUTINE INITI(N,DX,X0,XE,X,Y,P,POLD)

DX = (XE - X0) / (N - 1.0);
Y0 = -0.5 * (XE - X0);

for I = 1:N
    X(I) = X0 + (I-1) * DX;
    Y(I) = Y0 + (I-1) * DX;
end

for I = 1:N
    D = 1.0 - X(I)*X(I);
    for J = 1:N
        C = D - Y(J)*Y(J);
        if C <= 0.0
            P(I,J) = 0.0;
        end
        if C > 0.0
            P(I,J) = sqrt(C);
        end
        POLD(I,J) = P(I,J);
    end
end
end
