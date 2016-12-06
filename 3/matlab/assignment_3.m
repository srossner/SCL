function assignment_3()
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

%initial value 
p0 = 20;

%start time 
t0 = 0;

tend = 5;

% starting time step 
dtin = 1;

%number of steps 
iterations = 6;

%allocating memmory
E_e  = 1:iterations;
E_h  = 1:iterations;
E_rk = 1:iterations;
my_Plot =  1:iterations;


% this is creating 6 Graphs
for i = iterations:-1:1
    
    % define time steps  1,1/2,1/4,1/8,1/16,1/32
    dt(i) = dtin / power(2, i-1);

    % define array for analytical solution 
    t{i} = t0:dt(i):tend;

    % calculate analytical solution (pt) for all points 
    pt{i} =  p(t{i});

    % calculate the derivative (dpt) from the analytical solution using the
    % ordinary differential equation
    %dpt = p_(pt);

    % using @p_ as lambda expressions for calculating the solution
    % calculate the iterative solution with explicit Euler
    pt_e{i} = explicitEuler(@p_, p0, dt(i), tend);
    if(i==2)
        pt_e{i}(4)
        pt_e{i} 
    end
    % calculate the iterative solution with method of Heun
    pt_h{i} = methodOfHeun(@p_, p0, dt(i), tend);
    
    % calculate the iterative solution with Runge Kutta method
    pt_rk{i} = rungeKuttaMethod(@p_, p0, dt(i), tend);
    
    % calculating the error
    E_e(i)  = approximationError( pt{i} , pt_e{i} , dt(i), tend);
    E_h(i)  = approximationError( pt{i} , pt_h{i} , dt(i), tend);
    E_rk(i) = approximationError( pt{i} , pt_rk{i}, dt(i), tend);

    % adding text for the previous figure because next step size solution is
    % needed
    if(i < 6)
        %calculation the error reduction from getting smaller steps
        text( -2 , 10 , strcat('error red.:', num2str( E_e(i)  / E_e(i+1))));
        text( -2 , 8  , strcat('error red.:', num2str( E_h(i)  / E_h(i+1))));
        text( -2 , 6  , strcat('error red.:', num2str( E_rk(i) / E_rk(i+1))));
    end 

    %creating plots for each time step size  
    % best display on 1920/1080 pixel window size 
    my_Plot(i) = figure;
    hold on;

    % set window name 
    set(my_Plot(i),'name', strcat('Solution with dt:', num2str(dt(i))), 'numbertitle','off');
    %set title of plot
    title(strcat( 'Graph of ordinary differential equatio with timestep:', num2str(dt(i))));
    %set axis for text display and solution plot 
    axis([-4.5 6 -3 25]) ;

    %ploting the analitical solution in red and as a line 
    plot(t{i}, pt{i},'color','r');

    %ploting the derivertive solution in red and as a dashed line 
    %plot(t{i}, dpt, '--', 'color','r'); 

    %ploting the solution of explicit Euler in blue and with +
    plot(t{i}, pt_e{i},'+','color','b');

    %ploting the solution of method of Heun in green and with x
    plot(t{i}, pt_h{i} , 'x','color','g');

    %ploting the solution of Runge Kutta method in black and with .
    plot(t{i}, pt_rk{i}, '.','color','k');

    %set lable for the plots 
    legend('p(t)', 'explicit Euler', 'method Of Heun' ,'Runge-Kutta Method')

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
    text( -3 ,  4   , num2str(dt(i)));

    % Aproximated error on best solution with smallest time step 
    % Aproximated error explicit Euler solution
    text( -4 ,  2  , 'E^~_{Euler}:'  ); 
    text( -3 ,  2  , num2str( approximationError(  pt_e{6} , pt_e{i}, dt(i), tend )));
    % Aproximated error from method of Heun solution
    text( -4 ,  0  , 'E^~_{Heun}:'  ); 
    text( -3 ,  0  , num2str( approximationError(  pt_h{6} , pt_h{i}, dt(i), tend)));
    % Aproximated error from Runge Kutta method solution
    text( -4 ,  -2  , 'E^~_{RungeK}:'  ); 
    text( -3 ,  -2  , num2str( approximationError(  pt_rk{6} , pt_rk{i}, dt(i), tend)));

end
%{
for method =  1:3
    %creating plots for each time step size  
    % best display on 1920/1080 pixel window size 
    my_Plot(i) = figure;
    hold on;

    %ploting the analitical solution in red and as a line 
    plot(t{4}, pt{4},'color','r');

    switch(method)
        case 1 
            % set window name 
            set(my_Plot(i),'name', 'Explicit Euler', 'numbertitle','off');
            %set title of plot
            title('Graph of ordinary differential equatio with explicit Euler:');
            solution = pt_e;
        case 2 
            % set window name 
            set(my_Plot(i),'name', 'Method of Heun', 'numbertitle','off');
            %set title of plot
            title('Graph of ordinary differential equatio with method of Heun:');
            solution = pt_h;
        case 3 
            % set window name 
            set(my_Plot(i),'name', 'Runge Kutta method', 'numbertitle','off');
            %set title of plot
            title('Graph of ordinary differential equatio with Runge Kutta method:');
            solution = pt_rk;
    end

    plot(t{4}, solution{4}, 'x','color','k'); 
    plot(t{3}, solution{3}, 'x','color','b');
    plot(t{2}, solution{2}, 'x','color','g');
    plot(t{1}, solution{1}, 'x','color','c');
    %set lable for the plots 
    legend('p(t)', 'dt: 1', 'dt: 0.5' ,'dt: 0.25', 'dt: 0.125')
    
end

    my_Plot_error = figure;
    hold on;
    set(my_Plot_error,'name', 'Error', 'numbertitle','off');
    %set title of plot
    title('Error:');

    plot(1:4, E_e ,'color','k');
    plot(1:4, E_h ,'color','b');
    plot(1:4, E_rk,'color','r');
    
    xlabel('dt in 1/2^{(x-1)}')
    
    legend('Explicit Euler', 'Method of Heun', 'Runge Kutta method' )

%}

end
