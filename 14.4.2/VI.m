function V = VI(N, DX, P, V)
% SUBROUTINE VI(N,DX,P,V)

global AK
PAI1 = 0.2026423;

for I = 1:N
    for J = 1:N
        H0 = 0.0;
        for K = 1:N
            IK = abs(I - K);
            for L = 1:N
                JL = abs(J - L);
                H0 = H0 + AK(IK+1, JL+1) * P(K,L); % AK(0:65,0:65) -> +1
            end
        end
        V(I,J) = H0 * DX * PAI1;
    end
end
end
