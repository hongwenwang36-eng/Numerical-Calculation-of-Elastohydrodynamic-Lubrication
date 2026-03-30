function [ERP, POLD] = ERROP(N, P, POLD)
ERP = 0.0;
SUM = 0.0;

for I = 1:N
    ERP = ERP + abs(P(I) - POLD(I));
    POLD(I) = P(I);
    SUM = SUM + P(I);
end

ERP = ERP / SUM;
end

