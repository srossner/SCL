function [ pt ] = methodOfHeun( p_ , dt, p0, steps)
%UNTITLED Calculation the next step of an ordinary differential equatio with
%method Of Heun

    % setting up the first value of the solution as the start point 
    pn = p0;
    % set the firs pont as p_n
    pt = p0;
    
    % iterating for the numbers of steps    
    for s = 1:steps
        %calculation the next step whit an explicitEulerStep and another
        %evaluation of p_()
        pn1 = pn + dt * p_(  explicitEulerStep(p_, dt/2, pn) );
        % adding the new ponit to the solution vector 
        pt = [pt pn1];
        % setting the p_{n+1} valut to p_n to start the iteration from
        % beginning 
        pn = pn1;
    end

end


