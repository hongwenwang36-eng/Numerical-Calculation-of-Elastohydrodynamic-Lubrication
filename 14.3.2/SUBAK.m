function SUBAK(MM)
global AK
for I = 0:MM
    AK(I+1) = (I+0.5) * (log(abs(I+0.5)) - 1.0) ...
            - (I-0.5) * (log(abs(I-0.5)) - 1.0);
end
end

