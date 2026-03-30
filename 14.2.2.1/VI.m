function V = VI(N, DX, P, V)

global AK

PAI1 = 0.318309886;   
C    = log(DX);       

for I = 1:N
    V(I) = 0.0;
    for J = 1:N
        IJ = abs(I - J);                 % IABS(I-J)
        V(I) = V(I) + (AK(IJ+1) + C) * DX * P(J);  % AK(0..) -> +1
    end
end

for I = 1:N
    V(I) = -PAI1 * V(I);
end

return
end
