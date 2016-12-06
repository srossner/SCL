function [ pt ] = methodOfHeun(p_, p0, dt, tend)
%UNTITLED Calculation the next step of an ordinary differential equation with
%method of Heun
    
    %calculate steps for iterative solutions
    steps = tend/dt;
    
    % setting up the first value of the solution as the start point 
    pn = p0;
    % set the first point as p_n
    pt = p0;
    
    % iterating for the numbers of steps    
    for s = 1:steps
        %calculation the next step with an explicitEulerStep and another
        %evaluation of p_()
        k1 = p_(  pn  );
        k2 = p_(  pn + dt * k1 ) ;
        
        pn1 = pn + 0.5 * dt * ( k1 + k2 );
        % adding the new point to the solution vector 
        pt = [pt pn1];
        % setting the p_{n+1} valut to p_n to start the iteration from
        % begining 
        pn = pn1;
    end

end


