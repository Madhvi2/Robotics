% Create a random set of coordinates in a circle.
% First define parameters that define the number of points and the circle.
n = 5000;
R = 20;
x0 = 50; % Center of the circle in the x direction.
y0 = 90; % Center of the circle in the y direction.
% Now create the set of points.
t = 2*pi*rand(n,1);
r = R*sqrt(rand(n,1));
x = x0 + r.*cos(t);
y = y0 + r.*sin(t);
% Now display our random set of points in a figure.
plot(x,y, '.', 'MarkerSize', 5)
axis square;
grid on;
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
fontSize = 30;
xlabel('X', 'FontSize', fontSize);
ylabel('Y', 'FontSize', fontSize);
title('Random Locations Within a Circle', 'FontSize', fontSize);