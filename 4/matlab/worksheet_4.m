close all;
clear;
clc;

% plot analitical Solution 
N_X = 9;
N_Y = 9;
dt_x = 1/(N_X + 1) ;
dt_y = 1/(N_Y + 1);
x_ = 0:dt_x:1;
y_ = 0:dt_y:1;
sol =  T_xy(x_,y_);

plotT( N_X , N_Y, sol, 'Worksheet 4');

% plot finite difference Solution 
M = createM(N_X, N_Y);

figure
spy(M);

x_ = dt_x:dt_x:(1 - dt_x);
y_ = dt_y:dt_y:(1 - dt_y);

x1 = T_xxyy(x_, y_);
x3 = reshape(x1,[(N_X * N_Y) , 1 ]);

sol2 = M\x3;

plotT( N_X , N_Y, sol2, 'Worksheet 4');

N = [ 7 15 31 63 127];

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
        solution_full{i} =  A{i}\b{i};
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
        solution_spars{i} =  A_s{i}\b{i};
    t_direct_solution_spars_matrix(i) = toc;
end

number_of_Storage_spars = 1:length(N);
for i = 1:length(N)
    number_of_Storage_spars(i) = nnz(A_s{i});
end

t_iterativ_solution_spars_matrix = 1:length(N);
for i = 1:length(N)
     tic;
        solution_GaussSeidel_spars_matrix{i} =  GaussSeidel(  b{i}, N(i), N(i), zeros(length(b{i}), 1) , 40000, .0001 );
     t_iterativ_solution_spars_matrix(i) = toc;
     
     plotT(N(i), N(i), solution_GaussSeidel_spars_matrix{i}, 'Worksheet 4');
end

t_iterativ_solution_solver = 1:length(N);
for i = 1:length(N)
    tic;                          %solver(   Nx,   Ny,   p ,           nitialGuess , maxIterations , Tboundary , accuracy)
        solution_GaussSeidel_solver{i} =  solver( N(i), N(i), @T_xxyy, zeros(length(b{i}), 1), 40000         ,   0        ,  0.0001 , A_s{i}, b{i});
    t_iterativ_solution_solver(i) = toc;
    
    plotT(N(i), N(i), solution_GaussSeidel_solver{i}, 'Worksheet 4');
end


error_gaus_spars_matrix = 1:length(N);
error_gaus_red_spars_matrix = 1:length(N);
for i = 1:length(N)
     
      error_gaus_spars_matrix(i) =   approximationError( N(i), N(i),  solution_GaussSeidel_spars_matrix{i} , solution_spars{i} );
      if i > 1
          error_gaus_red_spars_matrix(i) = error_gaus_spars_matrix(i-1) / error_gaus_spars_matrix(i);
     end
 
end

error_gaus_solver = 1:length(N);
error_gaus_red_solver = 1:length(N);
for i = 1:length(N)
    
     error_gaus_solver(i) =   approximationError( N(i), N(i),  solution_GaussSeidel_solver{i} , solution_spars{i} );
     if i > 1
         error_gaus_red_solver(i) = error_gaus_solver(i-1) / error_gaus_solver(i);
     end

end


addpath ../../Submodules/matlabTableFramework/;
% Create a table with a particular titel
TestTable = SpecificTable('Worksheed 4');

% The first spet is defining a Mode for a table.
% The should be at least one Mode in order to print a tabble
CoulmnsName = {'7' '15' '31' '63' '127' };
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
     'iterative solution with Gauss-Seidel  spars matrix' );
TestTable.addTable( [ t_iterativ_solution_solver ; [ 6 6 6 6 6]        ] ,...
    'iterative solution with Gauss-Seidel no storing of matrix' );



% Define and add a new mode
CoulmnsName = {'7' '15' '31' '63' '127'};
RowsName = {'error', 'error red.'};
SecondMode = TableMode( CoulmnsName, RowsName  );
TestTable.addMode( SecondMode );

TestTable.addTable( [ error_gaus_spars_matrix  ; error_gaus_red_spars_matrix ] , 'iterative solution with Gauss-Seidel  spars matrix' );
TestTable.addTable( [ error_gaus_solver  ; error_gaus_red_solver ] , 'iterative solution with Gauss-Seidel no storing of matrix' );






