function [ E ] = approximationError( N_x, N_y,  T_aprox , T_exakt )

    E = sqrt( 1/( N_x * N_y) ) * norm(T_aprox - T_exakt); %norm(X)is same as norm(X,2)

end

