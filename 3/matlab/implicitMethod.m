function [ pt, coverge] = implicitMethod( F, F_, p0, dt, tend, maxIterations)
%Calculation of the solution of an ordinary differential equation with
%implicit method. This function can be used for the implicit methods as
%mentioned in the assignement. F and F_ will control the type of method

    %coverge boolean
    coverge =  true;

    %calculate steps for iterative solutions
    steps = tend/dt;

    % setting up the first value of the solution as the start point 
    pn = p0;
    % set the first point as p_n
    pt = p0;

    % iterating for the numbers of steps 
    for s = 1:steps
       
        [pn1, iterations] = NewtonsMethod(F,F_,pn,dt,maxIterations);
        if(iterations>=maxIterations)
            coverge = false;
        end
            
        % adding the new ponit to the solution vector 
        pt = [pt pn1];
        % setting the p_{n+1} valut to p_n to start the iteration from
        % beginning 
        pn = pn1;
    end

end