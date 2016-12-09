function [ pt ] = adamMoultonlin2(p0, tstep, tend)
% This function defines the right hand side f, the first derivative of the right hand side
%with respect to y, initial value p0, the stepsize dt and the end time tend. The output
%of the function is a vector containing all computed approximate values for
%y using Adam Mouldton Method by linerisation method 2
    F = @(yn1,yn,dt) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn/10)))));
    F_= @(yn1,yn,dt) 1-(3.5*dt*(1-0.1*yn));
    [ pt ] = implicitMethod( F, F_, p0, tstep, tend);
end