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
    legend('alytical solution', 'dt:  1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    
%------------------------------------
% e)
    %Adams Moulton lin 1
    my_Plot_e_1 = figure;
    hold on;
    plot(t_analitical_solution, analitical_solution,'color','r');
    % set window name 
    set(my_Plot_e_1,'name', 'Workshet 3, e 1 Adams Moulton lin 1', 'numbertitle','off');
    %set title of plot
    title('Graph of Adams Moulton lin 1:');
    axis([-0.5 5.5 -0.5 20.5]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
    for i = 1:iterations
        %calculate timsteps
        dt(i) = dtin / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend;
        F = @(yn1,yn) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn*(1-(yn1/10)))));
        F_= @(yn1,yn) 1+(.35*dt*yn);
        plot(tb, adamMoultonlin1(F, F_, p0, dt(i), tend), '--x');
    end 
    legend('alytical solution', 'dt:  1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    
    %Adams Moulton lin 2 
    my_Plot_e_2 = figure;
    hold on;
    plot(t_analitical_solution, analitical_solution,'color','r');
    % set window name 
    set(my_Plot_e_2,'name', 'Workshet 3, e 2 Adams Moulton lin 2', 'numbertitle','off');
    %set title of plot
    title('Graph of Adams Moulton lin 2  solution:');
    axis([-0.5 5.5 -0.5 20.5]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
    for i = 1:iterations
        %calculate timsteps
        dt(i) = dtin / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend;
        F = @(yn1,yn) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn/10)))));
        F_= @(yn1,yn) 1-(3.5*dt*(1-0.1*yn));
        plot(tb, adamMoultonlin2(F, F_, p0, dt(i), tend), '--x');
    end 
    legend('alytical solution', 'dt:  1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    
end
