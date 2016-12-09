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
% Time Range t e[0,5]
%start time 
t0 = 0;
% end time
tend = 5;
% starting time step 
dtin = 1;
%number of steps 
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
    %define timsteps for plottig analitical solution 
    t_analitical_solution = linspace(t0, tend);
    analitical_solution = p(t_analitical_solution);
    %ploting the analitical solution in red and as a line 
    plot(t_analitical_solution, analitical_solution,'color','r', 'LineWidth' , 3);
    % set window name 
    set(my_Plot_a,'name', 'Workshet 3, a', 'numbertitle','off');
    %set title of plot
    title('Graph of analytical solution:');
    legend('Direction Fild', 'Alytical Solution');
    axis([xAStart xAEnd yAStart yAEnd]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
%------------------------------------
%b) 
    %explicit Euler
    my_Plot_b_1 = figure;
    hold on;
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
    legend('alytical solution', 'dt:   1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');
    
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
    legend('alytical solution', 'dt:  1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');
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
    for i = 1:iterations
        %calculate timsteps
        dt(i) = dtin / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend;
        F = @(yn1,yn) yn1-(7*dt*yn1*(1-(yn1/10)))-yn; 
        F_= @(yn1,yn) 1-(7*dt*(1-yn1/5)); 
        plot(tb, implicitEuler(F, F_, p0, dt(i), tend), '--x');
    end 
    legend('alytical solution', 'dt:  1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    
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
    for i = 1:iterations
        %calculate timsteps
        dt(i) = dtin / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend;
        F = @(yn1,yn) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn1/10))))); 
        F_= @(yn1,yn) 1-(3.5*dt*(1-yn1/5)); 
        plot(tb, adamMoulton(F, F_, p0, dt(i), tend), '--x');
    end 
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

