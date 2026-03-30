function SUBAK(MM)
% SUBROUTINE SUBAK(MM)

global AK
AK = zeros(MM+2, MM+2);  

% S(X,Y)=X+SQRT(X**2+Y**2)
S = @(x,y) (x + sqrt(x.^2 + y.^2));

for I = 0:MM
    XP = I + 0.5;
    XM = I - 0.5;

    for J = 0:I
        YP = J + 0.5;
        YM = J - 0.5;

        A1 = S(YP, XP) / S(YM, XP);
        A2 = S(XM, YM) / S(XP, YM);
        A3 = S(YM, XM) / S(YP, XM);
        A4 = S(XP, YP) / S(XM, YP);

        AK(I+1, J+1) = XP*log(A1) + YM*log(A2) + XM*log(A3) + YP*log(A4);
        AK(J+1, I+1) = AK(I+1, J+1);
    end
end
end
