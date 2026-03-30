function gen_ROUGH2_DAT()

fid12 = fopen('ROUGH2.DAT', 'w');  

for I = 1:5000                      % DO I=1,5000
    ROU = rand();                   % ROU = RAN(IDUM)

    % WRITE(12,100) ROU  
    fprintf(fid12, ' %10.6f\n', ROU);

    % WRITE(*,100) ROU  
    fprintf(' %10.6f\n', ROU);
end

fclose(fid12);            
end










