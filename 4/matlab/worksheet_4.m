close all;
clear all;
clc;

% plot analitical Solution 
x = 0:0.01:1;
y = 0:0.01:1;
surfc(x, y, T_xy(x,y));