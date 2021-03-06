function assignment_3()
close all; %to close all plots 
clear all;
clc;cl

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
    
    solution_explicit_Euler = ...
    performAlgorithmExplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @explicitEuler, @p_, p0, ...
        'Workshet 3, b 1', 'explicit Eeuler');
    legend('analytical solution', 'dt:   1', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');
    
    % Method of Heun
    solution_MethodOfHeun = ...
    performAlgorithmExplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @methodOfHeun, @p_, p0, ...
        'Workshet 3, b 2', 'Method of Heun');
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
    
    solution_ImplicitEuler = ...
    performAlgorithmImplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @implicitMethod, F, F_, p0, maxIterations, ...
        'Workshet 3, d 1', 'Implicit Euler');
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    
  
    %Adams Moulton method  
  
    %define the implicit equation F=0 and F_ is derivative of F  
    F = @(yn1,yn,dt) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn1/10))))); 
    F_= @(yn1,yn,dt) 1-(3.5*dt*(1-yn1/5)); 
    
    solution_AdamsMoulton = ...
    performAlgorithmImplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @implicitMethod, F, F_, p0, maxIterations, ...
        'Workshet 3, d 2', 'Adams Moulton method');
    legend('analytical solution', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    
 
%------------------------------------

% e)
    %Linearisation 1 
    %define the implicit equation F=0 and F_ is derivative of F  
    F = @(yn1,yn,dt) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn*(1-(yn1/10)))));
    F_= @(yn1,yn,dt) 1+(.35*dt*yn);
    
    solution_AdamsMoultonLin1 = ...
    performAlgorithmImplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @implicitMethod, F, F_, p0, maxIterations, ...
        'Workshet 3, e 1', 'Adams Moulton Linearisation 1 ');
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    

    %Linearisation 2
    %define the implicit equation F=0 and F_ is derivative of F   
    F = @(yn1,yn,dt) yn1-yn-(3.5*dt*((yn*(1-(yn/10)))+(yn1*(1-(yn/10)))));
    F_= @(yn1,yn,dt) 1-(3.5*dt*(1-0.1*yn));
    
    solution_AdamsMoultonLin2 = ...
    performAlgorithmImplicit( t0, tend, dtin, iterations, ...
        t_analitical_solution, analitical_solution,...
        @implicitMethod, F, F_, p0, maxIterations, ...
        'Workshet 3, e 2', 'Adams Moulton Linearisation 2 '); 
    legend('analytical solution', 'dt:  1/2', 'dt:  1/4', 'dt:  1/8', 'dt: 1/16','dt: 1/32');    

    error_explicit_Euler    = 1:iterations;
    error_MethodOfHeun      = 1:iterations;
    error_ImplicitEuler     = 1:iterations;
    error_AdamsMoulton      = 1:iterations;
    error_AdamsMoultonLin1  = 1:iterations;
    error_AdamsMoultonLin2  = 1:iterations;
    error_red_explicit_Euler= 1:iterations;
    error_red_MethodOfHeun  = 1:iterations;
    error_red_ImplicitEuler = 1:iterations;
    error_red_AdamsMoulton  = 1:iterations;
    error_red_AdamsMoultonLin1= 1:iterations;
    error_red_AdamsMoultonLin2= 1:iterations;
    
    for i = 1:iterations
        
        dt = dtin / power(2, i-1);
        
        t_analitical_solution = t0 : dt: tend;
        analitical_solution = p(t_analitical_solution);
        
        %explicit i+1 because they start at dt=1 and not at dt=0.5
        error_explicit_Euler(i) = ...
            approximationError(analitical_solution, solution_explicit_Euler{i+1},...
                                 dt, tend);      
        error_MethodOfHeun(i) = ...
            approximationError(analitical_solution, solution_MethodOfHeun{i+1},...
                                 dt, tend);
        error_ImplicitEuler(i) = ...
            approximationError(analitical_solution, solution_ImplicitEuler{i},...
                                 dt, tend);                            
        error_AdamsMoulton(i) = ...
            approximationError(analitical_solution, solution_AdamsMoulton{i},...
                                 dt, tend);
        error_AdamsMoultonLin1(i) = ...
            approximationError(analitical_solution, solution_AdamsMoultonLin1{i},...
                                 dt, tend);
        error_AdamsMoultonLin2(i) = ...
            approximationError(analitical_solution, solution_AdamsMoultonLin2{i},...
                                dt, tend);
        if( i > 1)
            error_red_explicit_Euler(i)    = error_explicit_Euler(i-1)/error_explicit_Euler(i);
            error_red_MethodOfHeun(i)      = error_MethodOfHeun(i-1)/error_MethodOfHeun(i);
            error_red_ImplicitEuler(i)     = error_ImplicitEuler(i-1)/error_ImplicitEuler(i);
            error_red_AdamsMoulton(i)      = error_AdamsMoulton(i-1)/error_AdamsMoulton(i);
            error_red_AdamsMoultonLin1(i)  = error_AdamsMoultonLin1(i-1)/error_AdamsMoultonLin1(i);
            error_red_AdamsMoultonLin2(i)  = error_AdamsMoultonLin2(i-1)/error_AdamsMoultonLin2(i);
        else
            error_red_explicit_Euler(i)    = 0;
            error_red_MethodOfHeun(i)      = 0;
            error_red_ImplicitEuler(i)     = 0;
            error_red_AdamsMoulton(i)      = 0;
            error_red_AdamsMoultonLin1(i)  = 0;
            error_red_AdamsMoultonLin2(i)  = 0;
           
        end
    end
    
    addpath ../../Submodules/matlabTableFramework/;
    % The first spet is defining a Mode for a table.
    % The should be at least one Mode in order to print a tabble
    CoulmnsName = {'1/2' '1/4' '1/8' '1/16' '1/32'};
    RowsName = {'Error', 'Error red.'};
    FirstMode = TableMode( CoulmnsName, RowsName  );

    % Create a table with a particular titel
    TestTable = SpecificTable('Assigment 3');

    % Add a Mode to the TestTable
    TestTable.addMode( FirstMode );

    % Add new tables
    TestTable.addTable( [error_explicit_Euler ; error_red_explicit_Euler] , 'Explicit Euler' );
    TestTable.addTable( [error_MethodOfHeun ; error_red_MethodOfHeun] , 'Method Of Heun' );
    TestTable.addTable( [error_ImplicitEuler ; error_red_ImplicitEuler] , 'Implicit Euler' );
    TestTable.addTable( [error_AdamsMoulton ; error_red_AdamsMoulton] , ' Adams Moulton' );
    TestTable.addTable( [error_AdamsMoultonLin1 ; error_red_AdamsMoultonLin1] , ' Adams Moulton Lin1' );
    TestTable.addTable( [error_AdamsMoultonLin2 ; error_red_AdamsMoultonLin2] , ' Adams Moulton Lin2' );
    
    % Define and add a new mode
    CoulmnsName = {'explcit|Euler' 'Heun' ...
                                'implicit|Euler' 'Adams-|-Moulton' ...
                                'Adams-|-Moulton|l1' 'Adams-|-Moulton|l2' };
    RowsName = {'1/2' '1/4' '1/8' '1/16' '1/32'};
    SecondMode = TableMode( CoulmnsName, RowsName  );
    TestTable.addMode( SecondMode );
    
    equilibriumPoint = 10;
    
    for i = 1:iterations
        Stable_cases_explicit_Euler{i}   = isMethodStable(solution_explicit_Euler{i + 1},p0,equilibriumPoint ) ;
        Stable_cases_MethodOfHeun{i}     = isMethodStable(solution_MethodOfHeun{i + 1},p0,equilibriumPoint ) ;
        Stable_cases_ImplicitEuler{i}    = isMethodStable(solution_ImplicitEuler{i},p0,equilibriumPoint ) ;
        Stable_cases_AdamsMoulton{i}     = isMethodStable(solution_AdamsMoulton{i},p0,equilibriumPoint ) ;
        Stable_cases_AdamsMoultonLin1{i} = isMethodStable(solution_AdamsMoultonLin1{i},p0,equilibriumPoint ) ;
        Stable_cases_AdamsMoultonLin2{i} = isMethodStable(solution_AdamsMoultonLin2{i},p0,equilibriumPoint ) ;

    end    
    
    for i = 1:iterations
        strings{i} = { Stable_cases_explicit_Euler{i} Stable_cases_MethodOfHeun{i} Stable_cases_ImplicitEuler{i} Stable_cases_AdamsMoulton{i} Stable_cases_AdamsMoultonLin1{i} Stable_cases_AdamsMoultonLin2{i} };
    end 
    
    % pring a table with new mode
    TestTable.addTable( [ strings{1} ; strings{2} ; strings{3}; strings{4}; strings{5}], 'Stable Cases');

    % write all stability cases in console as a table
	CoulmnsName = { 'explcitEuler' 'Heun' ...
                    'implicitEuler' 'AdamsMoulton' ...
                    'AdamsMoultonLin1' 'AdamsMoultonLin2' };
                
    StableCases = table ( Stable_cases_explicit_Euler',...
                             Stable_cases_MethodOfHeun', ...
                             Stable_cases_ImplicitEuler', ...
                             Stable_cases_AdamsMoulton',...
                             Stable_cases_AdamsMoultonLin1',...
                             Stable_cases_AdamsMoultonLin2',...
                             'RowNames', RowsName', ...
                             'VariableNames', CoulmnsName )

end
 
   