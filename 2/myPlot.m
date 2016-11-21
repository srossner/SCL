close all; %to close all plots 
clear all;
clc;

% Time intervall from -12 to 15 with 0.01 as step sice for the plot 
t = -12:0.01:15;

my_Plot = figure; 
hold on;
%set window name 
set(my_Plot,'name','Analytical Solution','numbertitle','off');
% p() is the analytical solution
plot(t, p(t));

%set axis for best lock use window resolution 1920x1080
axis([-12 15 -2 12]) ;

% creat a label for the plot 
legend('p(t)')

%set title of the plot
title('Graph of analytical solution for the ordinary differential equation');
