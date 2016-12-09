function [ pt ] = adamMoultonlin2( F, F_, p0, dt, tend)
%UNTITLED Calculation the solution of an ordinary differential equation with
%Adam Moulton

    %calculate steps for iterative solutions
    steps = tend/dt;

    % setting up the first value of the solution as the start point 
    pn = p0;
    % set the first point as p_n
    pt = p0;

    % iterating for the numbers of steps 
    for s = 1:steps
       
        pn1 = NewtonsMethod(F,F_,pn);
        % adding the new ponit to the solution vector 
        pt = [pt pn1];
        % setting the p_{n+1} valut to p_n to start the iteration from
        % beginning 
        pn = pn1;
    end

end