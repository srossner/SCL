function assignment_3()
close all; %to close all plots 
clear all;
clc;

%------------------------------------
% input Parameters in Functions
% p_() is the ordinary differential equation (1)
% p() is the analytical solution 
%------------------------------------
% given Values 
% p(0) = 20 (2)
%initial value 
p0 = 20;
%------------------------------------
% initial conditions
% p(0) = 20 
% p_ = f(y)
% y(0) = y0
%------------------------------------
% Time Range t is [0,5]
%start time 
t0 = 0;
% end time
tend = 5;
% starting time step 
dtin = 1;
%number of time step variants
iterations = 6;
%------------------------------------

%------------------------------------
%a) 
    my_Plot_a = figure;
    hold on;
    xAStart = -5;
    xAEnd = 6;
    yAStart = -5;
    yAEnd = 21; 
    %Plot direction fild for the ordinary differential equation (1)
    dirField(@p_, yAStart: (yAEnd-yAStart)/25:yAEnd, xAStart:(xAEnd-xAStart)/25:xAEnd);
    %define timsteps for plottig analytical solution 
    t_analitical_solution = linspace(t0, tend);
    analitical_solution = p(t_analitical_solution);
    %ploting the analytical solution in red and as a line 
    plot(t_analitical_solution, analitical_solution,'color','r', 'LineWidth' , 3);
    % set window name 
    set(my_Plot_a,'name', 'Workshet 3, a', 'numbertitle','off');
    %set title of plot
    title('Graph of Analytical Solution:');
    legend('Direction Fild', 'Analytical Solution');
    axis([xAStart xAEnd yAStart yAEnd]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
%------------------------------------
%b) 
    %explicit Euler
    my_Plot_b_1 = figure;
    hold on;
    %plotting analytical solution
    plot(t_analitical_solution, analitical_solution,'color','r');
    % set window name 
    set(my_Plot_b_1,'name', 'Workshet 3, b 1 explicit Eeuler', 'numbertitle','off');
    %set title of plot
    title('Graph of explicit Euler solution:');
    axis([-0.5 5.5 -0.5 20.5]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
    for i = 1:iterations
        %calculate timsteps
        dt(i) = dtin / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend;
        plot(tb, explicitEuler(@p_, p0, dt(i), tend), '--x');
    end 
    legend('analytical solution', 'dt:   1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');
    
    % Heun
    my_Plot_b_2 = figure;
    hold on;
    plot(t_analitical_solution, analitical_solution,'color','r');
    % set window name 
    set(my_Plot_b_2,'name', 'Workshet 3, b 2 Method of Heun', 'numbertitle','off');
    %set title of plot
    title('Graph of Method of Heun solution:');
    axis([-0.5 5.5 -0.5 20.5]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
    for i = 1:iterations
        %calculate timsteps
        dt(i) = dtin / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend;
        plot(tb, methodOfHeun(@p_, p0, dt(i), tend), '--x');
    end 
    legend('analytical solution', 'dt:  1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');
%------------------------------------
% c) is implemented in implicitEuler.m and adamMoulton.m
%------------------------------------
% d)
    %Implicit Euler 
    my_Plot_d_1 = figure;
    hold on;
    plot(t_analitical_solution, analitical_solution,'color','r');
    % set window name 
    set(my_Plot_d_1,'name', 'Workshet 3, d 1 Implicit Euler', 'numbertitle','off');
    %set title of plot
    title('Graph of Implicit Euler solution:');
    axis([-0.5 5.5 -0.5 20.5]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
    for i = 2:iterations
        %calculate timsteps
        dt(i) = dtin / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend;
        %define the implicit equation F=0 and F_ is derivative of F
        F = @(yn1,yn,dt) yn1-(7*dt.*yn1.*(1-(yn1/10)))-yn; 
        F_= @(yn1,yn,dt) 1-(7*dt*(1-yn1/5));
        plot(tb, implicitMethod( F, F_, p0, dt(i), tend,1), '--x');
    end 
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    
    %Adams Moulton method  
    my_Plot_d_2 = figure;
    hold on;
    plot(t_analitical_solution, analitical_solution,'color','r');
    % set window name 
    set(my_Plot_d_2,'name', 'Workshet 3, d 2 Adams Moulton method', 'numbertitle','off');
    %set title of plot
    title('Graph of Adams Moulton method solution:');
    axis([-0.5 5.5 -0.5 20.5]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
    for i = 2:iterations
        %calculate timsteps
        dt(i) = dtin / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend;
        F = @(yn1,yn,dt) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn1/10))))); 
        F_= @(yn1,yn,dt) 1-(3.5*dt*(1-yn1/5)); 
        plot(tb, implicitMethod( F, F_, p0, dt(i), tend,2), '--x');
    end 
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    

%------------------------------------
% e)
    %Linearisation 1 
    my_Plot_d_1 = figure;
    hold on;
    plot(t_analitical_solution, analitical_solution,'color','r');
    % set window name 
    set(my_Plot_d_1,'name', 'Workshet 3, e 1 Linearisation 1', 'numbertitle','off');
    %set title of plot
    title('Graph of Adam Moulton Linerisation 1 solution:');
    axis([-0.5 5.5 -0.5 20.5]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
    for i = 2:iterations
        %calculate timsteps
        dt(i) = dtin / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend;
        F = @(yn1,yn,dt) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn*(1-(yn1/10)))));
        F_= @(yn1,yn,dt) 1+(.35*dt*yn);
        plot(tb, implicitMethod( F, F_, p0, dt(i), tend,3), '--x');
    end 
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    
    %Linearisation 2 
    my_Plot_d_2 = figure;
    hold on;
    plot(t_analitical_solution, analitical_solution,'color','r');
    % set window name 
    set(my_Plot_d_2,'name', 'Workshet 3, e 2 Linerisation 2 ', 'numbertitle','off');
    %set title of plot
    title('Graph of Adams Moulton Linerisation 2 solution:');
    axis([-0.5 5.5 -0.5 20.5]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
    for i = 2:iterations
        %calculate timsteps
        dt(i) = dtin / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend; 
        F = @(yn1,yn,dt) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn/10)))));
        F_= @(yn1,yn,dt) 1-(3.5*dt*(1-0.1*yn));
        plot(tb, implicitMethod( F, F_, p0, dt(i), tend,4), '--x');
    end 
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    

    
    
% this is creating 6 Graphs
for i = iterations:-1:9
    
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
        
    F = @(yn1,yn) yn1-(7*dt*yn1*(1-(yn1/10)))-yn;
    F_= @(yn1,yn) 1-(7*dt*(1-yn1/5));
    
    pt_e{i} = implicitEuler(F, F_, p0, dt(i), tend);
    
    
    %adamMoultonlin
    F = @(yn1,yn) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn1/10)))));
    F_= @(yn1,yn) 1-(3.5*dt*(1-yn1/5));
    %adamMoultonlin1
    F = @(yn1,yn) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn*(1-(yn1/10)))));
    F_= @(yn1,yn) 1+(.35*dt*yn);
    %adamMoultonlin2
    F = @(yn1,yn) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn/10)))));
    F_= @(yn1,yn) 1-(3.5*dt*(1-0.1*yn));

    if(i<3)
       pt_e{i} = adamMoultonlin2(F, F_, p0, dt(i), tend); 
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
    plot(t{iterations}, pt{iterations},'color','r');

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
