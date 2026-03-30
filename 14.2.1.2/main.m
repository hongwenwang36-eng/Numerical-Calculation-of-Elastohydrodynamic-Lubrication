% X(101), P(101), H(101), RO(101), EDA(101), POLD(101), V(101)
X    = zeros(101,1);
P    = zeros(101,1);
H    = zeros(101,1);
RO   = zeros(101,1);
EDA  = zeros(101,1);
POLD = zeros(101,1);
V    = zeros(101,1);

% D(0:101) 
D = zeros(102,1);

% C(102,102), B(102), IP(102), DP(102)
C  = zeros(102,102);
B  = zeros(102,1);
IP = zeros(102,1);
DP = zeros(102,1);

% COMMON /COMAK/AK(0:1100) 
global AK
AK = zeros(1101,1);

%% DATA 
X0  = -2.0;
XE  =  1.5;
E   =  2.21e11;
RO0 =  1.0;      
EDA0=  0.02;
U0  =  1.5;
W0  =  0.5e5;
Z   =  0.68;
R   =  0.02;
N  = 101;
KG = 0;
I1 = 87;
PAI  = 3.14159265;
G    = 5000.0;
PAI1 = 0.318309886;
%% OPEN(8,FILE='OUT.DAT',STATUS='UNKNOWN') 
fid = fopen('OUT.DAT','w');
%%  
N1 = N - 1;
N2 = N + 1;
W   = W0 / E / R;
U   = EDA0 * U0 / E / R;
AKK = 0.75 * PAI * PAI * U / (W*W);
PH  = E * sqrt(W/(2.0*PAI));
B0  = R * sqrt(8.0*W/PAI);
A1 = 0.6 * PH * 1e-9;
A2 = 1.7 * PH * 1e-9;
A3 = 5.1 * PH * 1e-9;
A4 = log(EDA0) + 9.67;
A5 = -0.5/PAI; 
A6 = A3 * Z * A4;
A7 = 2.3e-9 * PH;
HMIN = 2.65 * G^0.54 * U^0.7 / W^0.13 * (R/B0)^2;
DX = (XE - X0) / N1;
CX = log(DX);
II = 87;
%% 
IE = 1;  % 初始化

for i = 1:N
    X(i) = X0 + (i-1)*DX;
    P(i) = 0.0;

    if abs(X(i)) <= 1.0
        P(i) = sqrt(1.0 - X(i)*X(i));
    end

    if X(i) <= 1.0
        IE = i;
    end
end

SUBAK(N2);

for i0 = 0:N
    D(i0+1) = -(AK(i0+1) + CX) * DX * PAI1;
end
%% 
DA = 0.0;
while true
    C(N2, 1)  = 0.0;      
    C(N2, N2) = 0.0; 

    for i = 2:N
      C(N2, i) = DX;
    end

    for i = 1:N1
      POLD(i) = P(i);
      DP(i)   = (P(i+1) - P(i)) / DX;
    end

    POLD(N) = 0.0;
    DP(N)   = (P(N) - P(N1)) / DX; 

    V = VI(N, DX, P, V);

    if KG == 0
      H0 = 100.0;
    end

    for I = 1:N
      H(I) = 0.5 * X(I) * X(I) + V(I) + DA * sin(X(I) * 2.0 * PAI);
      if (KG == 0) && (H(I) < H0)
         H0 = H(I);
      end
      RO(I)  = 1.0 + A1 * P(I) / (1.0 + A2 * P(I));
      EDA(I) = exp(A4 * (-1.0 + (1.0 + A3 * P(I))^Z));
    end
    if KG == 0
      H0 = -H0 + HMIN;
    end
    for I = 1:N
      H(I) = H0 + H(I);
    end
    if KG == 0
      ROEHE = RO(IE) * H(IE);
    end

    for I = 1:N
      C(I, 1) = AKK * EDA(I) / RO(I);
      for J = 2:N
        IJ = abs(I - J);  
        D1 = 3.0 * (H(I)^2) * DP(I) * D(IJ + 1);
        D2 = (H(I)^3) * (DELTA(I+1, J) - DELTA(I, J)) / DX;
        D3 = -AKK * A6 * (1.0 + A3 * P(I))^(Z - 1.0) * EDA(I) * ...
             DELTA(I, J) * (H(I) - ROEHE / RO(I));
        D4 = -AKK * EDA(I) * ( D(IJ + 1) + ROEHE * A1 * DELTA(I, J) / (1.0 + A7 * P(I))^2 );
        C(I, J) = D1 + D2 + D3 + D4;
      end  
       C(I, N2) = 3.0 * H(I) * H(I) * DP(I) - AKK * EDA(I);
       B(I) = -(H(I)^3) * DP(I) + AKK * EDA(I) * (H(I) - ROEHE / RO(I));
     end 
     B(N2) = 0.5 * PAI;
     for I = 1:N
       B(N2) = B(N2) - P(I) * C(N2, I);
     end

     for I = I1:N
       if P(I) <= 0.0
          B(I) = 0.0;
          for J = 1:N2
            C(I, J) = 0.0;
            C(J, I) = 0.0;
          end
          C(I, I) = 1.0;
       end
     end

     IDET = 1;
     [C, IP, IDET] = INV(N2, C, IP, IDET);
     if IDET == 0
        fclose(fid);
        return;   % 退出函数，相当于 STOP
     end

     for J = 1:N2
       DP(J) = 0.0;
       for I = 1:N2
         DP(J) = DP(J) + C(J, I) * B(I);
       end
     end
     ROEHE = RO(II) * H(II);

     for I = 2:N1
       P(I) = P(I) + DP(I);
       if P(I) < 0.0
          P(I) = 0.0;
       end
     end

     H0  = H0 - B(N2) * DP(N2);
     ER  = 0.0;
     SUM = 0.0;

     for I = 1:N
       SUM = SUM + P(I);
       ER  = ER + abs(P(I) - POLD(I));
     end
   
     ER = ER / SUM;
     fprintf('ER,DA= %g %g\n', ER, DA);
     KG = KG + 1;
     % 相当于：10 ...
     if (ER > 1.0e-5) && (KG < 100)
        continue;   % 回到 while 顶部，相当于跳回标号10
     end

     KG = 1;
     DA = DA + 0.05;
     I1 = 21;

     for I = 1:N
       fprintf(fid, '%12.6E %12.6E %12.6E\n', X(I), P(I), H(I));
     end

     if DA < 0.16
        continue;   % 对应 IF(DA.LT.0.16) GOTO 10
     else
        break;      % 对应 20 STOP
     end

end
fclose(fid);
