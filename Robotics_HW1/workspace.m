clear
close all
% Define world parameters
xdata=[0 0 10 10 ];
ydata=[0 10 10 0 ];
plot(xdata,ydata);hold on;

%goal position and start position
start_position_x=1;
start_position_y=1;
goal_position_x=9;
plot(start_position_x,start_position_y,'o','MarkerSize',10,'MarkerFaceColor','r');
plot(goal_position_x,goal_position_x,'--gs','MarkerSize',10,'MarkerFaceColor','g');


