function [ x ] = GaussSeidel( A , x0, b , maxIterations )

    [m, n] = size(A);
    if m ~= n
        error('Matrix A must be square');
    end
    err = 1;
    iteration = 0;
    while err >= 0.01 || maxIterations <= iteration
        
       L = tril(A);
       U = triu(A) - diag(diag(A));
       
       t = ( L - diag(diag(A)) )^-1
       
       x = t * U * x0 + t *b;

        err = norm(A*x -b);
        
        x0 = x;
        
    end


end

