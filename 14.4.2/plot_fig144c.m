function plot_fig144_c_like_book()
% Figure 14.4(c) - Film thickness (H) with axis style similar to the book

A = read_fortran_grid_file('FILM.DAT');

Y = A.Y;        
X = A.X;      
H = A.Z;      
[YY, XX] = meshgrid(Y, X);

figure;

ds = 2;
XXd = XX(1:ds:end, 1:ds:end);
YYd = YY(1:ds:end, 1:ds:end);
Hd  = H( 1:ds:end, 1:ds:end);

surf(XXd, YYd, Hd, 'EdgeColor','none');
shading flat;                 
colormap(parula);         

xlabel('X');
ylabel('Y');
zlabel('H');

ax = gca;

set(ax, 'ZDir','reverse');


set(ax, 'XAxisLocation','top');


set(ax, 'TickDir','in');


box(ax,'on');
grid(ax,'off');


view(ax, -135, 20);



axis(ax,'tight');
end


function A = read_fortran_grid_file(fname)
M = readmatrix(fname);
A.Y = M(1, 2:end);
A.X = M(2:end, 1);
A.Z = M(2:end, 2:end);
end



