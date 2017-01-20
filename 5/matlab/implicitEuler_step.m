function solution_next_timestep = implicitEuler_step(N_x, N_y , dt, Solution_current_time, accuracy)

    % Compute coefficients
    NorthSouth = dt * (N_y^2);
    EastWest = dt * (N_x^2);
    InverseMain = ( 1.0 + 2.0 * ( NorthSouth + EastWest ));
    Main = 1.0 / InverseMain;
    InverseNodesNumber = 1.0 / ( N_x * N_y );
  
    h_x_p2 = (1/N_x)^2;
    h_y_p2 = (1/N_y)^2;
    
    
    solution_next_timestep =  zeros(N_x+1, N_y+1);


    % Run the Gauss-Seidel method
    Residual = 1;
    while( Residual > accuracy )

        % Make Gauss-Seidel iteretion
        for j=2:N_y
            for i=2:N_x
                solution_next_timestep( i,j ) = ... 
                   Main * ( NorthSouth * ( Solution_current_time( i, j - 1 ) + Solution_current_time( i, j + 1 ) ) ...
                               + EastWest * ( Solution_current_time( i - 1, j ) + Solution_current_time( i + 1, j ) ) ...
                               +  Solution_current_time( i,j ) );
            end
        end



        % Compute residual
        Residual = 0; 

        for j=2:N_y
            for i=2:N_x
                TemporalVariable = ... 
                   Solution_current_time( i,j ) + ...
                   NorthSouth * ( solution_next_timestep( i, j - 1 ) + solution_next_timestep( i, j + 1 ) ) ...
                               + EastWest * ( solution_next_timestep( i - 1, j ) + solution_next_timestep( i + 1, j ) ) ...
                               - InverseMain * solution_next_timestep( i,j );
                   Residual = Residual + TemporalVariable * TemporalVariable;

                   % Update the PreviousTemperature array
                   Solution_current_time( i,j ) = solution_next_timestep( i,j );
            end
        end
        Residual = sqrt( InverseNodesNumber * Residual );
    end


end
    

