close all; %to close all plots 
clear all;
clc;

%------------------------------------
% input Parameters in Functions
% p_() is the ordinary differential equatio
% p() is the analytical solution
%------------------------------------
% given Values 
% p(0) = 1 
%------------------------------------
% boundry conditions
% p_ = F(y)
% y(0) = y0
%------------------------------------

%from boundry conditions 
p0 = 1;

%start time 
t0 = 0;

% end time to 15 seen from p() that a stabil form is reatched on 
tend = 15;

% starting time step 
dtin = 1;


% this is creatig 4 Grapfs 
for i = 0:3 
    
    % difine time steps 1, 0.5, 0.25 , 0.125
    dt = dtin / power(2, i);

    % define array for analitical solution 
    t = t0:dt:tend;
    
    %clalculate steps for iterative solutions
    steps = (tend)/dt;

    % calculate analitical solution (pt) for all points 
    pt =  p(t);
    
    % calculate the derivative (dpt) frome the analitical solution using the
    % ordinary differential equation
    dpt = p_(pt);

    
    % using @p_ as lambda expressions for claculating the solution
    % calculate the iterative solution with explicit Euler
    pt_e = explicitEuler(@p_, dt, p0, steps);
    
    % calculate the iterative solution with method of Heun
    pt_h = methodOfHeun(@p_ , dt, p0, steps);
    
    % calculate the iterative solution with Runge Kutta metho
    pt_rk = rungeKuttaMethod(@p_ , dt, p0, steps);
    
    %creating plots for each time step size  
    % best display on 1920/1080 pixel window sice 
    my_Plot = figure;
    hold on;
    
    % set window name 
    set(my_Plot,'name', strcat('Solution with dt:', num2str(dt)), 'numbertitle','off');
    %set title of plot
    title(strcat( 'Graph of ordinary differential equatio with timestep:', num2str(dt)));
    %set axis for text display and solution plot 
    axis([-4 15 -2 12]) ;
    
    %ploting the analitical solution in red and as a line 
    plot(t, pt,'color','r');
    
    %ploting the derivertive solution in red and as a dashed line 
    plot(t, dpt, '--', 'color','r'); 
    
    %ploting the solution of explicit Euler in blue and with +
    plot(t, pt_e,'+','color','b');
    
    %ploting the solution of method of Heun in green and with x
    plot(t, pt_h , 'x','color','g');
    
    %ploting the solution of Runge Kutta metho in black and with .
    plot(t, pt_rk, '.','color','k');
    
    %set lable for the plots 
    legend('p(t)', 'dp(t)','explicit Euler', 'method Of Heun' ,'Runge-Kutta Method')

    % unsing text filds in the second quadrant for display of the error 
    % error from Analytical solution to explicit Euler solution
    text( -3.5 , 11  , 'E_{Euler}:');
    text( -1.5 , 11  , num2str( approximationError(  pt , pt_e, dt, tend )));
    % error from Analytical solution to method of Heun solution
    text( -3.5 ,  9  , 'E_{Heun}:'  ); 
    text( -1.5 ,  9  , num2str( approximationError(  pt , pt_h, dt, tend)));
    % error from Analytical solution to Runge Kutta metho solution
    text( -3.5 ,  7   , 'E_{RungeK}: ');
    text( -1.5 ,  7   , num2str( approximationError(  pt , pt_rk, dt, tend)));
    % display the time step size 
    text( -3.5 ,  5  , 'dt: ' );
    text( -1.5 ,  5   , num2str(dt));
    % Aproximated error on Runge Kutta 
    % error from Runge Kutta solution to explicit Euler solution
    text( -3.5 ,  3  , 'E^~_{Euler}:');
    text( -1.5 ,  3  , num2str( approximationError(  pt_rk , pt_e, dt, tend )));
    % error from Runge Kutta solution to method of Heun solution
    text( -3.5 ,  1  , 'E^~_{Heun}:'  ); 
    text( -1.5 ,  1  , num2str( approximationError(  pt_rk , pt_h, dt, tend)));

end 



