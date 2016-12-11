function [xnext,iterations] = NewtonsMethod(G, G_, PreviousValue,dt,maxIterations)
%G=0 is the equation to be solved, 
%G_ is the derivative of G with respect to the unknown variable
%Initial Guess is the value from which the iteration of Newton's Method
%will be started
%In our case we take the previous value of the function as the initial
%guess. Thus yn=initialGuess
%If the the solution oscillated around a value and does not converges to
%our required convergance limit(which is 1e-4 as per assignment sheet), we
%break the iteration loop after 200 iterations if the distance between the
%previous point and the current one is less than 0.01

    
    %iniialization of variables to suit our algorithm
    %i is counter variable which counts the number of iterations
    error = 1;
    InitialGuess = PreviousValue;
    xnext = InitialGuess;  
    i=0; 
    iterations = 0;
    
    while(error>1e-4 && iterations<maxIterations)
        xpre = xnext; 
        xnext = xpre - (G(xpre,PreviousValue,dt)/G_(xpre,PreviousValue,dt));
        error = abs(xpre - xnext);
        iterations=iterations+1;
    end      
end