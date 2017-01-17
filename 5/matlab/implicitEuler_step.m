function solution_next_timestep = implicitEuler_step(N_x, N_y , dt, solution_current_time)

    % Compute coefficients
    NorthSouth = dt / (1/N_y)^2;
    EastWest = dt / (1/N_x)^2;
    Main = 1.0 / ( 1.0 + 2.0 * ( NorthSouth + EastWest ));

    solution_next_timestep =  zeros(N_x, N_y);
    
    for j=2:N_y-1
        for i=2:N_x-1
            solution_next_timestep( i,j ) = ... 
               Main * ( NorthSouth * ( solution_current_time( i, j - 1 ) + solution_current_time( i, j + 1 ) ) ...
                        + EastWest * ( solution_current_time( i - 1, j ) + solution_current_time( i + 1, j ) ) ...
                        + solution_current_time( i,j ) );
        end
    end        

end