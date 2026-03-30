function [A, IP, IDET] = INV(N, A, IP, IDET)

IDET = 1;
EPS  = 1.0e-6;

for K = 1:N
    P  = 0.0;
    I0 = K;
    IP(K) = K;
    for I = K:N
        if abs(A(I,K)) > abs(P)
            P = A(I,K);
            I0 = I;
            IP(K) = I;
        end
    end
    if abs(P) <= EPS
        IDET = 0;
        return;
    end
    if I0 ~= K
        for J = 1:N
            S = A(K,J);
            A(K,J) = A(I0,J);
            A(I0,J) = S;
        end
    end
    A(K,K) = 1.0 / P;
    for I = 1:N
        if I ~= K
            A(I,K) = -A(I,K) * A(K,K);
            for J = 1:N
                if J ~= K
                    A(I,J) = A(I,J) + A(I,K) * A(K,J);
                end
            end
        end
    end

    for J = 1:N
        if J ~= K
            A(K,J) = A(K,K) * A(K,J);
        end
    end
end

for K = (N-1):-1:1
    IR = IP(K);
    if IR ~= K
        for I = 1:N
            S = A(I,IR);
            A(I,IR) = A(I,K);
            A(I,K) = S;
        end
    end
end

return
end
