function [ER, POLD] = ERP(N, P, POLD)
% SUBROUTINE ERP(N,ER,P,POLD)

ER  = 0.0;
SUM = 0.0;

for I = 1:N
    for J = 1:N
        ER = ER + abs(P(I,J) - POLD(I,J));
        POLD(I,J) = P(I,J);
        SUM = SUM + P(I,J);
    end
end

ER = ER / SUM;
end
