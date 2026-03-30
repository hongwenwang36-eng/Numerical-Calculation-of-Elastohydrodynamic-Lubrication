function EHL(N, X0, XE)
% SUBROUTINE EHL(N,X0,XE)

global ENDA A1 A2 A3 Z HM0 DH

% DIMENSION X(65),Y(65),H(4500),RO(4500),EPS(4500),EDA(4500),
% P(4500),POLD(4500),V(4500),ROU(4500)
X    = zeros(N,1);
Y    = zeros(N,1);
H    = zeros(N,N);
RO   = zeros(N,N);
EPS  = zeros(N,N);
EDA  = zeros(N,N);
P    = zeros(N,N);
POLD = zeros(N,N);
V    = zeros(N,N);
ROU  = zeros(N,N);

% DATA MK,G0/1,2.0943951/
MK = 1;
G0 = 2.0943951;

% CALL INITI(N,DX,X0,XE,X,Y,P,POLD)
[DX, X, Y, P, POLD] = INITI(N, X0, XE, X, Y, P, POLD);

% KK=0
KK  = 0;
H00 = 0.0;

% CALL HREE(N,DX,KK,H00,G0,X,Y,H,RO,EPS,EDA,P,V,ROU)
[KK, H00, H, RO, EPS, EDA, P, V, ROU] = HREE(N, DX, KK, H00, G0, X, Y, H, RO, EPS, EDA, P, V, ROU);

% 14
while true
    % KK=15
    KK = 15;

    % CALL ITER(...)
    [KK, H00, H, RO, EPS, EDA, P, V, ROU] = ITER(N, KK, DX, H00, G0, X, Y, H, RO, EPS, EDA, P, V, ROU);

    % MK=MK+1
    MK = MK + 1;

    % CALL ERP(N,ER,P,POLD)
    [ER, POLD] = ERP(N, P, POLD);

    % WRITE(*,*)'ER=',ER
    fprintf('ER= %g\n', ER);

    % IF(ER.GT.1.E-5.AND.DH.GT.1.E-7)THEN ...
    if (ER > 1.0e-5) && (DH > 1.0e-7)
        if MK >= 10
            MK = 1;
            DH = 0.5 * DH;
        end
        % GOTO 14
        continue;
    end
    break;
end

% IF(DH.LE.1.E-7)WRITE(*,*)'Pressures are not convergent!!!'
if DH <= 1.0e-7
    fprintf('Pressures are not convergent!!!\n');
end

% CALL OUTPUT(N,DX,X,Y,H,P,ROU)
OUTPUT(N, DX, X, Y, H, P, ROU);
end
