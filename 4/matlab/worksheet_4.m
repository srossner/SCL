close all;
clear;
clc;

% plot analitical Solution 

dt_x = 0.1;
dt_y = 0.1;
x_ = dt_x:dt_x:(1-dt_x);
y_ = dt_y:dt_y:(1-dt_y);
sol =  T_xy(x_,y_);
surfc( y_,x_,sol);

size_x = length(x_);
size_y = length(y_);
M = createM(size_x, size_y);
figure
spy(M);


x1 = T_xxyy(x_, y_);
x3 = reshape(x1,[(size_x * size_y) , 1 ]);

sol2 = M\x3;

figure
my_Sol = reshape(sol2,[size_x, size_y]);

surfc( y_,x_,my_Sol);


N = [ 7 15 31 63 ];

for i = 1:length(N)
    
    A{i} = createM(N(i), N(i));
    
    h = 1/ (N(i) +1);
    
    x{i} = h:h:(1-h);
    
    B{i} = T_xxyy(x{i}, x{i});
    
    b{i} = reshape(B{i}, [(N(i) * N(i)) , 1 ]);
    
    A_s{i} = sparse(A{i});
end
   
disp('Full storage');
for i = 1:length(N)
    tic
        solution{i} =  A{i}\b{i};
        
        size (A{i})
    toc
end
disp(' ');

disp('Sparse storage');
for i = 1:length(N)
    tic
        solution{i} =  A_s{i}\b{i};
    toc
    
end

