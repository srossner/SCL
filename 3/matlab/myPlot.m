function myPlot()
close all; %to close all plots 
clear all;
clc;

%deviding 
% Time interval from -2 to 2 with 0.1 as extreem point excluded 
t_0 = -2:0.01:-0.11;
t0 = -0.09:0.01:2;

my_Plot = figure; 
hold on;
%set window name 
set(my_Plot,'name','Analytical Solution','numbertitle','off');
% p() is the analytical solution
plot(t_0, p(t_0), 'b');
plot(t0, p(t0), 'b');
plot([-0.1 -0.1], [-110 110], '--r');
plot([-5 5], [0 0], '--r' );
plot([-5 5], [10 10], '--r');


%set axis for best lock use window resolution 1920x1080
axis([-2 2 -25 25]) ;

% creat a label for the plot 
legend('p(t)', 'p(t)', 'extreem')

%set title of the plot
title('Worksheet 3: Graph of analytical solution for the ordinary differential equation');
end
