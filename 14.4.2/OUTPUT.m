function OUTPUT(N, DX, X, Y, H, P, ROU)
% SUBROUTINE OUTPUT(N,DX,X,Y,H,P,ROU)

global fid8 fid9 fid10

A = 0.0;

% WRITE(8,110) A,(Y(I),I=1,N)
row = [A; Y(:)];
fmt = repmat('%12.6E ', 1, N+1);
fprintf(fid8, [fmt '\n'], row);

% DO I=1,N : WRITE(8,110) X(I),(H(I,J),J=1,N)
for I = 1:N
    row = [X(I); H(I,:).'];
    fprintf(fid8, [fmt '\n'], row);
end

% WRITE(9,110) A,(Y(I),I=1,N)
row = [A; Y(:)];
fprintf(fid9, [fmt '\n'], row);

% DO I=1,N : WRITE(9,110) X(I),(ROU(I,J),J=1,N)
for I = 1:N
    row = [X(I); ROU(I,:).'];
    fprintf(fid9, [fmt '\n'], row);
end

% WRITE(10,110) A,(Y(I),I=1,N)
row = [A; Y(:)];
fprintf(fid10, [fmt '\n'], row);

% DO I=1,N : WRITE(10,110) X(I),(P(I,J),J=1,N)
for I = 1:N
    row = [X(I); P(I,:).'];
    fprintf(fid10, [fmt '\n'], row);
end
end
