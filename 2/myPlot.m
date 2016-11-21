close all;
clear all;
clc;

t = -12:0.01:15;

plot(t, p(t));
axis([-12 15 -2 12]) ;
legend('p(t)')