function [ pt ] = implicitEuler( p0, tstep, tend)
% This function defines the right hand side f, the first derivative of the right hand side
%with respect to y, initial value p0, the stepsize dt and the end time tend. The output
%of the function is a vector containing all computed approximate values for
%y using Adam Mouldton Method by linerisation method 2
    F = @(yn1,yn,dt) yn1-(7*dt.*yn1.*(1-(yn1/10)))-yn; 
    F_= @(yn1,yn,dt) 1-(7*dt*(1-yn1/5));
    [ pt ] = implicitMethod( F, F_, p0, tstep, tend);

end