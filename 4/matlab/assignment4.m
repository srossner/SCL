function assignment4(Nx, Ny, Tboundary)
    p = @(x,y) -2*pi*pi*sin(pi*x)*sin(pi*y);
    %[m , v] = discretization(Nx,Ny,p);
    %temp1 = inv(m)*v;
    %temp2 = m\v;
    maxIterations = 10000;
    InitialGuess = zeros(Nx*Ny,1);
    %temp3 = GaussSeidel( m , InitialGuess, v , maxIterations );
    temp3 = solver( Nx, Ny, p , InitialGuess , maxIterations , Tboundary );
    c=1;
    for i=1:Nx
        for j=1:Ny
            %T1(i,j) = temp1(c);
            %T2(i,j) = temp2(c);
            T3(i,j) = temp3(c);
            c=c+1;
        end
    end
    %surf(T1);
    %surf(T2);
    surf(T3);
end