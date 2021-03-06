close all 
clc

N = [ 3 7 15 31 ];
dt_1 = [ 64 128 256 512 1024 2048 4096 ];

%explicit
for counter_t = 1:4
    
    i = counter_t;

    my_Plot(counter_t) = figure;
    
    set(my_Plot(counter_t),'name',  sprintf( '%s: t = %d / 8 ', 'Plots for explicit Euler', counter_t ),...
     'numbertitle','off');
 
    counter_plot = 1;

    for counter_N = 1:length(N)
        for counter_dt = 1:length(dt_1)

            sol_0 = ones(N(counter_N)+1, N(counter_N)+1);
            x_ = 0:1/(N(counter_N)):1;
            y_ = 0:1/(N(counter_N)):1;
            
            for i = 1:N(counter_N)+1
                sol_0(i,1) = 0;
                sol_0(i,N(counter_N)+1) = 0;
                sol_0(1,i) = 0;
                sol_0(N(counter_N)+1,i) = 0;
            end

            for time = 1/dt_1(counter_dt):1/dt_1(counter_dt):counter_t/8
                sol_1 = explicitEuler_step( N(counter_N), N(counter_N), 1/dt_1(counter_dt), sol_0 );
                sol_0 = sol_1;
            end

            %Plot results
            subplot (length(N), length(dt_1), counter_plot ); 
            surf( y_, x_, sol_1);
            
            %set title of plot
            title( sprintf( 'N_x=N_y=%d  dt=1/%d',  N(counter_N), dt_1(counter_dt)));
 
            counter_plot = counter_plot + 1;
        end 
    end
end


% dt = 1/64 for Implicid 
counter_dt = 1;

accuracy = 10^-6;

my_Plot(counter_t + 4) = figure;

set(my_Plot(counter_t + 4),'name',  sprintf( '%s: dt = 1/%d', 'Plots for implicit', dt_1(counter_dt) ),...
 'numbertitle','off');

% reset Plot counter
counter_plot = 1;

for counter_t = 1:4
    for counter_N = 1:length(N)
        

        sol_0 = ones(N(counter_N)+1, N(counter_N)+1);
        x_ = 0:1/(N(counter_N)):1;
        y_ = 0:1/(N(counter_N)):1;

        for i = 1:N(counter_N)+1
            sol_0(i,1) = 0;
            sol_0(i,N(counter_N)+1) = 0;
            sol_0(1,i) = 0;
            sol_0(N(counter_N)+1,i) = 0;
        end

        for time = 1/dt_1(counter_dt):1/dt_1(counter_dt):counter_t/8
            sol_1 = implicitEuler_step( N(counter_N), N(counter_N), 1/dt_1(counter_dt), sol_0 , accuracy);
            sol_0 = sol_1;
        end

        %Plot results
        subplot (length(N), 4, counter_plot ); 
        surf( y_, x_, sol_1);

        %set title of plot
        title( sprintf( 'N_x=N_y=%d  t end = %d/8',  N(counter_N), counter_t ));

        counter_plot = counter_plot + 1;

    end
end



