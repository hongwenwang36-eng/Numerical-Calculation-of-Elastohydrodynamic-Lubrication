function SUBAK(MM)


global AK

for I0 = 0:MM
    AK(I0+1) = (I0+0.5) * (log(abs(I0+0.5)) - 1.0) ...
             - (I0-0.5) * (log(abs(I0-0.5)) - 1.0);
end

return
end
