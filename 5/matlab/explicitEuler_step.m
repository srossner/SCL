function [ solution_next_timestep ] = explicitEuler_step( N_x, N_y, dt, solution_current_timestep )

    h_x_p2 = (1/N_x)^2;
    h_y_p2 = (1/N_y)^2;

    solution_next_timestep = zeros(N_x+1, N_y+1);
    
    for i = 2:N_x
        for j = 2:N_y
            k_x = ( ( solution_current_timestep(i-1, j) - (2 * solution_current_timestep(i, j)) + solution_current_timestep(i + 1, j) ) / h_x_p2 );
            k_y = ( ( solution_current_timestep(i, j-1) - (2 * solution_current_timestep(i, j)) + solution_current_timestep(i, j + 1) ) / h_y_p2 );
            
            k = k_x + k_y;
            
            solution_next_timestep(i, j) = solution_current_timestep(i, j) + dt * k;
        end
    end

end

