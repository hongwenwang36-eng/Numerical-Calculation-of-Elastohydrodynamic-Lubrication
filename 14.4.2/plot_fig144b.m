function plot_fig144b()
% Figure 14.4(b) Pressure distribution (point contact, random roughness)

fname = 'PRESSURE.DAT';
A = read_fortran_grid_file(fname);

Y = A.Y;            
X = A.X;              
P = A.Z;             


[YY, XX] = meshgrid(Y, X);

figure;
surf(YY, XX, P, 'EdgeColor', 'none');   
xlabel('Y');
ylabel('X');
zlabel('P');
view(135, 25);
axis tight;
box on;
end


function A = read_fortran_grid_file(fname)


M = readmatrix(fname);   
Y = M(1, 2:end);
X = M(2:end, 1);
Z = M(2:end, 2:end);

A.Y = Y;
A.X = X;
A.Z = Z;
end
