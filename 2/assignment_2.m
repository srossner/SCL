function assignment_2()
close all; %to close all plots 
clear all;
clc;

%------------------------------------
% input Parameters in Functions
% p_() is the ordinary differential equation
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

% end time to 15 seen from p() that a stable form is reached on 
tend = 5;

% starting time step 
dtin = 1;

%number of steps 
iterations = 4;

%allocating memmory
E_e  = 1:iterations;
E_h  = 1:iterations;
E_rk = 1:iterations;
my_Plot =  1:iterations;


% this is creatig 4 Graphs
for i = iterations:-1:1
    
    % define time steps  0.125, 0.25 , 0.5, 1
    dt = dtin / power(2, i-1);

    % define array for analytical solution 
    t = t0:dt:tend;
    
    %calculate steps for iterative solutions
    steps = (tend)/dt;

    % calculate analytical solution (pt) for all points 
    pt =  p(t);
    
    % calculate the derivative (dpt) frome the analytical solution using the
    % ordinary differential equation
    dpt = p_(pt);
    
    % using @p_ as lambda expressions for calculating the solution
    % calculate the iterative solution with explicit Euler
    pt_e{i} = explicitEuler(@p_, dt, p0, steps);
    
    % calculate the iterative solution with method of Heun
    pt_h{i} = methodOfHeun(@p_ , dt, p0, steps);
    
    % calculate the iterative solution with Runge Kutta metho
    pt_rk{i} = rungeKuttaMethod(@p_ , dt, p0, steps);

    % calculating the error
    E_e(i)  = approximationError(  pt , pt_e{i} , dt, tend);
    E_h(i)  = approximationError(  pt , pt_h{i} , dt, tend);
    E_rk(i) = approximationError(  pt , pt_rk{i}, dt, tend);
    
    % adding text for the previous figure because next step size solution is
    % needed
    if(i < 4)
        % calculation the error reduction from getting smaller steps
        text( -2 , 10 , strcat('error red.:', num2str( E_e(i)  / E_e(i+1))));
        text( -2 , 8  , strcat('error red.:', num2str( E_h(i)  / E_h(i+1))));
        text( -2 , 6  , strcat('error red.:', num2str( E_rk(i) / E_rk(i+1))));
    end
    
    %creating plots for each time step size  
    % best display on 1920/1080 pixel window size 
    my_Plot(i) = figure;
    hold on;
    
    % set window name 
    set(my_Plot(i),'name', strcat('Solution with dt:', num2str(dt)), 'numbertitle','off');
    %set title of plot
    title(strcat( 'Graph of ordinary differential equatio with timestep:', num2str(dt)));
    %set axis for text display and solution plot 
    axis([-4.5 6 -3 11]) ;
    
    %ploting the analitical solution in red and as a line 
    plot(t, pt,'color','r');
    
    %ploting the derivertive solution in red and as a dashed line 
    plot(t, dpt, '--', 'color','r'); 
    
    %ploting the solution of explicit Euler in blue and with +
    plot(t, pt_e{i},'+','color','b');
    
    %ploting the solution of method of Heun in green and with x
    plot(t, pt_h{i} , 'x','color','g');
    
    %ploting the solution of Runge Kutta metho in black and with .
    plot(t, pt_rk{i}, '.','color','k');
    
    %set lable for the plots 
    legend('p(t)', 'dp(t)','explicit Euler', 'method Of Heun' ,'Runge-Kutta Method')
    


    % unsing text filds in the second quadrant for display of the error 
    % error from Analytical solution to explicit Euler solution
    text( -4 , 10  , 'E_{Euler}:');
    text( -3 , 10  , num2str( E_e(i)  ));

    % error from Analytical solution to method of Heun solution
    text( -4 ,  8  , 'E_{Heun}:'  ); 
    text( -3 ,  8  , num2str( E_h(i) ));

    % error from Analytical solution to Runge Kutta method solution
    text( -4 ,  6   , 'E_{RungeK}: ');
    text( -3 ,  6   , num2str( E_rk(i) ));

    % display the time step size 
    text( -4 ,  4  , 'dt: ' );
    text( -3 ,  4   , num2str(dt));

    % Aproximated error on best solution with smallest time step 
    % Aproximated error explicit Euler solution
    text( -4 ,  2  , 'E^~_{Euler}:'  ); 
    text( -3 ,  2  , num2str( approximationError(  pt_e{4} , pt_e{i}, dt, tend )));
    % Aproximated error from method of Heun solution
    text( -4 ,  0  , 'E^~_{Heun}:'  ); 
    text( -3 ,  0  , num2str( approximationError(  pt_h{4} , pt_h{i}, dt, tend)));
    % Aproximated error from Runge Kutta method solution
    text( -4 ,  -2  , 'E^~_{RungeK}:'  ); 
    text( -3 ,  -2  , num2str( approximationError(  pt_rk{4} , pt_rk{i}, dt, tend)));
    
end 
end
