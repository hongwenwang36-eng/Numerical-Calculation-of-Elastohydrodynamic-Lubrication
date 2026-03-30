global ENDA A1 A2 A3 Z HM0 DH
global E1 RX B PH          % /COMER/ 里是 E1,RX,B,PH
global AK                  % /COMAK/
global fid4 fid8 fid9 fid10

% DATA PAI,Z
PAI = 3.14159265;
Z   = 0.68;

% DATA N,PH,E1,EDA0,RX,US,X0,XE
N    = 65;
PH   = 0.8e9;
E1   = 2.21e11;
EDA0 = 0.05;
RX   = 0.02;
US   = 1.0;
X0   = -2.5;
XE   =  1.5;

% OPEN(...)
fid4  = fopen('OUT.DAT','w');        % unit 4
fid8  = fopen('FILM.DAT','w');       % unit 8
fid9  = fopen('ROUGH1.DAT','w');     % unit 9
fid10 = fopen('PRESSURE.DAT','w');   % unit 10

MM = N - 1;

% A1=ALOG(EDA0)+9.67
A1 = log(EDA0) + 9.67;

% A2=5.1E-9*PH
A2 = 5.1e-9 * PH;

% A3=0.59/(PH*1.E-9)
A3 = 0.59 / (PH * 1e-9);

% U=EDA0*US/(2.*E1*RX)
U = EDA0 * US / (2.0 * E1 * RX);

% B=PAI*PH*RX/E1
B = PAI * PH * RX / E1;

% W0=2.*PAI*PH/(3.*E1)*(B/RX)**2
W0 = 2.0 * PAI * PH / (3.0 * E1) * (B/RX)^2;

% ALFA=Z*5.1E-9*A1
ALFA = Z * 5.1e-9 * A1;

% G=ALFA*E1
G = ALFA * E1;

% HM0=3.63*(RX/B)**2*G**0.49*U**0.68*W0**(-0.073)
HM0 = 3.63 * (RX/B)^2 * (G^0.49) * (U^0.68) * (W0^(-0.073));

% ENDA=12.*U*(E1/PH)*(RX/B)**3
ENDA = 12.0 * U * (E1/PH) * (RX/B)^3;

% WRITE(*,*)... & WRITE(4,*)...
fprintf('%g %g %g %g %g %g %g %g %g\n', N, X0, XE, W0, PH, E1, EDA0, RX, US);
fprintf(fid4,'%g %g %g %g %g %g %g %g %g\n', N, X0, XE, W0, PH, E1, EDA0, RX, US);

fprintf(' Wait please\n');

% CALL SUBAK(MM)
SUBAK(MM);

% CALL EHL(N,X0,XE)
EHL(N, X0, XE);

% STOP/END -> close
fclose(fid4);
fclose(fid8);
fclose(fid9);
fclose(fid10);
