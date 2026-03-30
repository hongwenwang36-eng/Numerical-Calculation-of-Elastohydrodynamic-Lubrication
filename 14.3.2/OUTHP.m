function OUTHP(N, X, P, H, ROU)
global fid8
for I = 1:N
    fprintf(fid8, ' %12.6E %12.6E %12.6E %12.6E \n', X(I), P(I), H(I), ROU(I));
end

end

