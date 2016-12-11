function [ solution ] = performAlgorithmExplicit( t0, tend, dt_start, iterations,...
                                 t_analitical_solution, analitical_solution,...
                                 Algorithm, ordinaryDifferentialEquation,...
                                 initialValue , ...
                                 String_Worksheet, String_AlgorithmName )

    my_Plot = figure;
    hold on;
    %plotting analytical solution
    plot(t_analitical_solution, analitical_solution,'color','r');
    
    % set window name     
    set(my_Plot,'name',  sprintf( '%s: %s', String_Worksheet, String_AlgorithmName),...
        'numbertitle','off');
    
    %set title of plot
    title( strcat(string('Graph of '), String_AlgorithmName , string(' solution:')));
    axis([-0.5 5.5 -0.5 20.5]) ;
    a_x = gca;
    a_x.XAxisLocation = 'origin';
    a_x.YAxisLocation = 'origin';
    
    dt = 1:iterations;
    
    for i = 1:iterations
        %calculate timsteps
        dt(i) = dt_start / power(2, i-1);
        % define time for aproximation 
        tb = t0:dt(i):tend;
        solution{i} = Algorithm(ordinaryDifferentialEquation, initialValue,...
        dt(i), tend);
        plot(tb, solution{i} , '--x');
    end 
    
    
end

