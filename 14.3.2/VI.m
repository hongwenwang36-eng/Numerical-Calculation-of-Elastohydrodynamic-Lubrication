function V = VI(N, DX, P, V)

global AK
PAI1 = 0.318309886;

C = log(DX);   % Fortran: C = ALOG(DX)

for I = 1:N
    V(I) = 0.0;

    for J = 1:N
        IJ = abs(I - J);   % Fortran: IJ = IABS(I-J)
        V(I) = V(I) + (AK(IJ + 1) + C) * DX * P(J);
    end
end

for I = 1:N
    V(I) = -PAI1 * V(I);   % Fortran: V(I) = -PAI1*V(I)
end

end
