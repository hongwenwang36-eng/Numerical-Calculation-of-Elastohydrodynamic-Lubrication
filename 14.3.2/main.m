global ENDA A1 A2 A3 Z HM0 DH      % 对应 /COM1/
global EDA0                        % 对应 /COM2/
global X0 XE                       % 对应 /COM4/
global E1 PH B R                   % 对应 /COM3/
global fid8
%%
PAI = 3.14159265;
Z   = 0.68;
P0  = 1.96e8;
N    = 129;
X0   = -4.0;
XE   =  1.4;
W    =  1.0e5;
E1   =  2.21e11;
EDA0 =  0.05;
R    =  0.05;
Us   =  1.5;
fid8 = fopen('OUT.DAT','w');
%%
W1 = W/(E1*R);
PH = E1 * sqrt(0.5*W1/PAI);
A1 = (log(EDA0) + 9.67);
A2 = PH / P0;
A3 = 0.59 / (PH*1e-9);
B = 4.0 * R * PH / E1;
ALFA = Z * A1 / P0;
G = ALFA * E1;
U = EDA0 * Us / (2.0*E1*R);
CC1 = sqrt(2.0*U);
AM = 2.0 * PAI * (PH/E1)^2 / CC1;
ENDA = 3.0 * (PAI/AM)^2 / 8.0;
HM0 = 1.6 * (R/B)^2 * (G^0.6) * (U^0.7) * (W1^(-0.13));
fprintf('%g %g %g %g %g %g %g %g\n', N, X0, XE, W, E1, EDA0, R, Us);
%%
SUBAK(N)
EHL(N)
fclose(fid8);





