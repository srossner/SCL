function Sol = GaussSeidel(  b , N_x, N_y, InitialGuess, maxIterations , accuracy)
%This function solves the system of linear equation Ax=b using Gauss Seidel

    A = createM(N_x, N_y);


    Sol = InitialGuess;
    N = size(A,1);
    error = 1;
    iteration = 0;
    
    while  error>=accuracy && iteration <= maxIterations
        
        for i=1:N
            Sol(i) = (b(i)- A(i,:)*Sol + A(i,i)*Sol(i))/A(i,i);
        end
        
        iteration = iteration + 1;
        
        error = norm(A*Sol -b);
        
    end   
    
end