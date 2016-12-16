close all;
clear all;
clc;

% plot analitical Solution 
dt_x = 0.1;
dt_y = 0.1;
x = dt_x:dt_x:(1-dt_x);
y = dt_y:dt_y:(1-dt_y);
sol =  T_xy(x,y);
surfc( y,x,sol);

size_x = length(x);
size_y = length(y);
M = createM(size_x, size_y);
figure
spy(M);

x1 = T_xxyy(x, y);
x3 = reshape(x1,[(size_x * size_y) , 1 ]);

sol2 = M\x3;

figure
my_Sol = reshape(sol2,[size_x, size_y]);

surfc( y,x,my_Sol);