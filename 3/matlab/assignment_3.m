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
   
    performAlgorithmExplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @explicitEuler, @p_, p0, ...
        'Workshet 3, b 1', 'explicit Eeuler');
    legend('analytical solution', 'dt:   1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');
    
    % Heun
    performAlgorithmExplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @methodOfHeun, @p_, p0, ...
        'Workshet 3, b 2', ' Method of Heun');
    legend('analytical solution', 'dt:  1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');
     
%------------------------------------
% c) is implemented in implicitEuler.m and adamMoulton.m
%------------------------------------

% step 1 not includet fot Implicit methods
dtin = 0.5;
iterations = 5;
maxIterations = 200;

% d)
    %Implicit Euler 
    %define the implicit equation F=0 and F_ is derivative of F
    F = @(yn1,yn,dt) yn1-(7*dt.*yn1.*(1-(yn1/10)))-yn; 
    F_= @(yn1,yn,dt) 1-(7*dt*(1-yn1/5));
    
    performAlgorithmImplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @implicitMethod, F, F_, p0, maxIterations, ...
        'Workshet 3, d 1', 'Implicit Euler');
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    
  
    %Adams Moulton method  
  
    %define the implicit equation F=0 and F_ is derivative of F  
    F = @(yn1,yn,dt) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn1/10))))); 
    F_= @(yn1,yn,dt) 1-(3.5*dt*(1-yn1/5)); 
    
    performAlgorithmImplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @implicitMethod, F, F_, p0, maxIterations, ...
        'Workshet 3, d 2', 'Adams Moulton method');
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    
 
%------------------------------------

% e)
    %Linearisation 1 
    %define the implicit equation F=0 and F_ is derivative of F  
    F = @(yn1,yn,dt) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn*(1-(yn1/10)))));
    F_= @(yn1,yn,dt) 1+(.35*dt*yn);
    performAlgorithmImplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @implicitMethod, F, F_, p0, maxIterations, ...
        'Workshet 3, e 1', 'Adams Moulton Linearisation 1 ');
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    

    %Linearisation 2
    %define the implicit equation F=0 and F_ is derivative of F   
    F = @(yn1,yn,dt) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn/10)))));
    F_= @(yn1,yn,dt) 1-(3.5*dt*(1-0.1*yn));
    performAlgorithmImplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @implicitMethod, F, F_, p0, maxIterations, ...
        'Workshet 3, e 2', 'Adams Moulton Linearisation 2 '); 
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    

end
 
   