function Sol = GaussSeidel( A , InitialGuess, b , maxIterations , accuracy)
%This function solves the system of linear equation Ax=b using Gauss Seidel

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