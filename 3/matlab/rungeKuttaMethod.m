function [ pt ] = rungeKuttaMethod(p_, p0, dt, tend)
%UNTITLED Calculation the next step of an ordinary differential equatio with
%Runge Kutta method

    %calculate steps for iterative solutions
    steps = tend/dt;

    % setting up the first value of the solution as the start point 
    pn = p0;
    % set the firs pont as p_n
    pt = p0;
    
    % iterating for the numbers of steps    
    for s = 1:steps
       
        %calculation four points to get the solution using four evaluation
        %of p_() 
        k1 = p_(  pn  );
        
        k2 = p_(  pn + 0.5 * dt * k1 ) ;
        
        k3 = p_(  pn + 0.5 * dt * k2 ) ;
        
        k4 = p_(  pn + dt * k3 );

        %summing the four points and using the middle ones twice gives 6
        %points, normalize it back with 1/6 for calculation of the next point
        pn1 = pn + 1/6 * dt * ( k1 + 2 * k2 + 2 * k3 + k4 );
        
        % adding the new point to the solution vector 
        pt = [pt pn1];
        % setting the p_{n+1} valut to p_n to start the iteration from
        % begining 
        pn = pn1;
    end

end


