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
   
t_direct_solution_full_matrix = 1:length(N);
for i = 1:length(N)
    tic;
        solution{i} =  A{i}\b{i};
   t_direct_solution_full_matrix(i) =  toc;
end

number_of_storage_Full_Storage = 1:length(N);
for i = 1:length(N)
    [m, n] = size (A{i});
    number_of_storage_Full_Storage(i) = m*n;
end

t_direct_solution_spars_matrix = 1:length(N);
for i = 1:length(N)
    tic;
        solution{i} =  A_s{i}\b{i};
    t_direct_solution_spars_matrix(i) = toc;
end

number_of_Storage_spars = 1:length(N);
for i = 1:length(N)
    number_of_Storage_spars(i) = nnz(A_s{i});
end

t_iterativ_solution_spars_matrix = 1:length(N);
for i = 1:length(N)
    tic;
        solution{i} =  GaussSeidel(A_s{i}, zeros(length(b{i}), 1 ) , b{i}, 100, .0001);
    t_iterativ_solution_spars_matrix(i) = toc;
end




addpath ../../Submodules/matlabTableFramework/;
% Create a table with a particular titel
TestTable = SpecificTable('Worksheed 4');

% The first spet is defining a Mode for a table.
% The should be at least one Mode in order to print a tabble
CoulmnsName = {'7' '15' '31' '63' };
RowsName = {'runtime', 'storage'};
FirstMode = TableMode( CoulmnsName, RowsName  );
% Add a Mode to the TestTable
TestTable.addMode( FirstMode );
% Add new tables
TestTable.addTable( [ t_direct_solution_full_matrix    ; number_of_storage_Full_Storage ] ,...
    'direct solution with full matrix' );
TestTable.addTable( [ t_direct_solution_spars_matrix   ; number_of_Storage_spars       	] ,...
    'direct solution with sparse matrix' );
TestTable.addTable( [ t_iterativ_solution_spars_matrix ; number_of_Storage_spars        ] ,...
    'iterative solution with Gauss-Seidel' );

% Define and add a new mode
CoulmnsName = {'7' '15' '31' '63' '128'};
RowsName = {'error', 'error red.'};
SecondMode = TableMode( CoulmnsName, RowsName  );
TestTable.addMode( SecondMode );

TestTable.addTable( [1 2 3 4 5  ; 1 2 3 4 5 ] , ' ' );






















