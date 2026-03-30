function POLD = FZ(N, P, POLD)
% 对应 Fortran: SUBROUTINE FZ(N,P,POLD)

for I = 1:N
    POLD(I) = P(I);
end

end
