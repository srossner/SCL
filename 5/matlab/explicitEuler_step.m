function [ solution ] = explicitEuler_step( N_x, N_y, dt, solution_previous)

    h_x_p2 = (1/N_x)^2;
    h_y_p2 = (1/N_y)^2;

    solution = zeros(N_x, N_y);
    for i = 2:N_x-1
        for j = 2:N_y-1
            k_x = ( ( solution_previous(i-1, j) - (2 * solution_previous(i, j)) + solution_previous(i + 1, j) ) / h_x_p2 );
            k_y = ( ( solution_previous(i, j-1) - (2 * solution_previous(i, j)) + solution_previous(i, j + 1) ) / h_y_p2 );
            k = k_x + k_y;
            solution(i, j) = solution_previous(i, j) + dt * k;
        end
    end

end

