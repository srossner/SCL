function Sol = solver( Nx, Ny, p , InitialGuess , maxIterations , Tboundary , accuracy )
%This function computes the coefficients of the equation at each grid point
%and solves the system of linear equation using Gauss Seidel Method.
%Parameter are Nx=No. of nodes in x direction , Ny=No. of nodes in y
%direction, p=function of on the right hand side of the differential
%equation, InitialGuess= Initial Guess for Gauss Seidel Iteration,
%maxIterations=milit of the maximum no. of iterations,
%Tboundary=Temperature at the boundary
Sol = InitialGuess;
R = 1;
iteration = 0;
    while R>accuracy && iteration <= maxIterations
        cumsum =0;
        for i=1:Nx*Ny
            [north, south, east, west, centre, Vector] = coefficient( Nx, Ny, p , i , Sol , Tboundary );
            Sol(i) = ( Vector - ( north + south + east + west ))/ centre;
        end
        iteration = iteration +1;
        for i=1:Nx*Ny
            [north, south, east, west, centre, Vector] = coefficient( Nx, Ny, p , i , Sol , Tboundary );
            cumsum = cumsum + ( Vector - ( north + south + east + west ) - (centre*Sol(i)))^2;
        end
        R = sqrt(cumsum/(Nx*Ny));
    end
iteration
end
